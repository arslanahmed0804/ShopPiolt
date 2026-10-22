class Purchase {
  final String id;
  final String vendor;
  final int items;
  final String dateLabel;
  final double amount;

  const Purchase({
    required this.id,
    required this.vendor,
    required this.items,
    required this.dateLabel,
    required this.amount,
  });

  String get initials {
    final p = vendor.split(' ').where((e) => e.isNotEmpty).toList();
    return p.length == 1 ? p[0][0] : (p[0][0] + p[1][0]).toUpperCase();
  }
}