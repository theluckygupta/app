# Arrow Puzzle (Flutter)

A small cross-platform prototype inspired by “Arrow Puzzle”, built with Flutter so it runs on **iOS** and **Android** from one codebase.

## Gameplay loop
- You have a square board of arrow tiles.
- Tap a tile to rotate it clockwise.
- Start (`S`) and Goal (`G`) are fixed.
- The puzzle is solved when following arrows from Start reaches Goal.

## Run locally
1. Install Flutter (stable channel).
2. Run:
   ```bash
   flutter pub get
   flutter run
   ```
3. Choose an iOS simulator / Android emulator or physical device.

## Test
```bash
flutter test
```

## Next steps
- Add multiple levels and level progression.
- Add timed mode, stars, and hints.
- Add rewarded ad + in-app purchase integration.
- Save progress locally with `shared_preferences`.
- Replace icon arrows with custom art/animations.
