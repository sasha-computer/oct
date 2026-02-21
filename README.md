# Oct — Voice → Text

A personal fork of [Hex](https://github.com/kitlangton/Hex) with two additions:

**Auto Submit** — after pasting, Oct can automatically send a keystroke. Configurable in General settings: Off / Enter / ⌘ Enter / ⇧ Enter.

**Foot Pedal** — enable "Use Foot Pedal as Additional Toggle" in the Hot Key section to trigger recording with a USB foot pedal alongside your keyboard shortcut. Built into the app; no daemon needed.

## Development

Commits automatically rebuild and relaunch Oct via a post-commit hook. A macOS notification fires when the build finishes.
