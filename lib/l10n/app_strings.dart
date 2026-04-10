import 'package:flutter/material.dart';

class AppStrings {
  const AppStrings._(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('vi')];

  static AppStrings of(BuildContext context) {
    final strings = Localizations.of<AppStrings>(context, AppStrings);
    assert(strings != null, 'AppStrings is not available in the widget tree.');
    return strings!;
  }

  static const _localizedValues = {
    'en': _StringsData(
      appName: 'ai_coordinate_flutter',
      loading: 'Loading',
      shellSubtitle: 'Coordinate your AI workflow across one lightweight app.',
      shellHeaderTitle: 'Today on ai_coordinate_flutter',
      footerTagline:
          'Phase-1 Flutter shell mirrored from the reference Next.js product.',
      defaultUserLabel: 'creator',
      navHome: 'Home',
      navCoordinate: 'Coordinate',
      navChallenge: 'Challenge',
      navNotifications: 'Notifications',
      navMyPage: 'My Page',
      homeHeadline: 'Create, coordinate, and ship from one place.',
      homeLead:
          'A mobile-first public discovery surface inspired by the Next.js reference: live banners, posted images, and one shared navigation shell.',
      homeFeedTitle: 'Latest updates',
      homeFeedAction: 'See all',
      homeBannerChip: 'Featured',
      homeBannerFallbackTitle: 'Open the latest highlight',
      homeFeedMissingPreview:
          'This post is available without a prompt or caption preview yet.',
      homeConfigTitle: 'Supabase configuration required',
      homeConfigBody:
          'Home now reads live banners and public posts from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.',
      homeErrorTitle: 'Unable to load Home',
      homeErrorBody:
          'The app could not fetch banners or public posts right now. Try again shortly.',
      homeEmptyTitle: 'Nothing to show yet',
      homeEmptyBody:
          'There are no active banners or posted images available right now.',
      homeLinkUnavailable:
          'This destination is not available inside the Flutter app yet.',
      homeLinkError: 'Unable to open the selected banner link.',
      homePostedAtLabel: 'Posted',
      homeCreatorLabel: 'Creator',
      homeViewsLabel: 'Views',
      loginTitle: 'Welcome back',
      loginSubtitleConfigured:
          'Sign in with your Supabase account to continue into protected spaces.',
      loginSubtitleMock:
          'Supabase is not configured in this build yet. Sign in uses local demo state so the shell can be reviewed end-to-end.',
      signupTitle: 'Create your account',
      signupSubtitle:
          'Start with email and password. This phase mirrors the reference auth entry points first.',
      loginButton: 'Sign in',
      signUpButton: 'Create account',
      signOutButton: 'Sign out',
      signUpCta: 'Sign up',
      loginCta: 'Log in',
      loginFooterPrompt: 'Need an account?',
      signupFooterPrompt: 'Already have an account?',
      emailLabel: 'Email',
      emailHint: 'name@example.com',
      passwordLabel: 'Password',
      passwordHint: 'At least 8 characters',
      confirmPasswordLabel: 'Confirm password',
      passwordRule: 'Use at least 8 characters for this phase-1 auth flow.',
      passwordMismatch: 'Password confirmation does not match.',
      signupSuccess:
          'Account created. Continue to sign in and review the protected areas.',
      authMissingFields: 'Enter email and password before continuing.',
      authSignInFailed:
          'Sign in failed. Verify your credentials and try again.',
      authAlternativeActions: 'Social sign-in placeholders',
      googlePlaceholder: 'Google',
      applePlaceholder: 'Apple',
      shellSignedInPrefix: 'Signed in as',
      shellSignedOutConfigured:
          'Signed out. Protected sections will ask for Supabase authentication.',
      shellSignedOutMock:
          'Signed out. Protected sections will use local demo auth until Supabase is wired.',
      coordinateTitle: 'Coordinate workspace',
      coordinateDescription:
          'This protected area will host collaboration lanes, initiative tracking, and shared execution views.',
      coordinateBadge: 'Protected preview',
      coordinateBoardTitle: 'Coordinate outputs',
      coordinateBoardSubtitle:
          'Review your latest coordinate generations from Supabase in one owner-facing board.',
      coordinateSummaryTitle: 'Your latest coordinate library',
      coordinateSummaryCountPrefix: 'Items loaded',
      coordinatePostedBadge: 'Posted',
      coordinateDraftBadge: 'Draft',
      coordinatePromptLabel: 'Prompt',
      coordinateMissingPrompt: 'No prompt was saved for this item.',
      coordinateCreatedAtLabel: 'Created',
      coordinateModelLabel: 'Model',
      coordinateSourceLabel: 'Source stock',
      coordinateEmptyTitle: 'No coordinate items yet',
      coordinateEmptyBody:
          'Generate or sync your first coordinate output in Supabase, then return here to manage it.',
      coordinateErrorTitle: 'Unable to load coordinate items',
      coordinateErrorBody:
          'The board could not fetch your latest items right now. Try again in a moment.',
      coordinateConfigTitle: 'Supabase configuration required',
      coordinateConfigBody:
          'This board reads live data from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.',
      retryButton: 'Try again',
      loadMoreButton: 'Load more',
      challengeTitle: 'Challenge board',
      challengeDescription:
          'This protected page is reserved for challenge campaigns, submissions, and progress checkpoints.',
      challengeBadge: 'Members only',
      notificationsTitle: 'Notifications center',
      notificationsDescription:
          'This section will collect alerts, event updates, and collaboration signals in one mobile-first view.',
      notificationsBadge: 'Realtime ready',
      myPageTitle: 'My page',
      myPageDescription:
          'This protected profile area will surface account details, creator identity, and activity snapshots.',
      myPageBadge: 'Account space',
      authRedirecting: 'Redirecting to sign in...',
    ),
    'vi': _StringsData(
      appName: 'ai_coordinate_flutter',
      loading: 'Dang tai',
      shellSubtitle:
          'Dieu phoi workflow AI trong mot ung dung gon nhe duy nhat.',
      shellHeaderTitle: 'Hom nay tren ai_coordinate_flutter',
      footerTagline:
          'Flutter shell phase 1 duoc port theo app Next.js tham chieu.',
      defaultUserLabel: 'creator',
      navHome: 'Home',
      navCoordinate: 'Coordinate',
      navChallenge: 'Challenge',
      navNotifications: 'Notifications',
      navMyPage: 'My Page',
      homeHeadline: 'Tao, dieu phoi va dua san pham ra ngoai trong mot noi.',
      homeLead:
          'Be mat discovery public mobile-first cho Flutter lay cam hung tu app Next.js: banner that, posted images that va app shell thong nhat.',
      homeFeedTitle: 'Cap nhat moi',
      homeFeedAction: 'Xem tat ca',
      homeBannerChip: 'Noi bat',
      homeBannerFallbackTitle: 'Mo diem nhan moi nhat',
      homeFeedMissingPreview:
          'Post nay hien chua co preview prompt hoac caption.',
      homeConfigTitle: 'Can cau hinh Supabase',
      homeConfigBody:
          'Home nay doc banner va public post du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.',
      homeErrorTitle: 'Khong tai duoc Home',
      homeErrorBody:
          'Ung dung chua the lay banner hoac public post luc nay. Thu lai sau it phut.',
      homeEmptyTitle: 'Hien chua co noi dung',
      homeEmptyBody:
          'Hien khong co active banner nao hoac posted image nao de hien thi.',
      homeLinkUnavailable: 'Dich den nay chua san sang ben trong Flutter app.',
      homeLinkError: 'Khong mo duoc link banner da chon.',
      homePostedAtLabel: 'Dang luc',
      homeCreatorLabel: 'Creator',
      homeViewsLabel: 'Luot xem',
      loginTitle: 'Chao mung quay lai',
      loginSubtitleConfigured:
          'Dang nhap bang tai khoan Supabase de vao cac khu vuc can xac thuc.',
      loginSubtitleMock:
          'Ban build nay chua cau hinh Supabase. Dang nhap se dung state local de co the review toan bo shell.',
      signupTitle: 'Tao tai khoan',
      signupSubtitle:
          'Bat dau voi email va mat khau. Phase nay uu tien mirror cac diem vao auth tu app tham chieu.',
      loginButton: 'Dang nhap',
      signUpButton: 'Tao tai khoan',
      signOutButton: 'Dang xuat',
      signUpCta: 'Dang ky',
      loginCta: 'Dang nhap',
      loginFooterPrompt: 'Chua co tai khoan?',
      signupFooterPrompt: 'Da co tai khoan?',
      emailLabel: 'Email',
      emailHint: 'name@example.com',
      passwordLabel: 'Mat khau',
      passwordHint: 'It nhat 8 ky tu',
      confirmPasswordLabel: 'Xac nhan mat khau',
      passwordRule: 'Dung it nhat 8 ky tu cho auth flow phase 1 nay.',
      passwordMismatch: 'Mat khau xac nhan khong khop.',
      signupSuccess:
          'Da tao tai khoan. Tiep tuc dang nhap de xem cac khu vuc can xac thuc.',
      authMissingFields: 'Nhap email va mat khau truoc khi tiep tuc.',
      authSignInFailed: 'Dang nhap that bai. Kiem tra thong tin va thu lai.',
      authAlternativeActions: 'Placeholder cho social sign-in',
      googlePlaceholder: 'Google',
      applePlaceholder: 'Apple',
      shellSignedInPrefix: 'Dang dang nhap voi',
      shellSignedOutConfigured:
          'Dang xuat. Cac khu vuc protected se yeu cau xac thuc Supabase.',
      shellSignedOutMock:
          'Dang xuat. Cac khu vuc protected se dung auth local cho den khi noi Supabase that.',
      coordinateTitle: 'Coordinate workspace',
      coordinateDescription:
          'Khu vuc protected nay se chua collaboration lane, initiative tracking va cac man hinh execution dung chung.',
      coordinateBadge: 'Protected preview',
      coordinateBoardTitle: 'Coordinate outputs',
      coordinateBoardSubtitle:
          'Xem cac coordinate generation moi nhat cua ban tu Supabase trong mot board owner-facing.',
      coordinateSummaryTitle: 'Thu vien coordinate moi nhat cua ban',
      coordinateSummaryCountPrefix: 'So item da tai',
      coordinatePostedBadge: 'Posted',
      coordinateDraftBadge: 'Draft',
      coordinatePromptLabel: 'Prompt',
      coordinateMissingPrompt: 'Item nay khong co prompt da luu.',
      coordinateCreatedAtLabel: 'Thoi gian tao',
      coordinateModelLabel: 'Model',
      coordinateSourceLabel: 'Source stock',
      coordinateEmptyTitle: 'Chua co coordinate item nao',
      coordinateEmptyBody:
          'Hay generate hoac dong bo coordinate output dau tien len Supabase, roi quay lai day de quan ly.',
      coordinateErrorTitle: 'Khong tai duoc coordinate items',
      coordinateErrorBody:
          'Board chua the lay du lieu moi nhat luc nay. Thu lai sau it phut.',
      coordinateConfigTitle: 'Can cau hinh Supabase',
      coordinateConfigBody:
          'Board nay doc du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.',
      retryButton: 'Thu lai',
      loadMoreButton: 'Tai them',
      challengeTitle: 'Challenge board',
      challengeDescription:
          'Trang protected nay danh cho challenge campaign, bai nop va cac checkpoint tien do.',
      challengeBadge: 'Members only',
      notificationsTitle: 'Notifications center',
      notificationsDescription:
          'Section nay se gom alert, event update va collaboration signal vao mot man hinh mobile-first.',
      notificationsBadge: 'Realtime ready',
      myPageTitle: 'My page',
      myPageDescription:
          'Khu vuc profile protected nay se hien thong tin tai khoan, creator identity va tom tat hoat dong.',
      myPageBadge: 'Account space',
      authRedirecting: 'Dang chuyen toi man dang nhap...',
    ),
  };

  _StringsData get _data =>
      _localizedValues[locale.languageCode] ?? _localizedValues['en']!;

  String get appName => _data.appName;
  String get loading => _data.loading;
  String get shellSubtitle => _data.shellSubtitle;
  String get shellHeaderTitle => _data.shellHeaderTitle;
  String get footerTagline => _data.footerTagline;
  String get defaultUserLabel => _data.defaultUserLabel;
  String get navHome => _data.navHome;
  String get navCoordinate => _data.navCoordinate;
  String get navChallenge => _data.navChallenge;
  String get navNotifications => _data.navNotifications;
  String get navMyPage => _data.navMyPage;
  String get homeHeadline => _data.homeHeadline;
  String get homeLead => _data.homeLead;
  String get homeFeedTitle => _data.homeFeedTitle;
  String get homeFeedAction => _data.homeFeedAction;
  String get homeBannerChip => _data.homeBannerChip;
  String get homeBannerFallbackTitle => _data.homeBannerFallbackTitle;
  String get homeFeedMissingPreview => _data.homeFeedMissingPreview;
  String get homeConfigTitle => _data.homeConfigTitle;
  String get homeConfigBody => _data.homeConfigBody;
  String get homeErrorTitle => _data.homeErrorTitle;
  String get homeErrorBody => _data.homeErrorBody;
  String get homeEmptyTitle => _data.homeEmptyTitle;
  String get homeEmptyBody => _data.homeEmptyBody;
  String get homeLinkUnavailable => _data.homeLinkUnavailable;
  String get homeLinkError => _data.homeLinkError;
  String get homePostedAtLabel => _data.homePostedAtLabel;
  String get homeCreatorLabel => _data.homeCreatorLabel;
  String get homeViewsLabel => _data.homeViewsLabel;
  String get loginTitle => _data.loginTitle;
  String loginSubtitle(bool isConfigured) =>
      isConfigured ? _data.loginSubtitleConfigured : _data.loginSubtitleMock;
  String get signupTitle => _data.signupTitle;
  String get signupSubtitle => _data.signupSubtitle;
  String get loginButton => _data.loginButton;
  String get signUpButton => _data.signUpButton;
  String get signOutButton => _data.signOutButton;
  String get signUpCta => _data.signUpCta;
  String get loginCta => _data.loginCta;
  String get loginFooterPrompt => _data.loginFooterPrompt;
  String get signupFooterPrompt => _data.signupFooterPrompt;
  String get emailLabel => _data.emailLabel;
  String get emailHint => _data.emailHint;
  String get passwordLabel => _data.passwordLabel;
  String get passwordHint => _data.passwordHint;
  String get confirmPasswordLabel => _data.confirmPasswordLabel;
  String get passwordRule => _data.passwordRule;
  String get passwordMismatch => _data.passwordMismatch;
  String get signupSuccess => _data.signupSuccess;
  String get authMissingFields => _data.authMissingFields;
  String get authSignInFailed => _data.authSignInFailed;
  String get authAlternativeActions => _data.authAlternativeActions;
  String get googlePlaceholder => _data.googlePlaceholder;
  String get applePlaceholder => _data.applePlaceholder;
  String shellSignedIn(String email) => '${_data.shellSignedInPrefix} $email';
  String shellSignedOut(bool isConfigured) =>
      isConfigured ? _data.shellSignedOutConfigured : _data.shellSignedOutMock;
  String get coordinateTitle => _data.coordinateTitle;
  String get coordinateDescription => _data.coordinateDescription;
  String get coordinateBadge => _data.coordinateBadge;
  String get coordinateBoardTitle => _data.coordinateBoardTitle;
  String get coordinateBoardSubtitle => _data.coordinateBoardSubtitle;
  String get coordinateSummaryTitle => _data.coordinateSummaryTitle;
  String coordinateSummaryCount(int count) =>
      '${_data.coordinateSummaryCountPrefix}: $count';
  String get coordinatePostedBadge => _data.coordinatePostedBadge;
  String get coordinateDraftBadge => _data.coordinateDraftBadge;
  String get coordinatePromptLabel => _data.coordinatePromptLabel;
  String get coordinateMissingPrompt => _data.coordinateMissingPrompt;
  String get coordinateCreatedAtLabel => _data.coordinateCreatedAtLabel;
  String get coordinateModelLabel => _data.coordinateModelLabel;
  String get coordinateSourceLabel => _data.coordinateSourceLabel;
  String get coordinateEmptyTitle => _data.coordinateEmptyTitle;
  String get coordinateEmptyBody => _data.coordinateEmptyBody;
  String get coordinateErrorTitle => _data.coordinateErrorTitle;
  String get coordinateErrorBody => _data.coordinateErrorBody;
  String get coordinateConfigTitle => _data.coordinateConfigTitle;
  String get coordinateConfigBody => _data.coordinateConfigBody;
  String get retryButton => _data.retryButton;
  String get loadMoreButton => _data.loadMoreButton;
  String get challengeTitle => _data.challengeTitle;
  String get challengeDescription => _data.challengeDescription;
  String get challengeBadge => _data.challengeBadge;
  String get notificationsTitle => _data.notificationsTitle;
  String get notificationsDescription => _data.notificationsDescription;
  String get notificationsBadge => _data.notificationsBadge;
  String get myPageTitle => _data.myPageTitle;
  String get myPageDescription => _data.myPageDescription;
  String get myPageBadge => _data.myPageBadge;
  String get authRedirecting => _data.authRedirecting;
}

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) => AppStrings.supportedLocales.any(
    (supported) => supported.languageCode == locale.languageCode,
  );

  @override
  Future<AppStrings> load(Locale locale) async => AppStrings._(locale);

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}

class _StringsData {
  const _StringsData({
    required this.appName,
    required this.loading,
    required this.shellSubtitle,
    required this.shellHeaderTitle,
    required this.footerTagline,
    required this.defaultUserLabel,
    required this.navHome,
    required this.navCoordinate,
    required this.navChallenge,
    required this.navNotifications,
    required this.navMyPage,
    required this.homeHeadline,
    required this.homeLead,
    required this.homeFeedTitle,
    required this.homeFeedAction,
    required this.homeBannerChip,
    required this.homeBannerFallbackTitle,
    required this.homeFeedMissingPreview,
    required this.homeConfigTitle,
    required this.homeConfigBody,
    required this.homeErrorTitle,
    required this.homeErrorBody,
    required this.homeEmptyTitle,
    required this.homeEmptyBody,
    required this.homeLinkUnavailable,
    required this.homeLinkError,
    required this.homePostedAtLabel,
    required this.homeCreatorLabel,
    required this.homeViewsLabel,
    required this.loginTitle,
    required this.loginSubtitleConfigured,
    required this.loginSubtitleMock,
    required this.signupTitle,
    required this.signupSubtitle,
    required this.loginButton,
    required this.signUpButton,
    required this.signOutButton,
    required this.signUpCta,
    required this.loginCta,
    required this.loginFooterPrompt,
    required this.signupFooterPrompt,
    required this.emailLabel,
    required this.emailHint,
    required this.passwordLabel,
    required this.passwordHint,
    required this.confirmPasswordLabel,
    required this.passwordRule,
    required this.passwordMismatch,
    required this.signupSuccess,
    required this.authMissingFields,
    required this.authSignInFailed,
    required this.authAlternativeActions,
    required this.googlePlaceholder,
    required this.applePlaceholder,
    required this.shellSignedInPrefix,
    required this.shellSignedOutConfigured,
    required this.shellSignedOutMock,
    required this.coordinateTitle,
    required this.coordinateDescription,
    required this.coordinateBadge,
    required this.coordinateBoardTitle,
    required this.coordinateBoardSubtitle,
    required this.coordinateSummaryTitle,
    required this.coordinateSummaryCountPrefix,
    required this.coordinatePostedBadge,
    required this.coordinateDraftBadge,
    required this.coordinatePromptLabel,
    required this.coordinateMissingPrompt,
    required this.coordinateCreatedAtLabel,
    required this.coordinateModelLabel,
    required this.coordinateSourceLabel,
    required this.coordinateEmptyTitle,
    required this.coordinateEmptyBody,
    required this.coordinateErrorTitle,
    required this.coordinateErrorBody,
    required this.coordinateConfigTitle,
    required this.coordinateConfigBody,
    required this.retryButton,
    required this.loadMoreButton,
    required this.challengeTitle,
    required this.challengeDescription,
    required this.challengeBadge,
    required this.notificationsTitle,
    required this.notificationsDescription,
    required this.notificationsBadge,
    required this.myPageTitle,
    required this.myPageDescription,
    required this.myPageBadge,
    required this.authRedirecting,
  });

  final String appName;
  final String loading;
  final String shellSubtitle;
  final String shellHeaderTitle;
  final String footerTagline;
  final String defaultUserLabel;
  final String navHome;
  final String navCoordinate;
  final String navChallenge;
  final String navNotifications;
  final String navMyPage;
  final String homeHeadline;
  final String homeLead;
  final String homeFeedTitle;
  final String homeFeedAction;
  final String homeBannerChip;
  final String homeBannerFallbackTitle;
  final String homeFeedMissingPreview;
  final String homeConfigTitle;
  final String homeConfigBody;
  final String homeErrorTitle;
  final String homeErrorBody;
  final String homeEmptyTitle;
  final String homeEmptyBody;
  final String homeLinkUnavailable;
  final String homeLinkError;
  final String homePostedAtLabel;
  final String homeCreatorLabel;
  final String homeViewsLabel;
  final String loginTitle;
  final String loginSubtitleConfigured;
  final String loginSubtitleMock;
  final String signupTitle;
  final String signupSubtitle;
  final String loginButton;
  final String signUpButton;
  final String signOutButton;
  final String signUpCta;
  final String loginCta;
  final String loginFooterPrompt;
  final String signupFooterPrompt;
  final String emailLabel;
  final String emailHint;
  final String passwordLabel;
  final String passwordHint;
  final String confirmPasswordLabel;
  final String passwordRule;
  final String passwordMismatch;
  final String signupSuccess;
  final String authMissingFields;
  final String authSignInFailed;
  final String authAlternativeActions;
  final String googlePlaceholder;
  final String applePlaceholder;
  final String shellSignedInPrefix;
  final String shellSignedOutConfigured;
  final String shellSignedOutMock;
  final String coordinateTitle;
  final String coordinateDescription;
  final String coordinateBadge;
  final String coordinateBoardTitle;
  final String coordinateBoardSubtitle;
  final String coordinateSummaryTitle;
  final String coordinateSummaryCountPrefix;
  final String coordinatePostedBadge;
  final String coordinateDraftBadge;
  final String coordinatePromptLabel;
  final String coordinateMissingPrompt;
  final String coordinateCreatedAtLabel;
  final String coordinateModelLabel;
  final String coordinateSourceLabel;
  final String coordinateEmptyTitle;
  final String coordinateEmptyBody;
  final String coordinateErrorTitle;
  final String coordinateErrorBody;
  final String coordinateConfigTitle;
  final String coordinateConfigBody;
  final String retryButton;
  final String loadMoreButton;
  final String challengeTitle;
  final String challengeDescription;
  final String challengeBadge;
  final String notificationsTitle;
  final String notificationsDescription;
  final String notificationsBadge;
  final String myPageTitle;
  final String myPageDescription;
  final String myPageBadge;
  final String authRedirecting;
}

class BannerCopy {
  const BannerCopy({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;
}

class FeedCardCopy {
  const FeedCardCopy({
    required this.badge,
    required this.title,
    required this.description,
  });

  final String badge;
  final String title;
  final String description;
}
