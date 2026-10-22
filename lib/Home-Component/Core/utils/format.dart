String formatRs(num v) {
  final s = v.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return 'Rs. $buf';
}

String formatRsShort(num v) {
  if (v >= 1000000) return 'Rs. ${(v / 1000000).toStringAsFixed(2)}m';
  if (v >= 1000) return 'Rs. ${(v / 1000).toStringAsFixed(1)}k';
  return formatRs(v);
}

String formatLongDate(DateTime d) {
  const days = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];
  const months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];
  return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';
}

String formatDateTime(DateTime d) {
  final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final minute = d.minute.toString().padLeft(2, '0');
  final period = d.hour < 12 ? 'AM' : 'PM';
  return '${d.day}/${d.month}/${d.year} $hour:$minute $period';
}

String greeting(DateTime d) {
  if (d.hour < 12) return 'Good morning';
  if (d.hour < 17) return 'Good afternoon';
  return 'Good evening';
}
