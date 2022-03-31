class DateHelper {
  static DateTime? milissecondsToDateTime(int? milisseconds) {
    if(milisseconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(milisseconds);
  }

  static int? dateTimeToMilisseconds(DateTime? datetime) {
    if(datetime == null) return null;
    return datetime.millisecondsSinceEpoch;
  }
}