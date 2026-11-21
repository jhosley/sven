import Foundation
import Combine

struct Recording: Identifiable, Codable, Equatable {
    enum Status: String, Codable {
        case transcribing, done, failed
    }

    let id: UUID
    let fileName: String
    let createdAt: Date
    let duration: TimeInterval
    var transcript: String
    var status: Status
    var errorMessage: String?

    var url: URL { RecordingStore.recordingsDirectory.appendingPathComponent(fileName) }
    var transcriptURL: URL {
        RecordingStore.recordingsDirectory
            .appendingPathComponent((fileName as NSString).deletingPathExtension)
            .appendingPathExtension("txt")
    }

    var title: String {
        createdAt.formatted(date: .abbreviated, time: .shortened)
    }

    var durationText: String {
        let total = Int(duration.rounded())
        let m = total / 60, s = total % 60
        return String(format: "%d:%02d", m, s)
    }
}

/// Owns the list of recordings, persists it as JSON in Documents, and runs transcription.
@MainActor
final class RecordingStore: ObservableObject {
    @Published private(set) var recordings: [Recording] = []

    static let recordingsDirectory: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dir = docs.appendingPathComponent("Recordings", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    private static let indexURL = recordingsDirectory.appendingPathComponent("index.json")

    init() {
        load()
        // Anything left mid-transcription by a previous launch gets retried.
        for r in recordings where r.status == .transcribing {
            transcribe(r.id)
        }
    }

    func add(url: URL, duration: TimeInterval) {
        let rec = Recording(
            id: UUID(),
            fileName: url.lastPathComponent,
            createdAt: Date(),
            duration: duration,
            transcript: "",
            status: .transcribing,
            errorMessage: nil
        )
        recordings.insert(rec, at: 0)
        save()
        transcribe(rec.id)
    }

    func retryTranscription(_ rec: Recording) {
        update(rec.id) { $0.status = .transcribing; $0.errorMessage = nil }
        transcribe(rec.id)
    }

    func delete(_ rec: Recording) {
        try? FileManager.default.removeItem(at: rec.url)
        try? FileManager.default.removeItem(at: rec.transcriptURL)
        recordings.removeAll { $0.id == rec.id }
        save()
    }

    func delete(at offsets: IndexSet) {
        for i in offsets { delete(recordings[i]) }
    }

    // MARK: - Private

    private func transcribe(_ id: UUID) {
        guard let rec = recordings.first(where: { $0.id == id }) else { return }
        Task {
            do {
                let text = try await Transcriber.transcribe(fileAt: rec.url)
                try? text.write(to: rec.transcriptURL, atomically: true, encoding: .utf8)
                update(id) { $0.transcript = text; $0.status = .done; $0.errorMessage = nil }
            } catch {
                update(id) { $0.status = .failed; $0.errorMessage = error.localizedDescription }
            }
        }
    }

    private func update(_ id: UUID, _ change: (inout Recording) -> Void) {
        guard let i = recordings.firstIndex(where: { $0.id == id }) else { return }
        change(&recordings[i])
        save()
    }

    private func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(recordings) {
            try? data.write(to: Self.indexURL, options: .atomic)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: Self.indexURL) else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let list = try? decoder.decode([Recording].self, from: data) {
            // Drop entries whose audio file is gone.
            recordings = list.filter { FileManager.default.fileExists(atPath: $0.url.path) }
        }
    }
}
