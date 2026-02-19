# Oct — Voice → Text

A personal fork of [Hex](https://github.com/kitlangton/Hex) by Kit Langton, with a few extra settings added for my own workflow.

Press and hold a hotkey (or foot pedal) to transcribe your voice and paste the result wherever you're typing. All processing happens on-device — nothing leaves your Mac.

> Apple Silicon only. macOS 14+.

## What's different from upstream Hex

### Auto Submit

After transcription is pasted, Oct can automatically send a keystroke to submit the text — useful in chat apps, Claude, etc. Configurable in **General → Auto Submit**:

- **Off** — paste and stop (default)
- **Enter** — send Return after pasting
- **⌘ Enter** — send Command+Return
- **⇧ Enter** — send Shift+Return

### Foot Pedal Support

USB foot pedals are recognised as a recording trigger. Enable **Use Foot Pedal as Additional Toggle** in the **Hot Key** section. The pedal works exactly like the hotkey: press to start recording, release to transcribe. It's additive — your keyboard hotkey still works alongside it.

Detection is built into the app via a CGEventTap; no separate daemon required.

## Settings reference

### Hot Key

| Setting | Description |
|---|---|
| Hot key | Global shortcut to trigger recording. Modifier-only (e.g. Option) or modifier+key. |
| Use double-tap only | Lock recording on double-tap; tap again to stop. |
| Ignore below Xs | For modifier-only hotkeys: discard presses shorter than this threshold (0–2 s). |
| Use Foot Pedal as Additional Toggle | Treat a USB foot pedal as a second recording trigger. |

### General

| Setting | Description |
|---|---|
| Open on Login | Launch Oct at login. |
| Show Dock Icon | Show/hide the Dock icon (Oct lives in the menu bar). |
| Use clipboard to insert | Fast paste via clipboard. Turn off to use simulated keypresses instead (slower, clipboard-safe). |
| Copy to clipboard | Also copy the transcription text to the clipboard after pasting. |
| Auto Submit | Keystroke to send after pasting: Off / Enter / ⌘ Enter / ⇧ Enter. |
| Prevent System Sleep while Recording | Keep the Mac awake during recording sessions. |
| Audio Behavior while Recording | Pause media / mute volume / do nothing while the mic is active. |

### History

| Setting | Description |
|---|---|
| Save Transcription History | Persist transcriptions and audio for later review. |
| Maximum History Entries | Cap on stored entries (Unlimited / 50 / 100 / 200 / 500 / 1000). |
| Paste Last Transcript | Hotkey to instantly re-paste the most recent transcription. |

### Model

Default is **Parakeet TDT v3** via [FluidAudio](https://github.com/FluidInference/FluidAudio) — fast and multilingual. WhisperKit models (Tiny / Base / Large v3) are also available. All models run on-device via Core ML.

## Building

```bash
# Open in Xcode
open Oct.xcodeproj

# Or build from the command line
xcodebuild -scheme Oct -configuration Release
```

Requires Xcode 15+.

## License

MIT. See `LICENSE`.
