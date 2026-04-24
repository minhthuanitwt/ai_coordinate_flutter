class MyPageBalance {
  const MyPageBalance({
    required this.total,
    required this.regular,
    required this.paid,
    required this.unlimitedBonus,
    required this.periodLimited,
  });

  final int total;
  final int regular;
  final int paid;
  final int unlimitedBonus;
  final int periodLimited;
}
