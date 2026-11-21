import Speech

enum TranscriberError: LocalizedError {
    case notAuthorized
    case unavailable
    case empty

    var errorDescription: String? {
        switch self {
        case .notAuthorized: return "Speech recognition isn't allowed. Enable it in Settings."
        case .unavailable: return "Speech recognition isn't available right now."
        case .empty: return "No speech was detected."
        }
    }
}

/// Transcribes an audio file with Apple's Speech framework.
/// Prefers on-device recognition (no length limit, works offline) and falls back to
/// Apple's servers, which only accept clips of roughly one minute.
enum Transcriber {
    static func requestAuthorization() async -> Bool {
        await withCheckedContinuation { cont in
            SFSpeechRecognizer.requestAuthorization { status in
                cont.resume(returning: status == .authorized)
            }
        }
    }

    static func transcribe(fileAt url: URL) async throws -> String {
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
            throw TranscriberError.notAuthorized
        }
        guard let recognizer = SFSpeechRecognizer(locale: Locale.current) ?? SFSpeechRecognizer(),
              recognizer.isAvailable else {
            throw TranscriberError.unavailable
        }

        if recognizer.supportsOnDeviceRecognition {
            do {
                return try await run(recognizer, url: url, onDevice: true)
            } catch {
                // Fall through and try the server path.
            }
        }
        return try await run(recognizer, url: url, onDevice: false)
    }

    private static func run(_ recognizer: SFSpeechRecognizer, url: URL, onDevice: Bool) async throws -> String {
        let request = SFSpeechURLRecognitionRequest(url: url)
        request.shouldReportPartialResults = false
        request.addsPunctuation = true
        request.requiresOnDeviceRecognition = onDevice

        return try await withCheckedThrowingContinuation { cont in
            var finished = false
            recognizer.recognitionTask(with: request) { result, error in
                guard !finished else { return }
                if let error {
                    finished = true
                    cont.resume(throwing: error)
                    return
                }
                if let result, result.isFinal {
                    finished = true
                    let text = result.bestTranscription.formattedString
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    if text.isEmpty {
                        cont.resume(throwing: TranscriberError.empty)
                    } else {
                        cont.resume(returning: text)
                    }
                }
            }
        }
    }
}
