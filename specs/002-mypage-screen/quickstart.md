# Quickstart: Home and My Page Appbars

## 1. Prerequisites

- Flutter SDK per project config (`3.38.9`)
- Dart SDK per project config (`^3.10.0`)
- Dependencies installed (`fvm flutter pub get`)

## 2. Run app locally

```bash
cd .
fvm flutter run
```

## 3. Implement scope

- Update Home top appbar to match reference composition.
- Update My Page top header/appbar to match reference composition.
- Wire all appbar actions to web-aligned outcomes.
- Hide protected actions when unauthenticated.
- Implement My Page menu to open right-side drawer.

## 4. Regenerate artifacts when needed

- If localization keys change:
```bash
fvm dart run slang
```
- If route or code generation sources change:
```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

## 5. Verification checklist

```bash
fvm dart analyze lib
```

Manual runtime checks:

- Home appbar regions appear in expected order (brand/search/actions).
- My Page header and top-right menu render as expected.
- All visible appbar actions execute intended behavior on first tap.
- In unauthenticated state, protected appbar actions are hidden.
- My Page menu icon opens right-side drawer consistently.
- At 360dp, 390dp, 430dp widths:
  - No overlap
  - No hidden/lost actions
  - Controls remain tappable
- Switching Home <-> My Page repeatedly does not cause header flicker/crossover.

## 6. Implementation Verification Log (2026-04-24)

- Static analysis: `fvm dart analyze lib` -> pass.
- Localization regeneration: `fvm dart run slang` -> pass.
- Manual runtime QA:
  - Pending final device/emulator pass for SC-001..SC-008.
  - Required checks remain the bullet list above.

## 7. Completion target

Ready for `/speckit.tasks` when all checks above pass and behavior matches web baseline.
