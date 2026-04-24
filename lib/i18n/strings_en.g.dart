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

	/// en: 'Challenge'
	String get challenge => 'Challenge';

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

	/// en: 'Create, coordinate, and ship from one place.'
	String get headline => 'Create, coordinate, and ship from one place.';

	/// en: 'A mobile-first public discovery surface inspired by the Next.js reference: live banners, posted images, and one shared navigation shell.'
	String get lead => 'A mobile-first public discovery surface inspired by the Next.js reference: live banners, posted images, and one shared navigation shell.';

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

	/// en: 'This protected profile area will surface account details, creator identity, and activity snapshots.'
	String get description => 'This protected profile area will surface account details, creator identity, and activity snapshots.';

	/// en: 'Account space'
	String get badge => 'Account space';
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
			'nav.challenge' => 'Challenge',
			'nav.notifications' => 'Notifications',
			'nav.my_page' => 'My Page',
			'home.headline' => 'Create, coordinate, and ship from one place.',
			'home.lead' => 'A mobile-first public discovery surface inspired by the Next.js reference: live banners, posted images, and one shared navigation shell.',
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
			'my_page.description' => 'This protected profile area will surface account details, creator identity, and activity snapshots.',
			'my_page.badge' => 'Account space',
			_ => null,
		};
	}
}
