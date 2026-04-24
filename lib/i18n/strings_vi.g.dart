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
class TranslationsVi extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsVi _root = this; // ignore: unused_field

	@override 
	TranslationsVi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsVi(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => 'Persta.AI';
	@override String get loading => 'Dang tai';
	@override String get default_user_label => 'creator';
	@override late final _TranslationsShellVi shell = _TranslationsShellVi._(_root);
	@override late final _TranslationsNavVi nav = _TranslationsNavVi._(_root);
	@override late final _TranslationsHomeVi home = _TranslationsHomeVi._(_root);
	@override late final _TranslationsCoordinateVi coordinate = _TranslationsCoordinateVi._(_root);
	@override late final _TranslationsCommonVi common = _TranslationsCommonVi._(_root);
	@override late final _TranslationsChallengeVi challenge = _TranslationsChallengeVi._(_root);
	@override late final _TranslationsNotificationsVi notifications = _TranslationsNotificationsVi._(_root);
	@override late final _TranslationsMyPageVi my_page = _TranslationsMyPageVi._(_root);
}

// Path: shell
class _TranslationsShellVi extends TranslationsShellEn {
	_TranslationsShellVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Dieu phoi workflow AI trong mot ung dung gon nhe duy nhat.';
	@override String get header_title => 'Hom nay tren Persta.AI';
	@override String get footer_tagline => 'Flutter shell phase 1 duoc port theo app Next.js tham chieu.';
}

// Path: nav
class _TranslationsNavVi extends TranslationsNavEn {
	_TranslationsNavVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get coordinate => 'Coordinate';
	@override String get challenge => 'Challenge';
	@override String get notifications => 'Notifications';
	@override String get my_page => 'My Page';
}

// Path: home
class _TranslationsHomeVi extends TranslationsHomeEn {
	_TranslationsHomeVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get headline => 'Tao, dieu phoi va dua san pham ra ngoai trong mot noi.';
	@override String get lead => 'Be mat discovery public mobile-first cho Flutter lay cam hung tu app Next.js. Bao gom banner that, posted images that va app shell thong nhat.';
	@override String get feed_title => 'Cap nhat moi';
	@override late final _TranslationsHomeFiltersVi filters = _TranslationsHomeFiltersVi._(_root);
	@override String get banner_chip => 'Noi bat';
	@override String get banner_fallback_title => 'Mo diem nhan moi nhat';
	@override String get feed_missing_preview => 'Post nay hien chua co preview prompt hoac caption.';
	@override String get config_title => 'Can cau hinh Supabase';
	@override String get config_body => 'Home nay doc banner va public post du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.';
	@override String get error_title => 'Khong tai duoc Home';
	@override String get error_body => 'Ung dung chua the lay banner hoac public post luc nay. Thu lai sau it phut.';
	@override String get empty_title => 'Hien chua co noi dung';
	@override String get empty_body => 'Hien khong co active banner nao hoac posted image nao de hien thi.';
	@override String get link_unavailable => 'Dich den nay chua san sang ben trong Flutter app.';
	@override String get link_error => 'Khong mo duoc link banner da chon.';
	@override String get posted_at_label => 'Dang luc';
	@override String get creator_label => 'Creator';
	@override String get views_label => 'Luot xem';
	@override String get following_empty_title => 'Chua co creator dang theo doi';
	@override String get following_empty_body => 'Muc Following hien dang dung bo loc tam thoi o local. Khi co them creator de tuong tac, muc nay se ro rang hon.';
}

// Path: coordinate
class _TranslationsCoordinateVi extends TranslationsCoordinateEn {
	_TranslationsCoordinateVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Coordinate workspace';
	@override String get description => 'Khu vuc protected nay se chua collaboration lane, initiative tracking va cac man hinh execution dung chung.';
	@override String get badge => 'Protected preview';
	@override String get board_title => 'Coordinate outputs';
	@override String get board_subtitle => 'Xem cac coordinate generation moi nhat cua ban tu Supabase trong mot board owner-facing.';
	@override String get summary_title => 'Thu vien coordinate moi nhat cua ban';
	@override String get summary_count_prefix => 'So item da tai';
	@override String get posted_badge => 'Posted';
	@override String get draft_badge => 'Draft';
	@override String get prompt_label => 'Prompt';
	@override String get missing_prompt => 'Item nay khong co prompt da luu.';
	@override String get created_at_label => 'Thoi gian tao';
	@override String get model_label => 'Model';
	@override String get source_label => 'Source stock';
	@override String get empty_title => 'Chua co coordinate item nao';
	@override String get empty_body => 'Hay generate hoac dong bo coordinate output dau tien len Supabase, roi quay lai day de quan ly.';
	@override String get error_title => 'Khong tai duoc coordinate items';
	@override String get error_body => 'Board chua the lay du lieu moi nhat luc nay. Thu lai sau it phut.';
	@override String get config_title => 'Can cau hinh Supabase';
	@override String get config_body => 'Board nay doc du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.';
}

// Path: common
class _TranslationsCommonVi extends TranslationsCommonEn {
	_TranslationsCommonVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get retry_button => 'Thu lai';
	@override String get load_more_button => 'Tai them';
}

// Path: challenge
class _TranslationsChallengeVi extends TranslationsChallengeEn {
	_TranslationsChallengeVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Challenge board';
	@override String get description => 'Trang protected nay danh cho challenge campaign, bai nop va cac checkpoint tien do.';
	@override String get badge => 'Members only';
}

// Path: notifications
class _TranslationsNotificationsVi extends TranslationsNotificationsEn {
	_TranslationsNotificationsVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications center';
	@override String get description => 'Section nay se gom alert, event update va collaboration signal vao mot man hinh mobile-first.';
	@override String get badge => 'Realtime ready';
}

// Path: my_page
class _TranslationsMyPageVi extends TranslationsMyPageEn {
	_TranslationsMyPageVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'My page';
	@override String get description => 'Khu vuc profile protected nay se hien thong tin tai khoan, creator identity va tom tat hoat dong.';
	@override String get badge => 'Account space';
}

// Path: home.filters
class _TranslationsHomeFiltersVi extends TranslationsHomeFiltersEn {
	_TranslationsHomeFiltersVi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get newest => 'Moi nhat';
	@override String get recommended => 'De xuat';
	@override String get following => 'Dang theo doi';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Persta.AI',
			'loading' => 'Dang tai',
			'default_user_label' => 'creator',
			'shell.subtitle' => 'Dieu phoi workflow AI trong mot ung dung gon nhe duy nhat.',
			'shell.header_title' => 'Hom nay tren Persta.AI',
			'shell.footer_tagline' => 'Flutter shell phase 1 duoc port theo app Next.js tham chieu.',
			'nav.home' => 'Home',
			'nav.coordinate' => 'Coordinate',
			'nav.challenge' => 'Challenge',
			'nav.notifications' => 'Notifications',
			'nav.my_page' => 'My Page',
			'home.headline' => 'Tao, dieu phoi va dua san pham ra ngoai trong mot noi.',
			'home.lead' => 'Be mat discovery public mobile-first cho Flutter lay cam hung tu app Next.js. Bao gom banner that, posted images that va app shell thong nhat.',
			'home.feed_title' => 'Cap nhat moi',
			'home.filters.newest' => 'Moi nhat',
			'home.filters.recommended' => 'De xuat',
			'home.filters.following' => 'Dang theo doi',
			'home.banner_chip' => 'Noi bat',
			'home.banner_fallback_title' => 'Mo diem nhan moi nhat',
			'home.feed_missing_preview' => 'Post nay hien chua co preview prompt hoac caption.',
			'home.config_title' => 'Can cau hinh Supabase',
			'home.config_body' => 'Home nay doc banner va public post du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.',
			'home.error_title' => 'Khong tai duoc Home',
			'home.error_body' => 'Ung dung chua the lay banner hoac public post luc nay. Thu lai sau it phut.',
			'home.empty_title' => 'Hien chua co noi dung',
			'home.empty_body' => 'Hien khong co active banner nao hoac posted image nao de hien thi.',
			'home.link_unavailable' => 'Dich den nay chua san sang ben trong Flutter app.',
			'home.link_error' => 'Khong mo duoc link banner da chon.',
			'home.posted_at_label' => 'Dang luc',
			'home.creator_label' => 'Creator',
			'home.views_label' => 'Luot xem',
			'home.following_empty_title' => 'Chua co creator dang theo doi',
			'home.following_empty_body' => 'Muc Following hien dang dung bo loc tam thoi o local. Khi co them creator de tuong tac, muc nay se ro rang hon.',
			'coordinate.title' => 'Coordinate workspace',
			'coordinate.description' => 'Khu vuc protected nay se chua collaboration lane, initiative tracking va cac man hinh execution dung chung.',
			'coordinate.badge' => 'Protected preview',
			'coordinate.board_title' => 'Coordinate outputs',
			'coordinate.board_subtitle' => 'Xem cac coordinate generation moi nhat cua ban tu Supabase trong mot board owner-facing.',
			'coordinate.summary_title' => 'Thu vien coordinate moi nhat cua ban',
			'coordinate.summary_count_prefix' => 'So item da tai',
			'coordinate.posted_badge' => 'Posted',
			'coordinate.draft_badge' => 'Draft',
			'coordinate.prompt_label' => 'Prompt',
			'coordinate.missing_prompt' => 'Item nay khong co prompt da luu.',
			'coordinate.created_at_label' => 'Thoi gian tao',
			'coordinate.model_label' => 'Model',
			'coordinate.source_label' => 'Source stock',
			'coordinate.empty_title' => 'Chua co coordinate item nao',
			'coordinate.empty_body' => 'Hay generate hoac dong bo coordinate output dau tien len Supabase, roi quay lai day de quan ly.',
			'coordinate.error_title' => 'Khong tai duoc coordinate items',
			'coordinate.error_body' => 'Board chua the lay du lieu moi nhat luc nay. Thu lai sau it phut.',
			'coordinate.config_title' => 'Can cau hinh Supabase',
			'coordinate.config_body' => 'Board nay doc du lieu that tu Supabase. Hay cung cap SUPABASE_URL va SUPABASE_ANON_KEY cho ban build nay.',
			'common.retry_button' => 'Thu lai',
			'common.load_more_button' => 'Tai them',
			'challenge.title' => 'Challenge board',
			'challenge.description' => 'Trang protected nay danh cho challenge campaign, bai nop va cac checkpoint tien do.',
			'challenge.badge' => 'Members only',
			'notifications.title' => 'Notifications center',
			'notifications.description' => 'Section nay se gom alert, event update va collaboration signal vao mot man hinh mobile-first.',
			'notifications.badge' => 'Realtime ready',
			'my_page.title' => 'My page',
			'my_page.description' => 'Khu vuc profile protected nay se hien thong tin tai khoan, creator identity va tom tat hoat dong.',
			'my_page.badge' => 'Account space',
			_ => null,
		};
	}
}
