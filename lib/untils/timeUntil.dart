String dateAndTimeToString(var timestamp, {Map<String, String> formart}) {
  if (timestamp == null || timestamp == "") {
    return "";
  }
  String targetString = "";
  final date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
// final String tmp = date.toString();
  String year = date.year.toString();
  String month = date.month.toString();
  if (date.month <= 9) {
    month = "0" + month;
  }
  String day = date.day.toString();
  if (date.day <= 9) {
    day = "0" + day;
  }
  String hour = date.hour.toString();
  if (date.hour <= 9) {
    hour = "0" + hour;
  }
  String minute = date.minute.toString();
  if (date.minute <= 9) {
    minute = "0" + minute;
  }
  String second = date.second.toString();
  if (date.second <= 9) {
    second = "0" + second;
  }
// String millisecond = date.millisecond.toString();
  String morningOrafternoon = "上午";
  if (date.hour >= 12) {
    morningOrafternoon = "下午";
  }

  if (formart["y-m"] != null && formart["m-d"] != null) {
    targetString = year + formart["y-m"] + month + formart["m-d"] + day;
  } else if (formart["y-m"] == null && formart["m-d"] != null) {
    targetString = month + formart["m-d"] + day;
  } else if (formart["y-m"] != null && formart["m-d"] == null) {
    targetString = year + formart["y-m"] + month;
  }

  targetString += " ";

  if (formart["m-a"] != null) {
    targetString += morningOrafternoon + " ";
  }

  if (formart["h-m"] != null && formart["m-s"] != null) {
    targetString += hour + formart["h-m"] + minute + formart["m-s"] + second;
  } else if (formart["h-m"] == null && formart["m-s"] != null) {
    targetString += minute + formart["m-s"] + second;
  } else if (formart["h-m"] != null && formart["m-s"] == null) {
    targetString += hour + formart["h-m"] + minute;
  }

  return targetString;
}
