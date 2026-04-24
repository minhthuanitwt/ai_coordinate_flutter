# Contract: My Page Feature Interfaces

## Scope

This contract defines internal interfaces between presentation and data layers
for the Flutter My Page feature.

## Repository Contract

### `MyPageRepository`

```dart
abstract class MyPageRepository {
  Future<MyPageProfile> getMyProfile({required String userId});
  Future<MyPageStats> getMyStats({required String userId});
  Future<MyPageBalance> getMyBalance({required String userId});
  Future<List<MyPageImageItem>> listMyImages({
    required String userId,
    int limit = 20,
    int offset = 0,
  });
}
```

## Error Contract

- Repository methods throw typed feature exceptions (for example
  `MyPageRepositoryException`) with machine-readable `code` values.
- Minimum error codes:
  - `supabase_not_configured`
  - `unauthorized`
  - `network_error`
  - `unknown_error`

## Presentation Contract

### `MyPageViewModel`

- Owns a `MyPageState` state object (Freezed).
- Exposes at least:
  - `Future<void> loadInitial()`
  - `Future<void> refresh()`
  - `Future<void> loadMoreImages()`
  - `void clearError()`

### `MyPagePage`

- Must render section blocks in this order:
  1. Profile header
  2. Stats
  3. Balance summary
  4. Image gallery
- Must render explicit loading/error/empty/success states.
- Must not duplicate shell-level auth gate logic; relies on existing protected
  tab behavior.

## Data Mapping Contract (Web Parity Reference)

Reference source:
`/Users/dongdm/Develop/Source/doi/ai_coordinate/app/(app)/my-page/page.tsx`

Expected parity at section level:
- `CachedMyPageProfileHeader` -> Flutter profile header block
- `CachedMyPageUserStats` -> Flutter stats block
- `CachedMyPagePercoinBalance` -> Flutter balance block
- `CachedMyPageImageGallery` -> Flutter image gallery block
