# Oct – Local Agent Skill

## After making code changes

Run this to rebuild and relaunch Oct locally:

```bash
bash scripts/reload.sh
```

This builds the Debug scheme into `.build/xcode`, kills the running instance, and relaunches it.

## Versioning

Oct uses its own version scheme, independent of upstream Hex.
Current version lives in `Oct.xcodeproj/project.pbxproj` as `MARKETING_VERSION`.
Build number is `CURRENT_PROJECT_VERSION`.

To bump the version manually:
```bash
sed -i '' 's/MARKETING_VERSION = X.Y.Z/MARKETING_VERSION = A.B.C/g' Oct.xcodeproj/project.pbxproj
```

Version is shown in:
- Menu bar dropdown (top item)
- Settings → About

## Project layout

- Features: `Oct/Features/`
- Settings model: `OctCore/Sources/OctCore/Settings/OctSettings.swift`
- Menu bar entry: `Oct/App/OctApp.swift`
- Reload script: `scripts/reload.sh`
