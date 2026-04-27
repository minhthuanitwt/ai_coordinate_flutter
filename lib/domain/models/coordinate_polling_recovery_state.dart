class CoordinatePollingRecoveryState {
  const CoordinatePollingRecoveryState({
    required this.activePollingStartedAt,
    required this.timeoutSeconds,
    required this.timedOutJobIds,
    required this.recoveryMessageVisible,
    required this.resumeOnReentry,
  });

  final DateTime? activePollingStartedAt;
  final int timeoutSeconds;
  final List<String> timedOutJobIds;
  final bool recoveryMessageVisible;
  final bool resumeOnReentry;

  const CoordinatePollingRecoveryState.initial()
    : activePollingStartedAt = null,
      timeoutSeconds = 90,
      timedOutJobIds = const [],
      recoveryMessageVisible = false,
      resumeOnReentry = true;
}
