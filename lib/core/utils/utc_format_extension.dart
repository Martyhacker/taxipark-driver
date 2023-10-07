extension FormatUtcExtension on String? {
  convert2Local() {
    if (this == null) return "Сейчас";
    String parsed = DateTime.parse(this!).toLocal().toString();
    String year = parsed.split("-")[0];
    String month = parsed.split("-")[1];
    String day = parsed.split("-")[2].split(" ")[0];
    String hour = parsed.split(" ")[1].split(":")[0];
    String minute = parsed.split(" ")[1].split(":")[1];
    // return parsed.split("-")[2];
    return "$day.$month.$year $hour:$minute";
  }
}
