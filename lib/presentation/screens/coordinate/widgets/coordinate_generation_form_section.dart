import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/models/coordinate_generation_request.dart';
import '../../../../domain/models/coordinate_source_image_input.dart';
import '../../../../i18n/strings.g.dart';
import '../coordinate_state.dart';

class CoordinateGenerationFormSection extends StatelessWidget {
  const CoordinateGenerationFormSection({
    required this.state,
    required this.onPromptChanged,
    required this.onSourceModeChanged,
    required this.onSourceImageTypeChanged,
    required this.onBackgroundModeChanged,
    required this.onModelTierChanged,
    required this.onOutputCountChanged,
    required this.onSelectUploadFromLibrary,
    required this.onSelectStock,
    required this.onSubmit,
    super.key,
  });

  final CoordinateState state;
  final ValueChanged<String> onPromptChanged;
  final ValueChanged<CoordinateImageSourceMode> onSourceModeChanged;
  final ValueChanged<CoordinateSourceImageType> onSourceImageTypeChanged;
  final ValueChanged<CoordinateBackgroundMode> onBackgroundModeChanged;
  final ValueChanged<CoordinateModelTier> onModelTierChanged;
  final ValueChanged<int> onOutputCountChanged;
  final Future<void> Function({
    required String fileName,
    required String mimeType,
    required int sizeBytes,
  })
  onSelectUploadFromLibrary;
  final void Function({required String stockId, String? previewUrl})
  onSelectStock;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.coordinate.generation_section_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SegmentedButton<CoordinateImageSourceMode>(
              segments: [
                ButtonSegment(
                  value: CoordinateImageSourceMode.upload,
                  icon: const Icon(Icons.upload_file_outlined),
                  label: Text(t.coordinate.source_mode_upload),
                ),
                ButtonSegment(
                  value: CoordinateImageSourceMode.stock,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(t.coordinate.source_mode_stock),
                ),
              ],
              selected: {state.sourceMode},
              onSelectionChanged: (selection) {
                onSourceModeChanged(selection.first);
              },
            ),
            const SizedBox(height: 12),
            if (state.sourceMode == CoordinateImageSourceMode.upload)
              _UploadLibrarySelector(
                onSelectUploadFromLibrary: onSelectUploadFromLibrary,
                selectedFileName: state.sourceInput.uploadFileName,
                selectedMeta:
                    '${state.sourceInput.uploadMimeType ?? '-'} | ${(state.sourceInput.uploadSizeBytes ?? 0) ~/ 1024}KB',
              )
            else
              _StockSelector(
                onSelectStock: onSelectStock,
                selectedStockId: state.sourceInput.stockImageId,
              ),
            const SizedBox(height: 16),
            Text(
              t.coordinate.prompt_input_label,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              minLines: 3,
              maxLines: 5,
              maxLength: 400,
              onChanged: onPromptChanged,
              decoration: InputDecoration(
                hintText: t.coordinate.prompt_input_hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 560;
                final sourceTypeField =
                    DropdownButtonFormField<CoordinateSourceImageType>(
                      isExpanded: true,
                      initialValue: state.sourceImageType,
                      decoration: InputDecoration(
                        labelText: t.coordinate.source_type_label,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: CoordinateSourceImageType.illustration,
                          child: Text(
                            t.coordinate.source_type_illustration,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: CoordinateSourceImageType.real,
                          child: Text(
                            t.coordinate.source_type_real,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          onSourceImageTypeChanged(value);
                        }
                      },
                    );
                final backgroundField =
                    DropdownButtonFormField<CoordinateBackgroundMode>(
                      isExpanded: true,
                      initialValue: state.backgroundMode,
                      decoration: InputDecoration(
                        labelText: t.coordinate.background_label,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: CoordinateBackgroundMode.keep,
                          child: Text(
                            t.coordinate.background_keep,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: CoordinateBackgroundMode.includeInPrompt,
                          child: Text(
                            t.coordinate.background_include,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: CoordinateBackgroundMode.aiAuto,
                          child: Text(
                            t.coordinate.background_auto,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          onBackgroundModeChanged(value);
                        }
                      },
                    );
                if (compact) {
                  return Column(
                    children: [
                      sourceTypeField,
                      const SizedBox(height: 10),
                      backgroundField,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: sourceTypeField),
                    const SizedBox(width: 10),
                    Expanded(child: backgroundField),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 560;
                final modelField = DropdownButtonFormField<CoordinateModelTier>(
                  isExpanded: true,
                  itemHeight: null,
                  initialValue: state.modelTier,
                  decoration: InputDecoration(
                    labelText: t.coordinate.model_tier_label,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  selectedItemBuilder: (context) => CoordinateModelTier.values
                      .map(
                        (tier) => Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _tierShortLabel(context, tier),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  items: CoordinateModelTier.values
                      .map(
                        (tier) => DropdownMenuItem(
                          value: tier,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              _tierLabel(context, tier),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onModelTierChanged(value);
                    }
                  },
                );
                final countField = DropdownButtonFormField<int>(
                  isExpanded: true,
                  initialValue: state.outputCount,
                  decoration: InputDecoration(
                    labelText: t.coordinate.output_count_label,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: const [1, 2, 3, 4]
                      .map(
                        (count) => DropdownMenuItem(
                          value: count,
                          child: Text('$count'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onOutputCountChanged(value);
                    }
                  },
                );
                if (compact) {
                  return Column(
                    children: [
                      modelField,
                      const SizedBox(height: 10),
                      countField,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: modelField),
                    const SizedBox(width: 10),
                    Expanded(child: countField),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              t.coordinate.estimated_cost_label
                  .replaceAll(
                    '{{amount}}',
                    state.estimatedPercoinCost.toString(),
                  )
                  .replaceAll('{{balance}}', state.percoinBalance.toString()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (state.outputCount > state.maxOutputCount)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  t.coordinate.plan_limit_notice.replaceAll(
                    '{{max}}',
                    state.maxOutputCount.toString(),
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: state.isSubmitting ? null : onSubmit,
                icon: const Icon(Icons.auto_awesome_outlined),
                label: Text(
                  state.isSubmitting
                      ? t.coordinate.generating_button_loading
                      : t.coordinate.generating_button_ready,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _tierLabel(BuildContext context, CoordinateModelTier tier) {
    final t = context.t;
    return switch (tier) {
      CoordinateModelTier.light05k => t.coordinate.model_tier_light,
      CoordinateModelTier.standard1k => t.coordinate.model_tier_standard,
      CoordinateModelTier.pro1k => t.coordinate.model_tier_pro1k,
      CoordinateModelTier.pro2k => t.coordinate.model_tier_pro2k,
      CoordinateModelTier.pro4k => t.coordinate.model_tier_pro4k,
    };
  }

  String _tierShortLabel(BuildContext context, CoordinateModelTier tier) {
    return switch (tier) {
      CoordinateModelTier.light05k => 'Nano Banana 2 | 0.5K',
      CoordinateModelTier.standard1k => 'Nano Banana 2 | 1K',
      CoordinateModelTier.pro1k => 'Nano Banana Pro | 1K',
      CoordinateModelTier.pro2k => 'Nano Banana Pro | 2K',
      CoordinateModelTier.pro4k => 'Nano Banana Pro | 4K',
    };
  }
}

class _UploadLibrarySelector extends StatefulWidget {
  const _UploadLibrarySelector({
    required this.onSelectUploadFromLibrary,
    required this.selectedFileName,
    required this.selectedMeta,
  });

  final Future<void> Function({
    required String fileName,
    required String mimeType,
    required int sizeBytes,
  })
  onSelectUploadFromLibrary;
  final String? selectedFileName;
  final String selectedMeta;

  @override
  State<_UploadLibrarySelector> createState() => _UploadLibrarySelectorState();
}

class _UploadLibrarySelectorState extends State<_UploadLibrarySelector> {
  bool _isPicking = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.coordinate.upload_library_title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _isPicking
                  ? null
                  : () async {
                      setState(() => _isPicking = true);
                      try {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picked == null) {
                          return;
                        }
                        final file = File(picked.path);
                        final sizeBytes = await file.length();
                        final mimeType = _inferMimeType(picked.name);
                        await widget.onSelectUploadFromLibrary(
                          fileName: picked.name,
                          mimeType: mimeType,
                          sizeBytes: sizeBytes,
                        );
                      } finally {
                        if (mounted) {
                          setState(() => _isPicking = false);
                        }
                      }
                    },
              icon: Icon(
                _isPicking ? Icons.hourglass_top : Icons.photo_library_outlined,
              ),
              label: Text(
                _isPicking
                    ? t.coordinate.upload_library_loading
                    : t.coordinate.upload_library_action,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.selectedFileName == null
              ? t.coordinate.upload_none_selected
              : '${widget.selectedFileName} • ${widget.selectedMeta}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  String _inferMimeType(String fileName) {
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
      return 'image/jpeg';
    }
    if (lower.endsWith('.png')) {
      return 'image/png';
    }
    if (lower.endsWith('.webp')) {
      return 'image/webp';
    }
    return 'application/octet-stream';
  }
}

class _StockSelector extends StatelessWidget {
  const _StockSelector({
    required this.onSelectStock,
    required this.selectedStockId,
  });

  final void Function({required String stockId, String? previewUrl})
  onSelectStock;
  final String? selectedStockId;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    const stocks = [
      ('stock-casual', 'https://picsum.photos/seed/stock-casual/640/640'),
      ('stock-formal', 'https://picsum.photos/seed/stock-formal/640/640'),
      ('stock-festival', 'https://picsum.photos/seed/stock-festival/640/640'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.coordinate.stock_picker_title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stocks
              .map(
                (stock) => ChoiceChip(
                  label: Text(stock.$1),
                  selected: selectedStockId == stock.$1,
                  onSelected: (_) =>
                      onSelectStock(stockId: stock.$1, previewUrl: stock.$2),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
