///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Persta.AI'
	String get app_name => 'Persta.AI';

	/// en: 'Loading'
	String get loading => 'Loading';

	/// en: 'creator'
	String get default_user_label => 'creator';

	late final TranslationsShellEn shell = TranslationsShellEn.internal(_root);
	late final TranslationsNavEn nav = TranslationsNavEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsCoordinateEn coordinate = TranslationsCoordinateEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsChallengeEn challenge = TranslationsChallengeEn.internal(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn.internal(_root);
	late final TranslationsMyPageEn my_page = TranslationsMyPageEn.internal(_root);
}

// Path: shell
class TranslationsShellEn {
	TranslationsShellEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinate your AI workflow across one lightweight app.'
	String get subtitle => 'Coordinate your AI workflow across one lightweight app.';

	/// en: 'Today on Persta.AI'
	String get header_title => 'Today on Persta.AI';

	/// en: 'Phase-1 Flutter shell mirrored from the reference Next.js product.'
	String get footer_tagline => 'Phase-1 Flutter shell mirrored from the reference Next.js product.';

	/// en: 'Log in'
	String get login_cta => 'Log in';

	/// en: 'Log out'
	String get logout_cta => 'Log out';

	/// en: 'Guest mode'
	String get guest_badge => 'Guest mode';

	/// en: 'Signed in'
	String get member_badge => 'Signed in';
}

// Path: nav
class TranslationsNavEn {
	TranslationsNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Coordinate'
	String get coordinate => 'Coordinate';

	/// en: 'Mission'
	String get mission => 'Mission';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'My Page'
	String get my_page => 'My Page';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Persta'
	String get headline => 'Persta';

	/// en: 'An AI styling platform for the looks and characters you want to create. '
	String get lead => 'An AI styling platform for the looks and characters you want to create.\n\n';

	late final TranslationsHomeAppbarEn appbar = TranslationsHomeAppbarEn.internal(_root);

	/// en: 'Latest updates'
	String get feed_title => 'Latest updates';

	late final TranslationsHomeFiltersEn filters = TranslationsHomeFiltersEn.internal(_root);

	/// en: 'Featured'
	String get banner_chip => 'Featured';

	/// en: 'Open the latest highlight'
	String get banner_fallback_title => 'Open the latest highlight';

	/// en: 'This post is available without a prompt or caption preview yet.'
	String get feed_missing_preview => 'This post is available without a prompt or caption preview yet.';

	/// en: 'Supabase configuration required'
	String get config_title => 'Supabase configuration required';

	/// en: 'Home now reads live banners and public posts from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.'
	String get config_body => 'Home now reads live banners and public posts from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.';

	/// en: 'Unable to load Home'
	String get error_title => 'Unable to load Home';

	/// en: 'The app could not fetch banners or public posts right now. Try again shortly.'
	String get error_body => 'The app could not fetch banners or public posts right now. Try again shortly.';

	/// en: 'Nothing to show yet'
	String get empty_title => 'Nothing to show yet';

	/// en: 'There are no active banners or posted images available right now.'
	String get empty_body => 'There are no active banners or posted images available right now.';

	/// en: 'This destination is not available inside the Flutter app yet.'
	String get link_unavailable => 'This destination is not available inside the Flutter app yet.';

	/// en: 'Unable to open the selected banner link.'
	String get link_error => 'Unable to open the selected banner link.';

	/// en: 'Posted'
	String get posted_at_label => 'Posted';

	/// en: 'Creator'
	String get creator_label => 'Creator';

	/// en: 'Views'
	String get views_label => 'Views';

	/// en: 'No followed creators yet'
	String get following_empty_title => 'No followed creators yet';

	/// en: 'No posts from creators you follow yet. Follow more creators or check back later.'
	String get following_empty_body => 'No posts from creators you follow yet. Follow more creators or check back later.';
}

// Path: coordinate
class TranslationsCoordinateEn {
	TranslationsCoordinateEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coordinate'
	String get coordinate_page_title => 'Coordinate';

	/// en: 'Create coordinate outputs with source-aware generation and track progress in real time.'
	String get coordinate_page_subtitle => 'Create coordinate outputs with source-aware generation and track progress in real time.';

	/// en: 'Generate'
	String get generation_section_title => 'Generate';

	/// en: 'Generated results'
	String get results_section_title => 'Generated results';

	/// en: 'Generation progress'
	String get progress_section_title => 'Generation progress';

	/// en: 'Upload'
	String get source_mode_upload => 'Upload';

	/// en: 'Stock'
	String get source_mode_stock => 'Stock';

	/// en: 'Upload sample'
	String get upload_mock_title => 'Upload sample';

	/// en: 'Use sample PNG (1MB)'
	String get upload_pick_valid => 'Use sample PNG (1MB)';

	/// en: 'Use oversized WebP (12MB)'
	String get upload_pick_large => 'Use oversized WebP (12MB)';

	/// en: 'Use unsupported HEIC'
	String get upload_pick_unsupported => 'Use unsupported HEIC';

	/// en: 'No upload selected'
	String get upload_none_selected => 'No upload selected';

	/// en: 'Select stock source'
	String get stock_picker_title => 'Select stock source';

	/// en: 'Prompt'
	String get prompt_input_label => 'Prompt';

	/// en: 'Describe outfit/style changes to generate'
	String get prompt_input_hint => 'Describe outfit/style changes to generate';

	/// en: 'Source image type'
	String get source_type_label => 'Source image type';

	/// en: 'Illustration'
	String get source_type_illustration => 'Illustration';

	/// en: 'Real photo'
	String get source_type_real => 'Real photo';

	/// en: 'Background mode'
	String get background_label => 'Background mode';

	/// en: 'Keep current background'
	String get background_keep => 'Keep current background';

	/// en: 'Include background in prompt'
	String get background_include => 'Include background in prompt';

	/// en: 'AI auto background'
	String get background_auto => 'AI auto background';

	/// en: 'Model tier'
	String get model_tier_label => 'Model tier';

	/// en: 'Light (0.5K)'
	String get model_tier_light => 'Light (0.5K)';

	/// en: 'Standard (1K)'
	String get model_tier_standard => 'Standard (1K)';

	/// en: 'Pro (1K)'
	String get model_tier_pro1k => 'Pro (1K)';

	/// en: 'Pro (2K)'
	String get model_tier_pro2k => 'Pro (2K)';

	/// en: 'Pro (4K)'
	String get model_tier_pro4k => 'Pro (4K)';

	/// en: 'Output count'
	String get output_count_label => 'Output count';

	/// en: 'Estimated cost: {{amount}} percoins • Balance: {{balance}}'
	String get estimated_cost_label => 'Estimated cost: {{amount}} percoins • Balance: {{balance}}';

	/// en: 'Current plan allows up to {{max}} outputs per request.'
	String get plan_limit_notice => 'Current plan allows up to {{max}} outputs per request.';

	/// en: 'Generate'
	String get generating_button_ready => 'Generate';

	/// en: 'Generating...'
	String get generating_button_loading => 'Generating...';

	/// en: 'Balance: {{amount}}'
	String get balance_chip => 'Balance: {{amount}}';

	/// en: 'Buy Percoins'
	String get buy_percoins_action => 'Buy Percoins';

	/// en: 'Still processing in the background. Re-open Coordinate to auto-resume tracking.'
	String get still_processing_notice => 'Still processing in the background. Re-open Coordinate to auto-resume tracking.';

	/// en: 'Queued'
	String get status_queued => 'Queued';

	/// en: 'Processing'
	String get status_processing => 'Processing';

	/// en: 'Charging'
	String get status_charging => 'Charging';

	/// en: 'Generating'
	String get status_generating => 'Generating';

	/// en: 'Uploading'
	String get status_uploading => 'Uploading';

	/// en: 'Persisting'
	String get status_persisting => 'Persisting';

	/// en: 'Completed'
	String get status_completed => 'Completed';

	/// en: 'Failed'
	String get status_failed => 'Failed';

	/// en: 'Enter a prompt before generating.'
	String get error_missing_prompt => 'Enter a prompt before generating.';

	/// en: 'Prompt exceeds the allowed length.'
	String get error_prompt_too_long => 'Prompt exceeds the allowed length.';

	/// en: 'Select a source image before generating.'
	String get error_missing_source => 'Select a source image before generating.';

	/// en: 'Only JPG/PNG/WebP uploads are supported.'
	String get error_unsupported_upload => 'Only JPG/PNG/WebP uploads are supported.';

	/// en: 'Upload size must be 10MB or smaller.'
	String get error_upload_too_large => 'Upload size must be 10MB or smaller.';

	/// en: 'Selected count exceeds your current plan limit.'
	String get error_upgrade_required => 'Selected count exceeds your current plan limit.';

	/// en: 'You do not have enough percoins for this request.'
	String get error_insufficient_balance => 'You do not have enough percoins for this request.';

	/// en: 'Unable to submit generation right now.'
	String get error_submit_failed => 'Unable to submit generation right now.';

	/// en: 'Unable to load generated history.'
	String get error_history_failed => 'Unable to load generated history.';

	/// en: 'Unable to refresh generation progress.'
	String get error_polling_failed => 'Unable to refresh generation progress.';

	/// en: 'Something went wrong. Please try again.'
	String get error_generic => 'Something went wrong. Please try again.';

	/// en: 'No generated results yet.'
	String get empty_results => 'No generated results yet.';

	/// en: 'No prompt preview available.'
	String get prompt_missing_fallback => 'No prompt preview available.';

	/// en: 'Coordinate workspace'
	String get title => 'Coordinate workspace';

	/// en: 'This protected area will host collaboration lanes, initiative tracking, and shared execution views.'
	String get description => 'This protected area will host collaboration lanes, initiative tracking, and shared execution views.';

	/// en: 'Protected preview'
	String get badge => 'Protected preview';

	/// en: 'Coordinate outputs'
	String get board_title => 'Coordinate outputs';

	/// en: 'Review your latest coordinate generations from Supabase in one owner-facing board.'
	String get board_subtitle => 'Review your latest coordinate generations from Supabase in one owner-facing board.';

	/// en: 'Your latest coordinate library'
	String get summary_title => 'Your latest coordinate library';

	/// en: 'Items loaded'
	String get summary_count_prefix => 'Items loaded';

	/// en: 'Posted'
	String get posted_badge => 'Posted';

	/// en: 'Draft'
	String get draft_badge => 'Draft';

	/// en: 'Prompt'
	String get prompt_label => 'Prompt';

	/// en: 'No prompt was saved for this item.'
	String get missing_prompt => 'No prompt was saved for this item.';

	/// en: 'Created'
	String get created_at_label => 'Created';

	/// en: 'Model'
	String get model_label => 'Model';

	/// en: 'Source stock'
	String get source_label => 'Source stock';

	/// en: 'No coordinate items yet'
	String get empty_title => 'No coordinate items yet';

	/// en: 'Generate or sync your first coordinate output in Supabase, then return here to manage it.'
	String get empty_body => 'Generate or sync your first coordinate output in Supabase, then return here to manage it.';

	/// en: 'Unable to load coordinate items'
	String get error_title => 'Unable to load coordinate items';

	/// en: 'The board could not fetch your latest items right now. Try again in a moment.'
	String get error_body => 'The board could not fetch your latest items right now. Try again in a moment.';

	/// en: 'Supabase configuration required'
	String get config_title => 'Supabase configuration required';

	/// en: 'This board reads live data from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.'
	String get config_body => 'This board reads live data from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Try again'
	String get retry_button => 'Try again';

	/// en: 'Load more'
	String get load_more_button => 'Load more';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Log in'
	String get login_title => 'Log in';

	/// en: 'Sign in to open coordinate, challenge, notifications, and your page.'
	String get login_description => 'Sign in to open coordinate, challenge, notifications, and your page.';

	/// en: 'Email'
	String get email_label => 'Email';

	/// en: 'Password'
	String get password_label => 'Password';

	/// en: 'Log in'
	String get login_action => 'Log in';

	/// en: 'Back to Home'
	String get back_home_action => 'Back to Home';

	/// en: 'Log out'
	String get logout_action => 'Log out';

	/// en: 'Logging in...'
	String get logging_in => 'Logging in...';

	/// en: 'Unable to sign in right now.'
	String get login_failed => 'Unable to sign in right now.';

	/// en: 'Enter both email and password.'
	String get validation_missing_credentials => 'Enter both email and password.';

	/// en: 'If Supabase is not configured, the app uses a local mock session for this basic flow.'
	String get login_hint => 'If Supabase is not configured, the app uses a local mock session for this basic flow.';

	/// en: 'Login required'
	String get required_title => 'Login required';

	/// en: 'This tab is available only after you log in.'
	String get required_body => 'This tab is available only after you log in.';

	/// en: 'Your session is no longer available. Please log in again.'
	String get session_expired => 'Your session is no longer available. Please log in again.';
}

// Path: challenge
class TranslationsChallengeEn {
	TranslationsChallengeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Challenge board'
	String get title => 'Challenge board';

	/// en: 'This protected page is reserved for challenge campaigns, submissions, and progress checkpoints.'
	String get description => 'This protected page is reserved for challenge campaigns, submissions, and progress checkpoints.';

	/// en: 'Members only'
	String get badge => 'Members only';
}

// Path: notifications
class TranslationsNotificationsEn {
	TranslationsNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications center'
	String get title => 'Notifications center';

	/// en: 'This section will collect alerts, event updates, and collaboration signals in one mobile-first view.'
	String get description => 'This section will collect alerts, event updates, and collaboration signals in one mobile-first view.';

	/// en: 'Realtime ready'
	String get badge => 'Realtime ready';
}

// Path: my_page
class TranslationsMyPageEn {
	TranslationsMyPageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My page'
	String get title => 'My page';

	/// en: 'Your profile, statistics, balance, and generated gallery in one place.'
	String get description => 'Your profile, statistics, balance, and generated gallery in one place.';

	late final TranslationsMyPageAppbarEn appbar = TranslationsMyPageAppbarEn.internal(_root);
	late final TranslationsMyPageDrawerEn drawer = TranslationsMyPageDrawerEn.internal(_root);

	/// en: 'Account space'
	String get badge => 'Account space';

	/// en: 'Creator'
	String get default_display_name => 'Creator';

	/// en: 'No profile bio yet.'
	String get default_bio => 'No profile bio yet.';

	/// en: 'Unable to load My Page'
	String get error_title => 'Unable to load My Page';

	/// en: 'Some sections could not be loaded. Please try again.'
	String get error_body => 'Some sections could not be loaded. Please try again.';

	/// en: 'Unable to load profile'
	String get profile_error_title => 'Unable to load profile';

	/// en: 'Profile details are currently unavailable.'
	String get profile_error_body => 'Profile details are currently unavailable.';

	/// en: 'Profile may be outdated'
	String get profile_partial_error_title => 'Profile may be outdated';

	/// en: 'Some profile data is unavailable. Pull to refresh and try again.'
	String get profile_partial_error_body => 'Some profile data is unavailable. Pull to refresh and try again.';

	/// en: 'Statistics'
	String get stats_title => 'Statistics';

	/// en: 'Generated'
	String get stats_generated => 'Generated';

	/// en: 'Posted'
	String get stats_posted => 'Posted';

	/// en: 'Likes'
	String get stats_likes => 'Likes';

	/// en: 'Views'
	String get stats_views => 'Views';

	/// en: 'Followers'
	String get stats_followers => 'Followers';

	/// en: 'Following'
	String get stats_following => 'Following';

	/// en: 'Unable to load statistics'
	String get stats_error_title => 'Unable to load statistics';

	/// en: 'Your latest statistics are unavailable right now.'
	String get stats_error_body => 'Your latest statistics are unavailable right now.';

	/// en: 'Credit Balance'
	String get balance_title => 'Credit Balance';

	/// en: 'percoins'
	String get balance_unit => 'percoins';

	/// en: 'Regular'
	String get balance_regular => 'Regular';

	/// en: 'Paid'
	String get balance_paid => 'Paid';

	/// en: 'Unlimited bonus'
	String get balance_unlimited_bonus => 'Unlimited bonus';

	/// en: 'Period-limited'
	String get balance_period_limited => 'Period-limited';

	/// en: 'Unable to load balance'
	String get balance_error_title => 'Unable to load balance';

	/// en: 'Credit balance data is unavailable right now.'
	String get balance_error_body => 'Credit balance data is unavailable right now.';

	/// en: 'Generated images'
	String get gallery_title => 'Generated images';

	/// en: 'No caption or prompt preview.'
	String get gallery_missing_preview => 'No caption or prompt preview.';

	/// en: 'No generated images yet'
	String get gallery_empty_title => 'No generated images yet';

	/// en: 'Create your first image and it will appear here.'
	String get gallery_empty_body => 'Create your first image and it will appear here.';

	/// en: 'Unable to load gallery'
	String get gallery_error_title => 'Unable to load gallery';

	/// en: 'Your image gallery is unavailable right now.'
	String get gallery_error_body => 'Your image gallery is unavailable right now.';
}

// Path: home.appbar
class TranslationsHomeAppbarEn {
	TranslationsHomeAppbarEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search prompts'
	String get search_placeholder => 'Search prompts';

	/// en: 'Change language'
	String get locale_action => 'Change language';

	/// en: 'Open profile'
	String get profile_action => 'Open profile';
}

// Path: home.filters
class TranslationsHomeFiltersEn {
	TranslationsHomeFiltersEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Newest'
	String get newest => 'Newest';

	/// en: 'Recommended'
	String get recommended => 'Recommended';

	/// en: 'Following'
	String get following => 'Following';
}

// Path: my_page.appbar
class TranslationsMyPageAppbarEn {
	TranslationsMyPageAppbarEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open menu'
	String get menu_action => 'Open menu';
}

// Path: my_page.drawer
class TranslationsMyPageDrawerEn {
	TranslationsMyPageDrawerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Menu'
	String get title => 'Menu';

	/// en: 'Account'
	String get account_action => 'Account';

	/// en: 'Language settings'
	String get language_settings_action => 'Language settings';

	/// en: 'Contact'
	String get contact_action => 'Contact';

	/// en: 'Buy Percoins'
	String get buy_percoins_action => 'Buy Percoins';

	/// en: 'Log out'
	String get logout_action => 'Log out';

	/// en: 'Close menu'
	String get close_action => 'Close menu';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Persta.AI',
			'loading' => 'Loading',
			'default_user_label' => 'creator',
			'shell.subtitle' => 'Coordinate your AI workflow across one lightweight app.',
			'shell.header_title' => 'Today on Persta.AI',
			'shell.footer_tagline' => 'Phase-1 Flutter shell mirrored from the reference Next.js product.',
			'shell.login_cta' => 'Log in',
			'shell.logout_cta' => 'Log out',
			'shell.guest_badge' => 'Guest mode',
			'shell.member_badge' => 'Signed in',
			'nav.home' => 'Home',
			'nav.coordinate' => 'Coordinate',
			'nav.mission' => 'Mission',
			'nav.notifications' => 'Notifications',
			'nav.my_page' => 'My Page',
			'home.headline' => 'Persta',
			'home.lead' => 'An AI styling platform for the looks and characters you want to create.\n\n',
			'home.appbar.search_placeholder' => 'Search prompts',
			'home.appbar.locale_action' => 'Change language',
			'home.appbar.profile_action' => 'Open profile',
			'home.feed_title' => 'Latest updates',
			'home.filters.newest' => 'Newest',
			'home.filters.recommended' => 'Recommended',
			'home.filters.following' => 'Following',
			'home.banner_chip' => 'Featured',
			'home.banner_fallback_title' => 'Open the latest highlight',
			'home.feed_missing_preview' => 'This post is available without a prompt or caption preview yet.',
			'home.config_title' => 'Supabase configuration required',
			'home.config_body' => 'Home now reads live banners and public posts from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.',
			'home.error_title' => 'Unable to load Home',
			'home.error_body' => 'The app could not fetch banners or public posts right now. Try again shortly.',
			'home.empty_title' => 'Nothing to show yet',
			'home.empty_body' => 'There are no active banners or posted images available right now.',
			'home.link_unavailable' => 'This destination is not available inside the Flutter app yet.',
			'home.link_error' => 'Unable to open the selected banner link.',
			'home.posted_at_label' => 'Posted',
			'home.creator_label' => 'Creator',
			'home.views_label' => 'Views',
			'home.following_empty_title' => 'No followed creators yet',
			'home.following_empty_body' => 'No posts from creators you follow yet. Follow more creators or check back later.',
			'coordinate.coordinate_page_title' => 'Coordinate',
			'coordinate.coordinate_page_subtitle' => 'Create coordinate outputs with source-aware generation and track progress in real time.',
			'coordinate.generation_section_title' => 'Generate',
			'coordinate.results_section_title' => 'Generated results',
			'coordinate.progress_section_title' => 'Generation progress',
			'coordinate.source_mode_upload' => 'Upload',
			'coordinate.source_mode_stock' => 'Stock',
			'coordinate.upload_mock_title' => 'Upload sample',
			'coordinate.upload_pick_valid' => 'Use sample PNG (1MB)',
			'coordinate.upload_pick_large' => 'Use oversized WebP (12MB)',
			'coordinate.upload_pick_unsupported' => 'Use unsupported HEIC',
			'coordinate.upload_none_selected' => 'No upload selected',
			'coordinate.stock_picker_title' => 'Select stock source',
			'coordinate.prompt_input_label' => 'Prompt',
			'coordinate.prompt_input_hint' => 'Describe outfit/style changes to generate',
			'coordinate.source_type_label' => 'Source image type',
			'coordinate.source_type_illustration' => 'Illustration',
			'coordinate.source_type_real' => 'Real photo',
			'coordinate.background_label' => 'Background mode',
			'coordinate.background_keep' => 'Keep current background',
			'coordinate.background_include' => 'Include background in prompt',
			'coordinate.background_auto' => 'AI auto background',
			'coordinate.model_tier_label' => 'Model tier',
			'coordinate.model_tier_light' => 'Light (0.5K)',
			'coordinate.model_tier_standard' => 'Standard (1K)',
			'coordinate.model_tier_pro1k' => 'Pro (1K)',
			'coordinate.model_tier_pro2k' => 'Pro (2K)',
			'coordinate.model_tier_pro4k' => 'Pro (4K)',
			'coordinate.output_count_label' => 'Output count',
			'coordinate.estimated_cost_label' => 'Estimated cost: {{amount}} percoins • Balance: {{balance}}',
			'coordinate.plan_limit_notice' => 'Current plan allows up to {{max}} outputs per request.',
			'coordinate.generating_button_ready' => 'Generate',
			'coordinate.generating_button_loading' => 'Generating...',
			'coordinate.balance_chip' => 'Balance: {{amount}}',
			'coordinate.buy_percoins_action' => 'Buy Percoins',
			'coordinate.still_processing_notice' => 'Still processing in the background. Re-open Coordinate to auto-resume tracking.',
			'coordinate.status_queued' => 'Queued',
			'coordinate.status_processing' => 'Processing',
			'coordinate.status_charging' => 'Charging',
			'coordinate.status_generating' => 'Generating',
			'coordinate.status_uploading' => 'Uploading',
			'coordinate.status_persisting' => 'Persisting',
			'coordinate.status_completed' => 'Completed',
			'coordinate.status_failed' => 'Failed',
			'coordinate.error_missing_prompt' => 'Enter a prompt before generating.',
			'coordinate.error_prompt_too_long' => 'Prompt exceeds the allowed length.',
			'coordinate.error_missing_source' => 'Select a source image before generating.',
			'coordinate.error_unsupported_upload' => 'Only JPG/PNG/WebP uploads are supported.',
			'coordinate.error_upload_too_large' => 'Upload size must be 10MB or smaller.',
			'coordinate.error_upgrade_required' => 'Selected count exceeds your current plan limit.',
			'coordinate.error_insufficient_balance' => 'You do not have enough percoins for this request.',
			'coordinate.error_submit_failed' => 'Unable to submit generation right now.',
			'coordinate.error_history_failed' => 'Unable to load generated history.',
			'coordinate.error_polling_failed' => 'Unable to refresh generation progress.',
			'coordinate.error_generic' => 'Something went wrong. Please try again.',
			'coordinate.empty_results' => 'No generated results yet.',
			'coordinate.prompt_missing_fallback' => 'No prompt preview available.',
			'coordinate.title' => 'Coordinate workspace',
			'coordinate.description' => 'This protected area will host collaboration lanes, initiative tracking, and shared execution views.',
			'coordinate.badge' => 'Protected preview',
			'coordinate.board_title' => 'Coordinate outputs',
			'coordinate.board_subtitle' => 'Review your latest coordinate generations from Supabase in one owner-facing board.',
			'coordinate.summary_title' => 'Your latest coordinate library',
			'coordinate.summary_count_prefix' => 'Items loaded',
			'coordinate.posted_badge' => 'Posted',
			'coordinate.draft_badge' => 'Draft',
			'coordinate.prompt_label' => 'Prompt',
			'coordinate.missing_prompt' => 'No prompt was saved for this item.',
			'coordinate.created_at_label' => 'Created',
			'coordinate.model_label' => 'Model',
			'coordinate.source_label' => 'Source stock',
			'coordinate.empty_title' => 'No coordinate items yet',
			'coordinate.empty_body' => 'Generate or sync your first coordinate output in Supabase, then return here to manage it.',
			'coordinate.error_title' => 'Unable to load coordinate items',
			'coordinate.error_body' => 'The board could not fetch your latest items right now. Try again in a moment.',
			'coordinate.config_title' => 'Supabase configuration required',
			'coordinate.config_body' => 'This board reads live data from Supabase. Provide SUPABASE_URL and SUPABASE_ANON_KEY for this build.',
			'common.retry_button' => 'Try again',
			'common.load_more_button' => 'Load more',
			'auth.login_title' => 'Log in',
			'auth.login_description' => 'Sign in to open coordinate, challenge, notifications, and your page.',
			'auth.email_label' => 'Email',
			'auth.password_label' => 'Password',
			'auth.login_action' => 'Log in',
			'auth.back_home_action' => 'Back to Home',
			'auth.logout_action' => 'Log out',
			'auth.logging_in' => 'Logging in...',
			'auth.login_failed' => 'Unable to sign in right now.',
			'auth.validation_missing_credentials' => 'Enter both email and password.',
			'auth.login_hint' => 'If Supabase is not configured, the app uses a local mock session for this basic flow.',
			'auth.required_title' => 'Login required',
			'auth.required_body' => 'This tab is available only after you log in.',
			'auth.session_expired' => 'Your session is no longer available. Please log in again.',
			'challenge.title' => 'Challenge board',
			'challenge.description' => 'This protected page is reserved for challenge campaigns, submissions, and progress checkpoints.',
			'challenge.badge' => 'Members only',
			'notifications.title' => 'Notifications center',
			'notifications.description' => 'This section will collect alerts, event updates, and collaboration signals in one mobile-first view.',
			'notifications.badge' => 'Realtime ready',
			'my_page.title' => 'My page',
			'my_page.description' => 'Your profile, statistics, balance, and generated gallery in one place.',
			'my_page.appbar.menu_action' => 'Open menu',
			'my_page.drawer.title' => 'Menu',
			'my_page.drawer.account_action' => 'Account',
			'my_page.drawer.language_settings_action' => 'Language settings',
			'my_page.drawer.contact_action' => 'Contact',
			'my_page.drawer.buy_percoins_action' => 'Buy Percoins',
			'my_page.drawer.logout_action' => 'Log out',
			'my_page.drawer.close_action' => 'Close menu',
			'my_page.badge' => 'Account space',
			'my_page.default_display_name' => 'Creator',
			'my_page.default_bio' => 'No profile bio yet.',
			'my_page.error_title' => 'Unable to load My Page',
			'my_page.error_body' => 'Some sections could not be loaded. Please try again.',
			'my_page.profile_error_title' => 'Unable to load profile',
			'my_page.profile_error_body' => 'Profile details are currently unavailable.',
			'my_page.profile_partial_error_title' => 'Profile may be outdated',
			'my_page.profile_partial_error_body' => 'Some profile data is unavailable. Pull to refresh and try again.',
			'my_page.stats_title' => 'Statistics',
			'my_page.stats_generated' => 'Generated',
			'my_page.stats_posted' => 'Posted',
			'my_page.stats_likes' => 'Likes',
			'my_page.stats_views' => 'Views',
			'my_page.stats_followers' => 'Followers',
			'my_page.stats_following' => 'Following',
			'my_page.stats_error_title' => 'Unable to load statistics',
			'my_page.stats_error_body' => 'Your latest statistics are unavailable right now.',
			'my_page.balance_title' => 'Credit Balance',
			'my_page.balance_unit' => 'percoins',
			'my_page.balance_regular' => 'Regular',
			'my_page.balance_paid' => 'Paid',
			'my_page.balance_unlimited_bonus' => 'Unlimited bonus',
			'my_page.balance_period_limited' => 'Period-limited',
			'my_page.balance_error_title' => 'Unable to load balance',
			'my_page.balance_error_body' => 'Credit balance data is unavailable right now.',
			'my_page.gallery_title' => 'Generated images',
			'my_page.gallery_missing_preview' => 'No caption or prompt preview.',
			'my_page.gallery_empty_title' => 'No generated images yet',
			'my_page.gallery_empty_body' => 'Create your first image and it will appear here.',
			'my_page.gallery_error_title' => 'Unable to load gallery',
			'my_page.gallery_error_body' => 'Your image gallery is unavailable right now.',
			_ => null,
		};
	}
}
