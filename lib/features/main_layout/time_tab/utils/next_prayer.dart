String nextPrayerTime(DateTime now, List salahTimings) {
  Duration? shortestDiff;
  String? nextPrayer;

  for (String prayerTime in salahTimings) {
    final parts = prayerTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final prayerDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (prayerDateTime.isAfter(now)) {
      final diff = prayerDateTime.difference(now);

      if (shortestDiff == null || diff < shortestDiff) {
        shortestDiff = diff;
        nextPrayer = prayerTime;
      }
    }
  }

  if (shortestDiff == null) {
    return "No more prayers today";
  }

  final hours = shortestDiff.inHours;
  final minutes = shortestDiff.inMinutes % 60;

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}