# Red Button

One big red button. Tap it to record, tap again to stop. The audio is saved on
the phone and transcribed to text automatically. That's it.

- Recording: `AVAudioRecorder`, mono AAC `.m4a`, 44.1 kHz.
- Transcription: Apple's Speech framework, on-device when the phone supports it
  (no length limit, works offline). No accounts, no API keys, nothing leaves the
  phone unless on-device recognition isn't available for your language.
- The screen stays on while the app is open, so the button is always there.
- Recordings keep going if the phone locks (background audio mode).
- Files live in the app's Documents folder, so they show up in the Files app
  under **On My iPhone > Red Button > Recordings** as `.m4a` + `.txt` pairs.
- Each recording has a detail screen: play, copy transcript, share, delete.
  Swipe left on a row to delete.

## Putting it on your iPhone

You need a Mac with Xcode 15 or newer.

1. Open `RedButton.xcodeproj` in Xcode.
2. Click the **RedButton** project in the sidebar, then the **RedButton** target,
   then **Signing & Capabilities**. Pick your Apple ID under **Team**. If the
   bundle ID complains, change `com.jhosley.redbutton` to anything unique.
3. Plug in your iPhone, pick it in the device menu at the top, press Run.
4. First launch: on the phone go to **Settings > General > VPN & Device
   Management** and trust your developer certificate.

With a free Apple ID the install expires after 7 days and you re-run from
Xcode. With a paid developer account ($99/yr) it lasts a year, or you can push
it through TestFlight.

## Permissions

On first tap the app asks for Microphone and Speech Recognition. Deny speech and
it still records, you just won't get transcripts.
