# Feature Specification: Home and My Page Appbars

**Feature Branch**: `002-mypage-screen`  
**Created**: 2026-04-24  
**Status**: Draft  
**Input**: User description: "Cài đặt appbar của màn hình home như hình trên, còn appbar của màn hình mypage sẽ như hình thứ 2"

## Clarifications

### Session 2026-04-24

- Q: Header Action Behavior Scope → A: Bắt buộc tất cả action hoạt động đầy đủ đúng như web ngay trong feature này.
- Q: Nguồn Chuẩn Cho Hành Vi Từng Action → A: Dùng đúng hành vi của từng action theo bản web hiện tại (web là source of truth).
- Q: Hành Vi Appbar Theo Trạng Thái Đăng Nhập → A: Ẩn bớt action khi chưa đăng nhập.
- Q: Hành Vi Icon Menu Ở My Page → A: Icon menu mở side drawer từ phải.
- Q: Ngưỡng Màn Hình Cho Tiêu Chí “Mobile Supported Widths” → A: 360-430dp.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Home Appbar Visual Match (Priority: P1)

As a mobile user, I want the Home screen header to match the provided design so I can quickly recognize brand identity and access the same top controls as in the reference.

**Why this priority**: Home is the default landing tab. A mismatched header creates immediate visual inconsistency and lowers trust in the app.

**Independent Test**: Open Home tab and verify the top bar includes the same visual structure and control order as the reference (brand area, search prompt field, right-side utility/profile actions).

**Acceptance Scenarios**:

1. **Given** a user opens the Home tab, **When** the first viewport is rendered, **Then** the top header shows brand identity and top controls aligned with the first reference image.
2. **Given** the Home tab is visible, **When** the user views the top bar, **Then** search and action controls are clearly reachable without scrolling.

---

### User Story 2 - My Page Appbar Visual Match (Priority: P1)

As a signed-in user, I want the My Page top area to match the provided design so my account space feels consistent with the expected profile experience.

**Why this priority**: My Page is an account-critical screen. Header mismatch impacts profile credibility and perceived product quality.

**Independent Test**: Open My Page tab and verify the top section layout matches the second reference image, including profile-leading composition and right-side top action.

**Acceptance Scenarios**:

1. **Given** a user opens My Page, **When** the first viewport is rendered, **Then** the top section follows the second reference layout with profile emphasis and a top-right action icon.
2. **Given** My Page is visible, **When** the user scans the header area, **Then** account identity and header controls are immediately discoverable.

---

### User Story 3 - Cross-Tab Header Consistency (Priority: P2)

As a user navigating between Home and My Page, I want each tab header style to be intentionally different but internally consistent with its purpose so navigation feels coherent.

**Why this priority**: The two headers should not look identical, but each should clearly support its tab’s primary job (discovery vs. personal account).

**Independent Test**: Switch repeatedly between Home and My Page and verify each header keeps stable structure and spacing without layout jumps.

**Acceptance Scenarios**:

1. **Given** a user switches between Home and My Page, **When** each tab loads, **Then** the correct header variant appears every time without flicker or overlap.
2. **Given** different device widths are used, **When** headers are displayed, **Then** controls remain visible and usable in both tabs.

### Edge Cases

- What happens when the display width is narrow and long usernames or localized labels would push header actions out of view?
- How does the system handle missing profile image or missing display name in the My Page header while preserving the intended layout?
- What happens when the Home search prompt text is long in localization and could overflow the available top bar space?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST present a Home tab top appbar that visually matches the first provided reference, including brand area, search entry surface, and two right-side action controls.
- **FR-002**: System MUST preserve the order and grouping of Home appbar elements so users can identify the same interaction zones as the reference.
- **FR-003**: System MUST present a My Page top appbar/profile header area that visually matches the second provided reference, including profile-focused top composition and a right-side menu action.
- **FR-004**: System MUST maintain readable and tappable header controls in both Home and My Page across supported mobile screen sizes.
- **FR-005**: System MUST gracefully handle absent profile data in My Page header (for example missing avatar or nickname) without breaking layout structure.
- **FR-006**: System MUST ensure the two header variants remain stable during tab switches and do not render the wrong header on either tab.
- **FR-007**: Users MUST be able to access Home header actions and My Page header action directly from the first visible viewport without extra navigation steps.
- **FR-008**: System MUST implement full behavior for all appbar actions shown on Home and My Page in this feature scope, matching the corresponding outcomes expected from the reference product experience.
- **FR-009**: System MUST treat the current web product behavior as the source of truth for each Home/My Page appbar action, including navigation target and interaction result.
- **FR-010**: System MUST hide protected appbar actions for unauthenticated users while preserving stable header layout and non-protected actions.
- **FR-011**: System MUST open a right-side drawer when the My Page menu icon is activated, and the drawer MUST expose account-related actions consistent with the web behavior baseline.
- **FR-012**: System MUST preserve Home and My Page appbar readability, tappability, and non-overlap across mobile viewport widths from 360dp to 430dp.

### Key Entities *(include if feature involves data)*

- **Header Variant**: A tab-specific top section definition for Home or My Page, including element order, visual hierarchy, and action placement.
- **Header Action**: A top-level interactive control in the appbar/profile header area, such as search entry trigger, utility action, account action, or menu action.
- **Profile Header Data**: User-facing identity information displayed in the My Page top section (for example avatar and display name) with fallback behavior when missing.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In design QA, 100% of mandatory header elements shown in each provided reference are present on the corresponding tab.
- **SC-002**: In manual test runs across supported mobile widths, 100% of header actions remain visible and tappable without overlap on Home and My Page.
- **SC-003**: In tab-switch testing (minimum 20 consecutive switches), the correct header variant appears on the correct tab with zero visual cross-over incidents.
- **SC-004**: In acceptance review, stakeholders confirm that Home and My Page top areas match the intended reference compositions without requesting structural rework.
- **SC-005**: In functional QA, 100% of appbar actions shown in both reference headers execute their intended behavior successfully on first tap.
- **SC-006**: In authentication-state QA, protected appbar actions are hidden for unauthenticated users with zero accidental exposure cases.
- **SC-007**: In interaction QA, activating the My Page menu icon opens the right-side drawer successfully in 100% of test attempts.
- **SC-008**: In responsive QA across 360dp, 390dp, and 430dp widths, no appbar element overlap or truncation-driven action loss is observed.

## Assumptions

- The scope includes both visual/header structure and full behavior of all appbar actions shown in the references for Home and My Page.
- Existing bottom navigation and tab routing behavior remain unchanged.
- Existing account/session state logic remains unchanged; this feature only aligns top UI composition with references.
- Existing localization keys are reused where possible, with text truncation/overflow handling applied to preserve layout.
- Web behavior definitions for appbar actions are available and testable as the canonical baseline during implementation and QA.
- Mobile supported widths for this feature’s acceptance scope are 360dp to 430dp.
