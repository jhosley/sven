import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: RecordingStore
    @StateObject private var recorder = Recorder()
    @State private var showPermissionAlert = false
    @State private var permissionMessage = ""
    @State private var pulse = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text(timeText)
                    .font(.system(size: 44, weight: .light, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(recorder.isRecording ? .red : .secondary)
                    .padding(.top, 8)

                bigRedButton

                Text(recorder.isRecording ? "Recording… tap to stop" : "Tap to record")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                recordingsList
            }
            .navigationTitle("Red Button")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Permission needed", isPresented: $showPermissionAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(permissionMessage)
            }
            .alert("Recording problem", isPresented: Binding(
                get: { recorder.errorMessage != nil },
                set: { if !$0 { recorder.errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(recorder.errorMessage ?? "")
            }
        }
    }

    private var timeText: String {
        let total = Int(recorder.elapsed)
        return String(format: "%02d:%02d", total / 60, total % 60)
    }

    private var bigRedButton: some View {
        Button(action: tapped) {
            ZStack {
                if recorder.isRecording {
                    Circle()
                        .stroke(Color.red.opacity(0.35), lineWidth: 10)
                        .scaleEffect(pulse ? 1.25 : 1.0)
                        .opacity(pulse ? 0 : 1)
                        .onAppear {
                            pulse = false
                            withAnimation(.easeOut(duration: 1.2).repeatForever(autoreverses: false)) {
                                pulse = true
                            }
                        }
                        .onDisappear { pulse = false }
                }
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color(red: 1.0, green: 0.35, blue: 0.3), Color(red: 0.75, green: 0.0, blue: 0.0)],
                            center: .init(x: 0.35, y: 0.3),
                            startRadius: 10,
                            endRadius: 160
                        )
                    )
                    .overlay(Circle().stroke(Color.white.opacity(0.15), lineWidth: 4))
                    .shadow(color: .red.opacity(0.5), radius: recorder.isRecording ? 28 : 14, y: 8)

                if recorder.isRecording {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width: 72, height: 72)
                } else {
                    Text("REC")
                        .font(.system(size: 56, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 250, height: 250)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .scaleEffect(recorder.isRecording ? 0.96 : 1.0)
        .animation(.spring(duration: 0.25), value: recorder.isRecording)
        .accessibilityLabel(recorder.isRecording ? "Stop recording" : "Start recording")
    }

    private var recordingsList: some View {
        List {
            if store.recordings.isEmpty {
                Text("No recordings yet.")
                    .foregroundStyle(.secondary)
                    .listRowBackground(Color.clear)
            }
            ForEach(store.recordings) { rec in
                NavigationLink(value: rec.id) {
                    RecordingRow(recording: rec)
                }
            }
            .onDelete { store.delete(at: $0) }
        }
        .listStyle(.plain)
        .navigationDestination(for: UUID.self) { id in
            if let rec = store.recordings.first(where: { $0.id == id }) {
                RecordingDetailView(recordingID: rec.id)
            }
        }
    }

    private func tapped() {
        let haptic = UIImpactFeedbackGenerator(style: .heavy)
        haptic.impactOccurred()

        if recorder.isRecording {
            if let result = recorder.stop() {
                store.add(url: result.url, duration: result.duration)
            }
            return
        }

        Task {
            let micOK = await recorder.requestPermission()
            guard micOK else {
                permissionMessage = "Red Button needs the microphone to record."
                showPermissionAlert = true
                return
            }
            // Ask for speech permission up front so transcription can run right after recording.
            let speechOK = await Transcriber.requestAuthorization()
            if !speechOK {
                permissionMessage = "Recording works, but transcripts need Speech Recognition. You can enable it in Settings."
                showPermissionAlert = true
            }
            recorder.start()
        }
    }
}

private struct RecordingRow: View {
    let recording: Recording

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(recording.title).font(.headline)
                Spacer()
                Text(recording.durationText)
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            switch recording.status {
            case .transcribing:
                Label("Transcribing…", systemImage: "waveform")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            case .failed:
                Label(recording.errorMessage ?? "Transcription failed", systemImage: "exclamationmark.triangle")
                    .font(.subheadline)
                    .foregroundStyle(.orange)
                    .lineLimit(2)
            case .done:
                Text(recording.transcript)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView().environmentObject(RecordingStore())
}
