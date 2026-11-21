import AVFoundation
import Combine

/// Wraps AVAudioRecorder. Records mono AAC (.m4a) into the app's Documents/Recordings folder.
final class Recorder: NSObject, ObservableObject, AVAudioRecorderDelegate {
    @Published private(set) var isRecording = false
    @Published private(set) var elapsed: TimeInterval = 0
    @Published var errorMessage: String?

    private var recorder: AVAudioRecorder?
    private var timer: Timer?
    private var startDate: Date?

    func requestPermission() async -> Bool {
        await AVAudioApplication.requestRecordPermission()
    }

    /// Starts a new recording. Returns false (and sets errorMessage) if it couldn't start.
    @discardableResult
    func start() -> Bool {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true, options: [])
        } catch {
            errorMessage = "Couldn't set up audio: \(error.localizedDescription)"
            return false
        }

        let url = RecordingStore.recordingsDirectory.appendingPathComponent(Self.newFileName())
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44_100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            let r = try AVAudioRecorder(url: url, settings: settings)
            r.delegate = self
            r.isMeteringEnabled = false
            guard r.record() else {
                errorMessage = "Recorder refused to start."
                return false
            }
            recorder = r
        } catch {
            errorMessage = "Couldn't create recorder: \(error.localizedDescription)"
            return false
        }

        startDate = Date()
        elapsed = 0
        isRecording = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            guard let self, let start = self.startDate else { return }
            self.elapsed = Date().timeIntervalSince(start)
        }
        return true
    }

    /// Stops the current recording and returns where it was saved plus its length.
    func stop() -> (url: URL, duration: TimeInterval)? {
        guard let r = recorder else { return nil }
        let duration = r.currentTime
        r.stop()
        recorder = nil
        timer?.invalidate()
        timer = nil
        isRecording = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        return (r.url, duration)
    }

    // MARK: AVAudioRecorderDelegate

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        errorMessage = "Recording error: \(error?.localizedDescription ?? "unknown")"
        _ = stop()
    }

    private static func newFileName() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        return "Recording \(f.string(from: Date())).m4a"
    }
}
