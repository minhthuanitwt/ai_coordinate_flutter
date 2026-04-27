import 'package:flutter/material.dart';

import '../../../../domain/models/coordinate_generation_job.dart';
import '../../../../i18n/strings.g.dart';
import '../coordinate_state.dart';

class CoordinateProgressSection extends StatelessWidget {
  const CoordinateProgressSection({required this.state, super.key});

  final CoordinateState state;

  @override
  Widget build(BuildContext context) {
    final activeJobs = state.activeJobs;
    if (activeJobs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.coordinate.progress_section_title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...activeJobs.map((job) => _JobRow(job: job)),
          ],
        ),
      ),
    );
  }
}

class _JobRow extends StatelessWidget {
  const _JobRow({required this.job});

  final CoordinateGenerationJob job;

  @override
  Widget build(BuildContext context) {
    final color = switch (job.status) {
      CoordinateJobStatus.completed => Colors.green.shade700,
      CoordinateJobStatus.failed => Colors.red.shade700,
      _ => Colors.blue.shade700,
    };

    final statusText = switch (job.status) {
      CoordinateJobStatus.queued => context.t.coordinate.status_queued,
      CoordinateJobStatus.processing => context.t.coordinate.status_processing,
      CoordinateJobStatus.charging => context.t.coordinate.status_charging,
      CoordinateJobStatus.generating => context.t.coordinate.status_generating,
      CoordinateJobStatus.uploading => context.t.coordinate.status_uploading,
      CoordinateJobStatus.persisting => context.t.coordinate.status_persisting,
      CoordinateJobStatus.completed => context.t.coordinate.status_completed,
      CoordinateJobStatus.failed => context.t.coordinate.status_failed,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withValues(alpha: 0.03),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_awesome_outlined, size: 15, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      statusText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text('${job.progressPercent}%'),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (job.progressPercent.clamp(0, 100)) / 100,
              ),
              if (job.errorCode != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    job.errorCode!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.red.shade700),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
