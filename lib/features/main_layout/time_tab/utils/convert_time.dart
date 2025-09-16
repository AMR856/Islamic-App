String convertToAmPm(String time24) {
  try {
    final parts = time24.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    int hour12 = hour % 12;
    if (hour12 == 0) hour12 = 12;

    String minuteStr = minute.toString().padLeft(2, '0');

    return "$hour12:$minuteStr";
  } catch (e) {
    return time24;
  }
}