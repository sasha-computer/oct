# Footswitch Integration

Added by an external agent working on `~/Developer/footswitch`. This documents the changes made to Hex to support USB foot pedal push-to-talk.

## What changed

**File:** `Hex/Features/Transcription/TranscriptionFeature.swift`

### Change 1: Added `startFootswitchMonitoringEffect()` to the task merge

```swift
// Before:
return .merge(
  startMeteringEffect(),
  startHotKeyMonitoringEffect(),
  warmUpRecorderEffect()
)

// After:
return .merge(
  startMeteringEffect(),
  startHotKeyMonitoringEffect(),
  startFootswitchMonitoringEffect(),
  warmUpRecorderEffect()
)
```

### Change 2: Added the effect function (after `warmUpRecorderEffect`, before the closing `}` of the `private extension`)

```swift
func startFootswitchMonitoringEffect() -> Effect<Action> {
  .run { send in
    let pedalDown = DistributedNotificationCenter.default().notifications(
      named: Notification.Name("com.footswitch.pedalDown"))
    let pedalUp = DistributedNotificationCenter.default().notifications(
      named: Notification.Name("com.footswitch.pedalUp"))

    await withTaskGroup(of: Void.self) { group in
      group.addTask {
        for await _ in pedalDown {
          await send(.hotKeyPressed)
        }
      }
      group.addTask {
        for await _ in pedalUp {
          await send(.hotKeyReleased)
        }
      }
    }
  }
}
```

## How it works

An external daemon (`~/Developer/footswitch`) intercepts USB foot pedal keypresses via a CGEventTap and posts `DistributedNotificationCenter` notifications:

- `com.footswitch.pedalDown` -- pedal pressed
- `com.footswitch.pedalUp` -- pedal released

Hex listens for these and maps them directly to `.hotKeyPressed` / `.hotKeyReleased` actions, which triggers the same recording flow as the keyboard hotkey.

## Why not key simulation?

We tried simulating fn/globe key events via CGEvent. macOS does not propagate synthetic `flagsChanged` events for the fn key to other apps' CGEventTaps. Since we own both apps, DistributedNotificationCenter IPC is simpler and guaranteed to work.

## Dependencies

- The footswitch daemon must be running (`~/Developer/footswitch/.build/debug/footswitch`)
- No new Swift package dependencies needed -- `DistributedNotificationCenter` is part of Foundation
- No changes to Hex's Info.plist or entitlements

## Build

This project must be built from Xcode (macro trust + signing). The `Hex` scheme, Debug configuration. Cannot be built from `xcodebuild` CLI without signing identity and macro trust setup.

## Status

**Not yet tested.** The code compiles (verified the Swift is valid) but hasn't been built and run yet because Xcode signing is required. Needs a build + test with the footswitch daemon running.
