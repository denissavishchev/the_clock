String timeUntil(int hour, int minute) {
  DateTime now = DateTime.now();
  final futureTime = DateTime(now.year, now.month, now.day, hour, minute, now.second,);
  var timeLeft = futureTime.difference(now).inMinutes;
  if (timeLeft < 0) {
    timeLeft = timeLeft + 1440;
  }
  final int hourLeft = timeLeft ~/ 60;
  final int minuteLeft = timeLeft % 60;
  return '${hourLeft.toString().padLeft(2, '0')}:${minuteLeft.toString().padLeft(2, '0')}';
}