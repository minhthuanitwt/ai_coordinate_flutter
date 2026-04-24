///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsJa extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => 'Persta.AI';
	@override String get loading => '読み込み中';
	@override String get default_user_label => 'creator';
	@override late final _TranslationsShellJa shell = _TranslationsShellJa._(_root);
	@override late final _TranslationsNavJa nav = _TranslationsNavJa._(_root);
	@override late final _TranslationsHomeJa home = _TranslationsHomeJa._(_root);
	@override late final _TranslationsCoordinateJa coordinate = _TranslationsCoordinateJa._(_root);
	@override late final _TranslationsCommonJa common = _TranslationsCommonJa._(_root);
	@override late final _TranslationsAuthJa auth = _TranslationsAuthJa._(_root);
	@override late final _TranslationsChallengeJa challenge = _TranslationsChallengeJa._(_root);
	@override late final _TranslationsNotificationsJa notifications = _TranslationsNotificationsJa._(_root);
	@override late final _TranslationsMyPageJa my_page = _TranslationsMyPageJa._(_root);
}

// Path: shell
class _TranslationsShellJa extends TranslationsShellEn {
	_TranslationsShellJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '軽量な1つのアプリでAIワークフローを整理します。';
	@override String get header_title => '今日のPersta.AI';
	@override String get footer_tagline => '参照元のNext.jsプロダクトをもとにしたPhase 1のFlutterシェルです。';
	@override String get login_cta => 'ログイン';
	@override String get logout_cta => 'ログアウト';
	@override String get guest_badge => 'ゲスト';
	@override String get member_badge => 'ログイン中';
}

// Path: nav
class _TranslationsNavJa extends TranslationsNavEn {
	_TranslationsNavJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get home => 'ホーム';
	@override String get coordinate => 'コーディネート';
	@override String get mission => 'ミッション\n';
	@override String get notifications => 'お知らせ\n\n';
	@override String get my_page => 'マイページ';
}

// Path: home
class _TranslationsHomeJa extends TranslationsHomeEn {
	_TranslationsHomeJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get headline => 'Persta | ペルスタ\n';
	@override String get lead => '着てみたいも、なりたいも。AIスタイリングプラットフォーム\n\n';
	@override late final _TranslationsHomeAppbarJa appbar = _TranslationsHomeAppbarJa._(_root);
	@override String get feed_title => '最新アップデート';
	@override late final _TranslationsHomeFiltersJa filters = _TranslationsHomeFiltersJa._(_root);
	@override String get banner_chip => '注目';
	@override String get banner_fallback_title => '最新のハイライトを開く';
	@override String get feed_missing_preview => 'この投稿にはまだプロンプトやキャプションのプレビューがありません。';
	@override String get config_title => 'Supabaseの設定が必要です';
	@override String get config_body => 'HomeはSupabaseからライブバナーと公開投稿を読み込みます。このビルドにはSUPABASE_URLとSUPABASE_ANON_KEYを設定してください。';
	@override String get error_title => 'Homeを読み込めませんでした';
	@override String get error_body => '現在バナーまたは公開投稿を取得できません。しばらくしてから再試行してください。';
	@override String get empty_title => '表示できる内容がまだありません';
	@override String get empty_body => '現在表示できるアクティブなバナーや投稿画像はありません。';
	@override String get link_unavailable => 'このリンク先はFlutterアプリ内ではまだ利用できません。';
	@override String get link_error => '選択したバナーリンクを開けませんでした。';
	@override String get posted_at_label => '投稿日時';
	@override String get creator_label => 'Creator';
	@override String get views_label => '閲覧数';
	@override String get following_empty_title => 'フォロー中のクリエイターはいません';
	@override String get following_empty_body => 'フォロー中のクリエイターの投稿はまだありません。フォローを増やすか、あとで再度確認してください。';
}

// Path: coordinate
class _TranslationsCoordinateJa extends TranslationsCoordinateEn {
	_TranslationsCoordinateJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'コーディネート ワークスペース';
	@override String get description => 'このエリアでは共同作業レーン、施策の追跡、共有実行ビューを扱う予定です。';
	@override String get badge => 'プレビュー';
	@override String get board_title => 'コーディネート出力';
	@override String get board_subtitle => 'Supabase上の最新のCoordinate生成結果を、オーナー向けボードでまとめて確認できます。';
	@override String get summary_title => '最新のCoordinateライブラリ';
	@override String get summary_count_prefix => '読み込み済みアイテム数';
	@override String get posted_badge => '公開済み';
	@override String get draft_badge => '下書き';
	@override String get prompt_label => 'Prompt';
	@override String get missing_prompt => 'このアイテムには保存されたプロンプトがありません。';
	@override String get created_at_label => '作成日時';
	@override String get model_label => 'モデル';
	@override String get source_label => 'ソース素材';
	@override String get empty_title => 'Coordinateアイテムはまだありません';
	@override String get empty_body => '最初のCoordinate出力をSupabaseに生成または同期してから、ここで管理してください。';
	@override String get error_title => 'Coordinateアイテムを読み込めませんでした';
	@override String get error_body => '現在ボードで最新アイテムを取得できません。しばらくしてから再試行してください。';
	@override String get config_title => 'Supabaseの設定が必要です';
	@override String get config_body => 'このボードはSupabaseからライブデータを読み込みます。このビルドにはSUPABASE_URLとSUPABASE_ANON_KEYを設定してください。';
}

// Path: common
class _TranslationsCommonJa extends TranslationsCommonEn {
	_TranslationsCommonJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get retry_button => '再試行';
	@override String get load_more_button => 'もっと見る';
}

// Path: auth
class _TranslationsAuthJa extends TranslationsAuthEn {
	_TranslationsAuthJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get login_title => 'ログイン';
	@override String get login_description => 'Coordinate、Challenge、Notifications、My Page を開くにはログインが必要です。';
	@override String get email_label => 'メールアドレス';
	@override String get password_label => 'パスワード';
	@override String get login_action => 'ログイン';
	@override String get back_home_action => 'ホームへ戻る';
	@override String get logout_action => 'ログアウト';
	@override String get logging_in => 'ログイン中...';
	@override String get login_failed => '現在ログインできません。';
	@override String get validation_missing_credentials => 'メールアドレスとパスワードを入力してください。';
	@override String get login_hint => 'Supabase が未設定の場合、この基本フローではローカルのモックセッションを使用します。';
	@override String get required_title => 'ログインが必要です';
	@override String get required_body => 'このタブはログイン後に利用できます。';
	@override String get session_expired => 'セッションを確認できませんでした。再度ログインしてください。';
}

// Path: challenge
class _TranslationsChallengeJa extends TranslationsChallengeEn {
	_TranslationsChallengeJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'チャレンジボード';
	@override String get description => 'このページはチャレンジ施策、応募、進捗チェックポイントのために用意されています。';
	@override String get badge => 'メンバー限定';
}

// Path: notifications
class _TranslationsNotificationsJa extends TranslationsNotificationsEn {
	_TranslationsNotificationsJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '通知センター';
	@override String get description => 'このセクションには、アラート、イベント更新、共同作業シグナルがモバイルファーストの1画面に集約されます。';
	@override String get badge => 'リアルタイム対応';
}

// Path: my_page
class _TranslationsMyPageJa extends TranslationsMyPageEn {
	_TranslationsMyPageJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'マイページ';
	@override String get description => 'プロフィール、統計、残高、生成ギャラリーを1つの画面で確認できます。';
	@override late final _TranslationsMyPageAppbarJa appbar = _TranslationsMyPageAppbarJa._(_root);
	@override late final _TranslationsMyPageDrawerJa drawer = _TranslationsMyPageDrawerJa._(_root);
	@override String get badge => 'アカウント';
	@override String get default_display_name => 'Creator';
	@override String get default_bio => 'プロフィールの自己紹介はまだありません。';
	@override String get error_title => 'マイページを読み込めませんでした';
	@override String get error_body => '一部セクションの取得に失敗しました。再試行してください。';
	@override String get profile_error_title => 'プロフィールを読み込めませんでした';
	@override String get profile_error_body => '現在プロフィール情報を取得できません。';
	@override String get profile_partial_error_title => 'プロフィール情報が最新ではない可能性があります';
	@override String get profile_partial_error_body => '一部プロフィールデータを取得できませんでした。更新して再試行してください。';
	@override String get stats_title => '統計';
	@override String get stats_generated => '生成数';
	@override String get stats_posted => '投稿数';
	@override String get stats_likes => 'いいね';
	@override String get stats_views => '閲覧数';
	@override String get stats_followers => 'フォロワー';
	@override String get stats_following => 'フォロー中';
	@override String get stats_error_title => '統計を読み込めませんでした';
	@override String get stats_error_body => '最新の統計情報を取得できません。';
	@override String get balance_title => 'クレジット残高';
	@override String get balance_unit => 'percoins';
	@override String get balance_regular => '通常';
	@override String get balance_paid => '有料';
	@override String get balance_unlimited_bonus => '無期限ボーナス';
	@override String get balance_period_limited => '期間限定';
	@override String get balance_error_title => '残高を読み込めませんでした';
	@override String get balance_error_body => '現在クレジット残高を取得できません。';
	@override String get gallery_title => '生成画像';
	@override String get gallery_missing_preview => 'キャプションまたはプロンプトのプレビューはありません。';
	@override String get gallery_empty_title => '生成画像はまだありません';
	@override String get gallery_empty_body => '最初の画像を生成するとここに表示されます。';
	@override String get gallery_error_title => 'ギャラリーを読み込めませんでした';
	@override String get gallery_error_body => '現在ギャラリー情報を取得できません。';
}

// Path: home.appbar
class _TranslationsHomeAppbarJa extends TranslationsHomeAppbarEn {
	_TranslationsHomeAppbarJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get search_placeholder => 'プロンプトを検索';
	@override String get locale_action => '言語を変更';
	@override String get profile_action => 'プロフィールを開く';
}

// Path: home.filters
class _TranslationsHomeFiltersJa extends TranslationsHomeFiltersEn {
	_TranslationsHomeFiltersJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get newest => '新着順';
	@override String get recommended => 'おすすめ';
	@override String get following => 'フォロー中';
}

// Path: my_page.appbar
class _TranslationsMyPageAppbarJa extends TranslationsMyPageAppbarEn {
	_TranslationsMyPageAppbarJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get menu_action => 'メニューを開く';
}

// Path: my_page.drawer
class _TranslationsMyPageDrawerJa extends TranslationsMyPageDrawerEn {
	_TranslationsMyPageDrawerJa._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'メニュー';
	@override String get account_action => 'アカウント';
	@override String get language_settings_action => '言語設定';
	@override String get contact_action => 'お問い合わせ';
	@override String get buy_percoins_action => 'Percoinsを購入';
	@override String get logout_action => 'ログアウト';
	@override String get close_action => 'メニューを閉じる';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Persta.AI',
			'loading' => '読み込み中',
			'default_user_label' => 'creator',
			'shell.subtitle' => '軽量な1つのアプリでAIワークフローを整理します。',
			'shell.header_title' => '今日のPersta.AI',
			'shell.footer_tagline' => '参照元のNext.jsプロダクトをもとにしたPhase 1のFlutterシェルです。',
			'shell.login_cta' => 'ログイン',
			'shell.logout_cta' => 'ログアウト',
			'shell.guest_badge' => 'ゲスト',
			'shell.member_badge' => 'ログイン中',
			'nav.home' => 'ホーム',
			'nav.coordinate' => 'コーディネート',
			'nav.mission' => 'ミッション\n',
			'nav.notifications' => 'お知らせ\n\n',
			'nav.my_page' => 'マイページ',
			'home.headline' => 'Persta | ペルスタ\n',
			'home.lead' => '着てみたいも、なりたいも。AIスタイリングプラットフォーム\n\n',
			'home.appbar.search_placeholder' => 'プロンプトを検索',
			'home.appbar.locale_action' => '言語を変更',
			'home.appbar.profile_action' => 'プロフィールを開く',
			'home.feed_title' => '最新アップデート',
			'home.filters.newest' => '新着順',
			'home.filters.recommended' => 'おすすめ',
			'home.filters.following' => 'フォロー中',
			'home.banner_chip' => '注目',
			'home.banner_fallback_title' => '最新のハイライトを開く',
			'home.feed_missing_preview' => 'この投稿にはまだプロンプトやキャプションのプレビューがありません。',
			'home.config_title' => 'Supabaseの設定が必要です',
			'home.config_body' => 'HomeはSupabaseからライブバナーと公開投稿を読み込みます。このビルドにはSUPABASE_URLとSUPABASE_ANON_KEYを設定してください。',
			'home.error_title' => 'Homeを読み込めませんでした',
			'home.error_body' => '現在バナーまたは公開投稿を取得できません。しばらくしてから再試行してください。',
			'home.empty_title' => '表示できる内容がまだありません',
			'home.empty_body' => '現在表示できるアクティブなバナーや投稿画像はありません。',
			'home.link_unavailable' => 'このリンク先はFlutterアプリ内ではまだ利用できません。',
			'home.link_error' => '選択したバナーリンクを開けませんでした。',
			'home.posted_at_label' => '投稿日時',
			'home.creator_label' => 'Creator',
			'home.views_label' => '閲覧数',
			'home.following_empty_title' => 'フォロー中のクリエイターはいません',
			'home.following_empty_body' => 'フォロー中のクリエイターの投稿はまだありません。フォローを増やすか、あとで再度確認してください。',
			'coordinate.title' => 'コーディネート ワークスペース',
			'coordinate.description' => 'このエリアでは共同作業レーン、施策の追跡、共有実行ビューを扱う予定です。',
			'coordinate.badge' => 'プレビュー',
			'coordinate.board_title' => 'コーディネート出力',
			'coordinate.board_subtitle' => 'Supabase上の最新のCoordinate生成結果を、オーナー向けボードでまとめて確認できます。',
			'coordinate.summary_title' => '最新のCoordinateライブラリ',
			'coordinate.summary_count_prefix' => '読み込み済みアイテム数',
			'coordinate.posted_badge' => '公開済み',
			'coordinate.draft_badge' => '下書き',
			'coordinate.prompt_label' => 'Prompt',
			'coordinate.missing_prompt' => 'このアイテムには保存されたプロンプトがありません。',
			'coordinate.created_at_label' => '作成日時',
			'coordinate.model_label' => 'モデル',
			'coordinate.source_label' => 'ソース素材',
			'coordinate.empty_title' => 'Coordinateアイテムはまだありません',
			'coordinate.empty_body' => '最初のCoordinate出力をSupabaseに生成または同期してから、ここで管理してください。',
			'coordinate.error_title' => 'Coordinateアイテムを読み込めませんでした',
			'coordinate.error_body' => '現在ボードで最新アイテムを取得できません。しばらくしてから再試行してください。',
			'coordinate.config_title' => 'Supabaseの設定が必要です',
			'coordinate.config_body' => 'このボードはSupabaseからライブデータを読み込みます。このビルドにはSUPABASE_URLとSUPABASE_ANON_KEYを設定してください。',
			'common.retry_button' => '再試行',
			'common.load_more_button' => 'もっと見る',
			'auth.login_title' => 'ログイン',
			'auth.login_description' => 'Coordinate、Challenge、Notifications、My Page を開くにはログインが必要です。',
			'auth.email_label' => 'メールアドレス',
			'auth.password_label' => 'パスワード',
			'auth.login_action' => 'ログイン',
			'auth.back_home_action' => 'ホームへ戻る',
			'auth.logout_action' => 'ログアウト',
			'auth.logging_in' => 'ログイン中...',
			'auth.login_failed' => '現在ログインできません。',
			'auth.validation_missing_credentials' => 'メールアドレスとパスワードを入力してください。',
			'auth.login_hint' => 'Supabase が未設定の場合、この基本フローではローカルのモックセッションを使用します。',
			'auth.required_title' => 'ログインが必要です',
			'auth.required_body' => 'このタブはログイン後に利用できます。',
			'auth.session_expired' => 'セッションを確認できませんでした。再度ログインしてください。',
			'challenge.title' => 'チャレンジボード',
			'challenge.description' => 'このページはチャレンジ施策、応募、進捗チェックポイントのために用意されています。',
			'challenge.badge' => 'メンバー限定',
			'notifications.title' => '通知センター',
			'notifications.description' => 'このセクションには、アラート、イベント更新、共同作業シグナルがモバイルファーストの1画面に集約されます。',
			'notifications.badge' => 'リアルタイム対応',
			'my_page.title' => 'マイページ',
			'my_page.description' => 'プロフィール、統計、残高、生成ギャラリーを1つの画面で確認できます。',
			'my_page.appbar.menu_action' => 'メニューを開く',
			'my_page.drawer.title' => 'メニュー',
			'my_page.drawer.account_action' => 'アカウント',
			'my_page.drawer.language_settings_action' => '言語設定',
			'my_page.drawer.contact_action' => 'お問い合わせ',
			'my_page.drawer.buy_percoins_action' => 'Percoinsを購入',
			'my_page.drawer.logout_action' => 'ログアウト',
			'my_page.drawer.close_action' => 'メニューを閉じる',
			'my_page.badge' => 'アカウント',
			'my_page.default_display_name' => 'Creator',
			'my_page.default_bio' => 'プロフィールの自己紹介はまだありません。',
			'my_page.error_title' => 'マイページを読み込めませんでした',
			'my_page.error_body' => '一部セクションの取得に失敗しました。再試行してください。',
			'my_page.profile_error_title' => 'プロフィールを読み込めませんでした',
			'my_page.profile_error_body' => '現在プロフィール情報を取得できません。',
			'my_page.profile_partial_error_title' => 'プロフィール情報が最新ではない可能性があります',
			'my_page.profile_partial_error_body' => '一部プロフィールデータを取得できませんでした。更新して再試行してください。',
			'my_page.stats_title' => '統計',
			'my_page.stats_generated' => '生成数',
			'my_page.stats_posted' => '投稿数',
			'my_page.stats_likes' => 'いいね',
			'my_page.stats_views' => '閲覧数',
			'my_page.stats_followers' => 'フォロワー',
			'my_page.stats_following' => 'フォロー中',
			'my_page.stats_error_title' => '統計を読み込めませんでした',
			'my_page.stats_error_body' => '最新の統計情報を取得できません。',
			'my_page.balance_title' => 'クレジット残高',
			'my_page.balance_unit' => 'percoins',
			'my_page.balance_regular' => '通常',
			'my_page.balance_paid' => '有料',
			'my_page.balance_unlimited_bonus' => '無期限ボーナス',
			'my_page.balance_period_limited' => '期間限定',
			'my_page.balance_error_title' => '残高を読み込めませんでした',
			'my_page.balance_error_body' => '現在クレジット残高を取得できません。',
			'my_page.gallery_title' => '生成画像',
			'my_page.gallery_missing_preview' => 'キャプションまたはプロンプトのプレビューはありません。',
			'my_page.gallery_empty_title' => '生成画像はまだありません',
			'my_page.gallery_empty_body' => '最初の画像を生成するとここに表示されます。',
			'my_page.gallery_error_title' => 'ギャラリーを読み込めませんでした',
			'my_page.gallery_error_body' => '現在ギャラリー情報を取得できません。',
			_ => null,
		};
	}
}
