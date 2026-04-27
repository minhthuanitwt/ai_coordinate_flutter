import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../i18n/strings.g.dart';
import '../../../routes/app_router.dart';
import '../../providers/auth_session_provider.dart';
import 'coordinate_view_model.dart';
import 'widgets/coordinate_gallery_section.dart';
import 'widgets/coordinate_generation_form_section.dart';
import 'widgets/coordinate_progress_section.dart';

@RoutePage()
class CoordinatePage extends ConsumerStatefulWidget {
  const CoordinatePage({super.key});

  @override
  ConsumerState<CoordinatePage> createState() => _CoordinatePageState();
}

class _CoordinatePageState extends ConsumerState<CoordinatePage> {
  bool _handledGuestRedirect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coordinateViewModelProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = ref.watch(coordinateViewModelProvider);
    final authSession = ref.watch(authSessionProvider).valueOrNull;
    final isAuthenticated = authSession?.isAuthenticated ?? false;
    final vm = ref.read(coordinateViewModelProvider.notifier);

    if (!isAuthenticated && !_handledGuestRedirect) {
      _handledGuestRedirect = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        ref.read(authRedirectTargetProvider.notifier).state =
            ProtectedDestination.coordinate;
        context.router.root.replace(const LoginRoute());
      });
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.coordinate.coordinate_page_title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.coordinate.coordinate_page_subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            t.coordinate.balance_chip.replaceAll(
                              '{{amount}}',
                              state.percoinBalance.toString(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: vm.openPercoinPurchase,
                          child: Text(t.coordinate.buy_percoins_action),
                        ),
                      ],
                    ),
                    if (state.validationErrorCode != null)
                      _InlineNotice(
                        text: _errorText(context, state.validationErrorCode!),
                      ),
                    if (state.submitErrorCode != null)
                      _InlineNotice(
                        text: _errorText(context, state.submitErrorCode!),
                      ),
                    if (state.pollingRecovery.recoveryMessageVisible)
                      _InlineNotice(
                        text: t.coordinate.still_processing_notice,
                        icon: Icons.schedule_outlined,
                      ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CoordinateGenerationFormSection(
                  state: state,
                  onPromptChanged: vm.updatePrompt,
                  onSourceModeChanged: vm.updateSourceMode,
                  onSourceImageTypeChanged: vm.updateSourceImageType,
                  onBackgroundModeChanged: vm.updateBackgroundMode,
                  onModelTierChanged: vm.updateModelTier,
                  onOutputCountChanged: vm.updateOutputCount,
                  onSelectUploadFromLibrary: vm.setUploadFromLibrary,
                  onSelectStock: vm.setStockSelection,
                  onSubmit: vm.submitGeneration,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: CoordinateProgressSection(state: state),
              ),
            ),
            CoordinateGallerySection(
              state: state,
              onLoadMore: vm.loadMore,
              onRetry: vm.refresh,
              title: t.coordinate.results_section_title,
            ),
          ],
        ),
      ),
    );
  }

  String _errorText(BuildContext context, String code) {
    final t = context.t;
    return switch (code) {
      'missing_prompt' => t.coordinate.error_missing_prompt,
      'prompt_too_long' => t.coordinate.error_prompt_too_long,
      'missing_source_image' => t.coordinate.error_missing_source,
      'unsupported_upload_type' => t.coordinate.error_unsupported_upload,
      'upload_too_large' => t.coordinate.error_upload_too_large,
      'upgrade_required' => t.coordinate.error_upgrade_required,
      'insufficient_balance' => t.coordinate.error_insufficient_balance,
      'generation_submit_failed' => t.coordinate.error_submit_failed,
      'coordinate_fetch_failed' => t.coordinate.error_history_failed,
      'coordinate_polling_failed' => t.coordinate.error_polling_failed,
      _ => t.coordinate.error_generic,
    };
  }
}

class _InlineNotice extends StatelessWidget {
  const _InlineNotice({required this.text, this.icon = Icons.info_outline});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(text, style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
