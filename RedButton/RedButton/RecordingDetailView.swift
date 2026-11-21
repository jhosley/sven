import SwiftUI

struct RecordingDetailView: View {
    let recordingID: UUID
    @EnvironmentObject private var store: RecordingStore
    @StateObject private var player = AudioPlayer()
    @Environment(\.dismiss) private var dismiss
    @State private var confirmDelete = false

    private var recording: Recording? {
        store.recordings.first { $0.id == recordingID }
    }

    var body: some View {
        if let rec = recording {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 16) {
                        Button {
                            player.toggle(url: rec.url)
                        } label: {
                            Label(player.isPlaying ? "Stop" : "Play",
                                  systemImage: player.isPlaying ? "stop.fill" : "play.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)

                        Text(rec.durationText)
                            .font(.title3.monospacedDigit())
                            .foregroundStyle(.secondary)
                    }

                    Divider()

                    switch rec.status {
                    case .transcribing:
                        HStack {
                            ProgressView()
                            Text("Transcribing…").foregroundStyle(.secondary)
                        }
                    case .failed:
                        VStack(alignment: .leading, spacing: 8) {
                            Label(rec.errorMessage ?? "Transcription failed", systemImage: "exclamationmark.triangle")
                                .foregroundStyle(.orange)
                            Button("Try again") { store.retryTranscription(rec) }
                                .buttonStyle(.bordered)
                        }
                    case .done:
                        Text(rec.transcript)
                            .textSelection(.enabled)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .navigationTitle(rec.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if rec.status == .done {
                        Button {
                            UIPasteboard.general.string = rec.transcript
                        } label: {
                            Image(systemName: "doc.on.doc")
                        }
                        .accessibilityLabel("Copy transcript")
                        ShareLink(items: [rec.url, rec.transcriptURL]) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    } else {
                        ShareLink(item: rec.url) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    Button(role: .destructive) {
                        confirmDelete = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .confirmationDialog("Delete this recording?", isPresented: $confirmDelete, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    player.stop()
                    store.delete(rec)
                    dismiss()
                }
            }
            .onDisappear { player.stop() }
        } else {
            Text("Recording not found.").foregroundStyle(.secondary)
        }
    }
}
