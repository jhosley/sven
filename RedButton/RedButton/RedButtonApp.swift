import SwiftUI

@main
struct RedButtonApp: App {
    @StateObject private var store = RecordingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .onAppear {
                    // Keep the screen (and the button) on while the app is open.
                    UIApplication.shared.isIdleTimerDisabled = true
                }
        }
    }
}
