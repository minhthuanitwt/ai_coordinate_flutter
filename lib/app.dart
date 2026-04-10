import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'i18n/strings.g.dart';
import 'presentation/providers/app_bootstrap_provider.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

class AiCoordinateApp extends HookConsumerWidget {
  const AiCoordinateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = useMemoized(AppRouter.new);
    final bootstrapState = ref.watch(appBootstrapProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.t.app_name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter.config(),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [...GlobalMaterialLocalizations.delegates],
      builder: (context, child) {
        if (bootstrapState.isLoading) {
          return const _LoadingScaffold();
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(t.app_name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(t.loading),
          ],
        ),
      ),
    );
  }
}
