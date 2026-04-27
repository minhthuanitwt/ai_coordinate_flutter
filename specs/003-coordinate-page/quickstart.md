# Quickstart: Coordinate Page

## 1. Prerequisites

- Flutter SDK `3.38.9`
- Dart SDK `^3.10.0`
- Dependencies installed:

```bash
cd .
fvm flutter pub get
```

## 2. Run app locally

```bash
cd .
fvm flutter run
```

## 3. Implement scope

- Build CoordinatePage authenticated entry behavior with login redirect + return path.
- Implement generation form controls: source mode, source type, prompt, background mode, model tier, count.
- Apply upload validation (JPG/PNG/WebP <= 10MB).
- Show estimated percoin cost and enforce plan-limited count selection behavior.
- Implement async generation job state UI and in-progress recovery on re-entry.
- Apply 90-second polling timeout with "still processing" state and resume behavior.
- Render generated history with incremental pagination and duplicate-safe merges.

## 4. Regenerate artifacts when required

- Localization updates:

```bash
fvm dart run slang
```

- Freezed/router/build-runner sources changed:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

## 5. Verification checklist

```bash
fvm dart analyze lib test
```

Manual runtime checks:

- Unauthenticated user entering Coordinate is redirected to Login, then returns to Coordinate after login.
- Missing prompt/source image prevents submit with clear feedback.
- Upload rejects unsupported file type and file >10MB.
- Estimated percoin cost updates when model tier/count changes.
- Plan-restricted count options do not submit invalid values.
- Failed jobs do not reduce percoin balance; successful jobs do.
- Leaving Coordinate during active jobs and returning resumes tracking.
- Polling timeout at 90 seconds switches to still-processing state and recovers on re-entry.
- Gallery loads next page on scroll and does not duplicate existing items.

## 6. Completion target

Ready for `/speckit.tasks` once verification checks pass and behavior matches all clarified requirements in `spec.md`.

## 7. Implementation Verification Log (2026-04-27)

- Localization regeneration: `fvm dart run slang` -> pass.
- Code generation: `fvm dart run build_runner build --delete-conflicting-outputs` -> pass.
- Static analysis: `fvm dart analyze lib test` -> pass (No issues found).
- Test suite: `fvm flutter test` -> pass (All tests passed).
