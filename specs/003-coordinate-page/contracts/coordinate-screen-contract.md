# Contract: Coordinate Screen Behavior

## Purpose

Define required user-visible behavior and acceptance contract for Coordinate screen.

## Route Access Contract

- Coordinate route is protected.
- If user is unauthenticated:
  - App redirects immediately to Login.
  - Return target is preserved as Coordinate.
- If user authenticates successfully from Login:
  - App navigates back to Coordinate route.

## Generation Input Contract

- Required inputs:
  - source image (upload or stock)
  - prompt text
  - generation settings (background mode, model tier, output count)
- Validation:
  - prompt must be non-empty and within configured max length.
  - upload mode accepts only `jpg/jpeg`, `png`, `webp`.
  - upload file size must be <= 10MB.
  - source mode switch invalidates stale selection from previous mode.
- Invalid input must block submit and show clear error feedback.

## Billing Contract

- Estimated percoin cost is visible before submit and updates with count/model changes.
- Percoin charge is applied only for successfully completed outputs.
- Failed outputs do not consume percoin.
- Insufficient balance flow shows actionable feedback and purchase entry path.

## Result Gallery Contract

- In-progress jobs can provide preview/progress representation.
- Completed outputs are added to gallery/history without full page reload.
- Gallery supports incremental loading as user scrolls.
- Merge strategy must avoid duplicate images by stable identity.
