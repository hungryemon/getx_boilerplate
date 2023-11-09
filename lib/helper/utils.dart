// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';

import '../data/model/response/users_response.dart';
import '/data/model/local/device_info_custom_model.dart';
import 'language/translation_service.dart';

bool get isMobile => (Get.context?.width ?? Get.width) < 800;
// (Platform.isIOS
//     ? 1024
//     : Platform.isMacOS
//         ? 800
//         : 768);

bool get isPlatformAndroidOrIOS => Platform.isAndroid || Platform.isIOS;

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

////////Sample [11.00 pm - 11.30 pm]
String fromToDuration({
  required DateTime utcDateTime,
  required int classDurationInMinutes,
}) {
  DateTime startLocalTime = utcToLocalTime(utcDateTime: utcDateTime);
  DateTime endLocalTime =
      startLocalTime.add(Duration(minutes: classDurationInMinutes));

  String startTimeInClockTime =
      showInLocalDateTime(utcDateTime: startLocalTime, showTime: true);
  String endTimeInClockTime =
      showInLocalDateTime(utcDateTime: endLocalTime, showTime: true);

  String classDuration = '$startTimeInClockTime - $endTimeInClockTime';

  return classDuration;
}

String intToStringSerial({required int serial}) {
  switch (serial) {
    case 0:
      return 'A';
    case 1:
      return 'B';
    case 2:
      return 'C';
    case 3:
      return 'D';
    case 4:
      return 'E';
    case 5:
      return 'F';
    case 6:
      return 'G';
    default:
      return '';
  }
}

int intToTimeLeft(int value,
    {bool getHours = false,
    bool getMinutes = false,
    bool getSeconds = false,
    bool getTotalMinutes = false}) {
  int h, m, s, totalMin;
  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);
  totalMin = value ~/ 60;

  if (getHours) {
    return h;
  }

  if (getMinutes) {
    return m;
  }

  if (getSeconds) {
    return s;
  }

  if (getTotalMinutes) {
    return totalMin;
  }

  return 0;
}

utcToLocalTime({required DateTime utcDateTime}) {
  return utcDateTime.toLocal();
}

showInLocalDateTime({
  required DateTime? utcDateTime,
  bool showDateMonthYearTime = false,
  bool showDateMonthTime = false,
  bool showDateMonthShortTime = false,
  bool showDay = false,
  bool showDateMonth = false,
  bool showDateMonthShort = false,
  bool showDayMonthShortDateYear = false,
  bool showDayShortTime = false,
  bool showDateMonthYear = false,
  bool showDayDateMonthYearDashedTime = false,
  bool showDate = false,
  bool showMonth = false,
  bool showTime = false,
  bool showDayTime = false,
  bool showMonthDateYear = false,
  bool showMonthShortDateYear = false,
  bool showYearMonthDateDashed = false,
  bool showDayShortDateMonthTime = false,
  bool showDayShortDateMonth = false,
  bool showDayDateMonthShort = false,
  bool showShortMonthDateYearTime = false,
  bool showYear = false,
}) {
  if (utcDateTime != null) {
    DateTime localTime = utcToLocalTime(utcDateTime: utcDateTime);
    final DateFormat formatter = showDateMonthYearTime
        ? DateFormat.d().add_MMM().add_y().addPattern(',').add_jm()
        : showDateMonth
            ? DateFormat.d().add_MMMM()
            : showDateMonthShort
                ? DateFormat.d().add_MMM()
                : showDay
                    ? DateFormat.EEEE()
                    : showDayMonthShortDateYear
                        ? DateFormat.E()
                            .addPattern(',', '')
                            .add_MMM()
                            .add_d()
                            .addPattern(',', '')
                            .add_y()
                        : showDayShortTime
                            ? DateFormat.E().addPattern(',', '').add_jm()
                            : showDayTime
                                ? DateFormat.EEEE().addPattern(',', '').add_jm()
                                : showDateMonthYear
                                    ? DateFormat.d().add_MMM().add_y()
                                    : showDayDateMonthYearDashedTime
                                        ? DateFormat.EEEE()
                                            .add_d()
                                            .add_MMMM()
                                            .addPattern(',', '')
                                            .add_y()
                                            .addPattern(' -', '')
                                            .add_jm()
                                        : showDateMonthTime
                                            ? DateFormat.d().add_MMMM().add_jm()
                                            : showDateMonthShortTime
                                                ? DateFormat.d()
                                                    .add_MMM()
                                                    .add_jm()
                                                : showDate
                                                    ? DateFormat.d()
                                                    : showMonth
                                                        ? DateFormat.MMM()
                                                        : showTime
                                                            ? DateFormat.jm()
                                                            : showMonthDateYear
                                                                ? DateFormat
                                                                        .MMMM()
                                                                    .add_d()
                                                                    .addPattern(
                                                                        ',', '')
                                                                    .add_y()
                                                                : showMonthShortDateYear
                                                                    ? DateFormat
                                                                            .MMM()
                                                                        .add_d()
                                                                        .add_y()
                                                                    : showYearMonthDateDashed
                                                                        ? DateFormat.y()
                                                                            .addPattern('-')
                                                                            .add_M()
                                                                            .addPattern('-')
                                                                            .add_d()
                                                                        : showDayShortDateMonthTime
                                                                            ? DateFormat.E().addPattern(',', '').add_d().add_MMMM().add_jm()
                                                                            : showDayShortDateMonth
                                                                                ? DateFormat.E().addPattern(',', '').add_d().add_MMM()
                                                                                : showYear
                                                                                    ? DateFormat.y()
                                                                                    : showDayDateMonthShort
                                                                                        ? DateFormat.EEEE().addPattern(',', '').add_d().add_MMM()
                                                                                        : showShortMonthDateYearTime
                                                                                            ? DateFormat.MMM().addPattern('').add_d().addPattern(',', '').add_y().addPattern(',', '').add_jm()
                                                                                            : DateFormat.EEEE().addPattern(',', '').add_d().addPattern('', '').add_MMMM();

    final String formatted = formatter.format(localTime);
    return translateDate(
        date: formatted, hour: localTime.hour, minute: localTime.minute);
  } else {
    return '';
  }
}

String translateDate({required String date, int hour = -1, int minute = -1}) {
  String newdate = date;

  String dayTimemoment = _bangaliDayTimeDuration(hours: hour, minutes: minute);
  // print("HELLOOO: ${dayTimemoment.toString()}");

  if (Get.locale == TranslationService.bengaliLocale) {
    RegExp exp = RegExp(r'[A-Za-z]');
    String dayOrMonth = "";

    int startRange = -1;

    for (int index = 0; index < newdate.length; index++) {
      if (exp.hasMatch(newdate[index])) {
        if (startRange == -1) {
          startRange = index;
        }
        dayOrMonth += newdate[index];
      } else {
        if (dayOrMonth.isNotEmpty) {
          String sub = translateDayOrMonth(dayOrMonth: dayOrMonth);
          newdate = newdate.replaceRange(startRange, index, sub);
          index = startRange + sub.length - 1;
        }
        dayOrMonth = "";
        startRange = -1;
      }
    }
    if (dayOrMonth.isNotEmpty) {
      String sub = translateDayOrMonth(dayOrMonth: dayOrMonth);

      ///print("sub $sub");
      newdate =
          newdate.replaceRange(startRange, startRange + dayOrMonth.length, sub);
      //print("new date = $newdate");
    }
    dayOrMonth = "";
    startRange = -1;
    //print("new date = $newdate");

    String bangaliFormateTime =
        _bangaliTimemomentFormat(dayTimemoment, newdate);
    String newTime = translateDigit(bangaliFormateTime);

    //print("new date = $bangaliFormateTime");
    return newTime;
  }
  return newdate;
}

String translateDayOrMonth({String dayOrMonth = ""}) {
  // print("day month $dayOrMonth");
  switch (dayOrMonth) {
    //day
    case 'Sun':
      return 'রবি';
    case 'Mon':
      return 'সোম';
    case 'Tue':
      return 'মঙ্গল';
    case 'Wed':
      return 'বুধ';
    case 'Thu':
      return 'বৃহস্পতি';
    case 'Fri':
      return 'শুক্র';
    case 'Sat':
      return 'শনি';

    //day full
    case 'Sunday':
      return 'রবিবার';
    case 'Monday':
      return 'সোমবার';
    case 'Tuesday':
      return 'মঙ্গলবার';
    case 'Wednesday':
      return 'বুধবার';
    case 'Thursday':
      return 'বৃহস্পতিবার';
    case 'Friday':
      return 'শুক্রবার';
    case 'Saturday':
      return 'শনিবার';

    /// month sort formet
    case 'Jan':
      return 'জানু';
    case 'Feb':
      return 'ফেব্রু';
    case 'Mar':
      return 'মার্চ';
    case 'Apr':
      return 'এপ্রিল';
    case 'May':
      return 'মে';
    case 'Jun':
      return 'জুন';
    case 'Jul':
      return 'জুলাই';
    case 'Aug':
      return 'আগস্ট';
    case 'Sep':
      return 'সেপ্টেম্বর';
    case 'Oct':
      return 'অক্টোবর';
    case 'Nov':
      return 'নভেম্বর';
    case 'Dec':
      return 'ডিসেম্বর';

    /// month
    case 'January':
      return 'জানু';
    case 'February':
      return 'ফেব্রু';
    case 'March':
      return 'মার্চ';
    case 'April':
      return 'এপ্রিল';
    case 'June':
      return 'জুন';
    case 'July':
      return 'জুলাই';
    case 'August':
      return 'আগস্ট';
    case 'September':
      return 'সেপ্টেম্বর';
    case 'October':
      return 'অক্টোবর';
    case 'November':
      return 'নভেম্বর';
    case 'December':
      return 'ডিসেম্বর';

    default:
      return dayOrMonth;
  }
}

String _bangaliDayTimeDuration({int hours = -1, int minutes = -1}) {
  if (hours >= 19 && (hours > 19 || minutes >= 30)) {
    return "রাত";
  } else if (hours >= 18 && (hours > 18 || minutes >= 30)) {
    return "সন্ধ্যা";
  } else if (hours >= 15 && (hours > 15 || minutes >= 30)) {
    return "বিকাল";
  } else if (hours >= 12) {
    return "দুপুর";
  } else if (hours >= 6) {
    return "সকাল";
  } else if (hours >= 4) {
    return "ভোর";
  } else {
    return "রাত";
  }
}

String _bangaliTimemomentFormat(String? moment, String time) {
  List<String> timeList = [];
  if (time.contains("PM")) {
    timeList = time.split("PM");
    timeList.removeLast();
    timeList = timeList[0].split(" ");
    timeList.add("PM");
  } else if (time.contains("AM")) {
    timeList = time.split("AM");
    timeList.removeLast();
    timeList = timeList[0].split(" ");
    timeList.add("AM");
  } else {
    timeList = time.split(" ");
  }
  // print("String $timeList");
  for (int index = 0; index < timeList.length; index++) {
    if (timeList[index].contains('AM')) {
      timeList[index] = timeList[index].replaceFirstMapped('AM', (match) => '');
      // if (timeList.length == 1) {
      //   timeList.add(timeList[index]);
      //   timeList[index] = moment ?? '';
      // } else {
      timeList[index] = moment ?? '';
      var temp = timeList[index - 1];
      timeList[index - 1] = timeList[index];
      timeList[index] = temp;
      // }
    }
    if (timeList[index].contains('PM')) {
      timeList[index] = timeList[index].replaceFirstMapped('PM', (match) => '');
      // if (timeList.length == 1) {
      //   timeList.add(timeList[index]);
      //   timeList[index] = moment ?? '';
      // } else {
      timeList[index] = moment ?? '';
      var temp = timeList[index - 1];
      timeList[index - 1] = timeList[index];
      timeList[index] = temp;
      // }
    }
  }
  //print("HELLOOOO: ${timeList.join("")}");
  return timeList.join(" ");
}

int compareCurrentTimeWithLocalTimeInSeconds({required DateTime utcDateTime}) {
  DateTime localTime = utcToLocalTime(utcDateTime: utcDateTime);

  DateTime currentTime = DateTime?.now();

  int difference = localTime.difference(currentTime).inSeconds;

  return difference;
}

int compareLocalTimeWithCurrentTimeInDays({required DateTime? utcDateTime}) {
  DateTime localTime =
      utcDateTime != null ? utcToLocalTime(utcDateTime: utcDateTime) : null;

  DateTime currentTime = DateTime?.now();

  int difference = localTime.difference(currentTime).inDays;

  return difference;
}

int compareLocalTimeWithCurrentTimeInHours({required DateTime? utcDateTime}) {
  DateTime localTime =
      utcDateTime != null ? utcToLocalTime(utcDateTime: utcDateTime) : null;

  DateTime currentTime = DateTime?.now();

  int difference = localTime.difference(currentTime).inHours;

  return difference;
}

int compareLocalTimeWithCurrentTimeInMinutes({required DateTime? utcDateTime}) {
  DateTime localTime =
      utcDateTime != null ? utcToLocalTime(utcDateTime: utcDateTime) : null;

  DateTime currentTime = DateTime?.now();

  int difference = localTime.difference(currentTime).inMinutes;

  return difference;
}

int compareTwoLocalTimeInDays(
    {required DateTime? from, required DateTime? to}) {
  DateTime fromLocalTime =
      from != null ? utcToLocalTime(utcDateTime: from) : null;

  DateTime toLocalTime = to != null ? utcToLocalTime(utcDateTime: to) : null;

  int difference = toLocalTime.difference(fromLocalTime).inDays;

  return difference + 1;
}

int compareCurrentTimeWithLocalTimeDifference(
    {required DateTime? utcDateTime,
    bool inHours = false,
    bool inMinutes = false,
    bool inDays = false,
    bool inSeconds = false}) {
  DateTime localTime =
      utcDateTime != null ? utcToLocalTime(utcDateTime: utcDateTime) : null;

  DateTime currentTime = DateTime?.now();

  int difference = -1;
  if (inHours) {
    difference = currentTime.difference(localTime).inHours;
  }
  if (inDays) {
    difference = currentTime.difference(localTime).inDays;
  }
  if (inMinutes) {
    difference = currentTime.difference(localTime).inMinutes;
  }
  if (inSeconds) {
    difference = currentTime.difference(localTime).inSeconds;
  }

  /* print(
      "current time $currentTime local time = $localTime difference = $difference"); */
  return difference;
}

int getRemainingDays({
  required DateTime? livePlusSchedule,
  required DateTime? liveSchedule,
}) {
  DateTime? date;
  if (livePlusSchedule != null && liveSchedule != null) {
    livePlusSchedule.isBefore(liveSchedule)
        ? date = livePlusSchedule
        : date = liveSchedule;
  } else if (livePlusSchedule != null) {
    date = livePlusSchedule;
  } else if (liveSchedule != null) {
    date = liveSchedule;
  }

  return compareLocalTimeWithCurrentTimeInDays(utcDateTime: date);
}

isFileViewable({required String fileName}) {
  if (fileName.isTxtFileName ||
      fileName.isPDFFileName ||
      fileName.isImageFileName) {
    return true;
  } else {
    return false;
  }
}

bool isVideo(String extension) {
  return extension == 'mp4' ||
      extension == 'avi' ||
      extension == 'avi' ||
      extension == 'mkv' ||
      extension == 'mpg' ||
      extension == 'mpeg' ||
      extension == '3gp' ||
      extension == 'wmv' ||
      extension == 'vob';
}

bool isImage(String extension) {
  return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
}

bool isAudio(String extension) {
  return extension == 'mp3' ||
      extension == 'wav' ||
      extension == 'aac' ||
      extension == 'wma';
}

bool isDocument(String extension) {
  return extension == 'doc' ||
      extension == 'docx' ||
      extension == 'ppt' ||
      extension == 'pptx' ||
      extension == 'pptm' ||
      extension == 'pps' ||
      extension == 'ppsm' ||
      extension == 'ppsx' ||
      extension == 'pdf' ||
      extension == 'xls' ||
      extension == 'xlsx' ||
      extension == 'csv';
}

bool isSupportedFile(String extension) {
  return isImage(extension) ||
      isVideo(extension) ||
      isAudio(extension) ||
      isDocument(extension);
}

Future<bool> customLaunchURL(String? url) async {
  final processedUrl = Uri.parse(url!);
  try {
    print('LAUNCHING...');
    await launchUrl(processedUrl, mode: LaunchMode.externalApplication);
    return true;
  } catch (e) {
    debugPrint(e.toString());

    return false;
  }
}

String? convertYoutubeUrlToId(String url, {bool trimWhitespaces = true}) {
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}

extension Ex on double {
  double toPrecisionDouble(int n) => double.parse(toStringAsFixed(n));
}

extension StringX on String {
  String take(int nbChars) => substring(0, nbChars.clamp(0, length));
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}

Future<String> getDirectoryPath() async {
  String path = '';

  Directory baseDir = await getApplicationDocumentsDirectory();
  path = '${baseDir.path}/';
  return path;
}

Future<String> getFilePath(uniqueFileName) async {
  String path = '';

  Directory baseDir = await getApplicationDocumentsDirectory();
  path = '${baseDir.path}/$uniqueFileName';
  // print('SavePath:' + path);
  return path;
}

checkIfFileExists(uniqueFileName) async {
  String syncPath = await getFilePath(uniqueFileName);
  // print("checking path : $syncPath");
  bool fileExists =
      File(syncPath).existsSync() || Directory(syncPath).existsSync();
  return fileExists;
}

checkIfFileExistsWithDirectory(path) async {
  bool fileExists = File(path).existsSync();
  return fileExists;
}

Future<void> deleteIfFileExists(uniqueFileName) async {
  var syncPath = await getFilePath(uniqueFileName);
  try {
    // goBack();
    await checkIfFileExists(uniqueFileName)
        ? await File(syncPath).delete(recursive: true)
        : null;
    print("FILE DELETE SUCCESS");
  } catch (err) {
    try {
      await Directory(syncPath).delete(recursive: true);
      print("FILE DELETE DIRECTORY SUCCESS");
    } catch (e) {
      print("Delete Error: $e");
    }
    // goBack();
  }
}

Future<void> openFile(uniqueFileName, fileType) async {
  var filePath = await getFilePath(uniqueFileName);

  var result = await OpenFilex.open(
    filePath,
    type: fileType,
  );

  if (result.type != ResultType.done) {
    result = await OpenFilex.open(
      filePath,
    );
  }
}

Future<bool> isInternetConnectionAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.bluetooth ||
          connectivityResult == ConnectivityResult.ethernet ||
          connectivityResult == ConnectivityResult.vpn
      ? true
      : false;
}

bool isNumeric(String str) {
  try {
    var value = int.parse(str);
    if (value.isNegative) {
      return false;
    } else {
      return true;
    }
  } on FormatException {
    return false;
  } catch (e) {
    return false;
  }
}

String parseJwtToken(String? token) {
  try {
    if (token == null) return "";
    if (!token.contains(".")) return "";
    final arr = token.split(".");
    if (arr.length < 2) return "";
    String foo = arr[1];
    List<int> tokenRes = base64.decode(base64.normalize(foo));
    dynamic data = jsonDecode(utf8.decode(tokenRes));
    if (data["exp"] == null) return "";
    final now = DateTime.now().millisecondsSinceEpoch / 1000;

    if (data["exp"] < now) {
      throw Exception("Token expired");
    }
    return token;
  } catch (err) {
    print("ERROR parseJwtToken $err");
    return "";
  }
}

CurrentUserData parseCurrentUserFromJwtToken(String token) {
  if (token.isEmpty) return CurrentUserData();
  final arr = token.split(".");
  if (arr.length < 2) return CurrentUserData();
  String foo = arr[1];
  List<int> tokenRes = base64.decode(base64.normalize(foo));
  return CurrentUserData.fromJson(jsonDecode(utf8.decode(tokenRes)));
}

String getCurrentDateAsString() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}

//
String convertStringToLink(String textData) {
  //
  final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final urlMatches = urlRegExp.allMatches(textData);
  List<String> urls = urlMatches
      .map((urlMatch) => textData.substring(urlMatch.start, urlMatch.end))
      .toList();
  List linksString = [];
  for (var linkText in urls) {
    linksString.add(linkText);
  }

  if (linksString.isNotEmpty) {
    for (var linkTextData in linksString) {
      textData = textData.replaceAll(
          linkTextData,
          // ignore: prefer_interpolation_to_compose_strings
          '${'<a href="' + linkTextData + '" target="_blank">' + linkTextData}</a>');
    }
  }
  return textData;
}

msToTime(int ms) {
  int min = ((ms / 1000 / 60).floor() << 0);
  int sec = ((ms / 1000) % 60).floor();
  bool minLengthTwoDigit = min.toString().length > 1;
  bool secLengthTwoDigit = sec.toString().length > 1;
  return ('${!minLengthTwoDigit ? '0' : ''}$min:${!secLengthTwoDigit ? '0' : ''}$sec');
}

String translateDigit(dynamic number) {
  String bengali = '';
  for (int i = 0; i < number.toString().length; i++) {
    switch (number.toString()[i]) {
      case '1':
        bengali = '$bengali১';
        break;
      case '2':
        bengali = '$bengali২';
        break;
      case '3':
        bengali = '$bengali৩';
        break;
      case '4':
        bengali = '$bengali৪';
        break;
      case '5':
        bengali = '$bengali৫';
        break;
      case '6':
        bengali = '$bengali৬';
        break;
      case '7':
        bengali = '$bengali৭';
        break;
      case '8':
        bengali = '$bengali৮';
        break;
      case '9':
        bengali = '$bengali৯';
        break;
      case '0':
        bengali = '$bengali০';
        break;
      default:
        bengali = bengali + number.toString()[i];
    }
  }
  return Get.locale == TranslationService.bengaliLocale
      ? bengali
      : number.toString();
}

bengaliNumberSerialize({required int number}) {
  switch (number) {
    case 1:
    case 5:
    case 7:
    case 8:
    case 9:
    case 10:
      return "ম";
    case 2:
    case 3:
      return "য়";
    case 4:
      return "র্থ";
    case 6:
      return "ষ্ঠ";
    default:
      return "তম";
  }
}

englishNumberSerialize({required int number}) {
  switch (number) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

String getLocaleBasedNumberSerial(
    {required Locale currentLocale, required int number}) {
  return currentLocale == TranslationService.bengaliLocale
      ? (translateDigit(number) + bengaliNumberSerialize(number: number))
      : (number.toString() + englishNumberSerialize(number: number));
}

renderModuleColor(int day) {
  var mod = day % 7;
  switch (mod) {
    case 1:
      return const Color(0xFF12B76A);
    case 2:
      return const Color(0xFFFBAA00);
    case 3:
      return const Color(0xFFFF8C4B);
    case 4:
      return const Color(0xFFAD65FC);
    case 5:
      return const Color(0xFF00B2FD);
    case 6:
      return const Color(0xFFFC575E);
    default:
      return const Color(0xFFFC5ED5);
  }
}

calculatePercentage({required int firstNumber, required int secondNumber}) {
  double remainingdDaysPercentage = (firstNumber - secondNumber).abs() /
      (firstNumber > secondNumber ? firstNumber : secondNumber);

  if (remainingdDaysPercentage < 0) {
    remainingdDaysPercentage = 1;
  }

  return 1 - remainingdDaysPercentage;
}

Future<DeviceInfoCustom?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  String? deviceId = await PlatformDeviceId.getDeviceId;
  if (Platform.isWindows) {
    var windowsDeviceInfo = await deviceInfo.windowsInfo;
    return DeviceInfoCustom(
      deviceId: deviceId,
      model: windowsDeviceInfo.productId,
      brand: windowsDeviceInfo.productName,
      display: windowsDeviceInfo.displayVersion,
      version: windowsDeviceInfo.majorVersion.toString(),
    );
  }
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return DeviceInfoCustom(
      deviceId: deviceId,
      model: iosDeviceInfo.model,
      brand: iosDeviceInfo.systemName,
      version: iosDeviceInfo.systemVersion,
    ); // unique ID on iOS
  }
  if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return DeviceInfoCustom(
      deviceId: deviceId,
      model: androidDeviceInfo.product,
      brand: androidDeviceInfo.manufacturer,
      display:
          "${androidDeviceInfo.displayMetrics.heightPx} X ${androidDeviceInfo.displayMetrics.widthPx}",
      version: androidDeviceInfo.version.sdkInt.toString(),
    );
  }

  if (Platform.isMacOS) {
    var macOsDeviceInfo = await deviceInfo.macOsInfo;
    return DeviceInfoCustom(
      deviceId: deviceId,
      model: macOsDeviceInfo.model,
      brand: macOsDeviceInfo.arch,
      version: macOsDeviceInfo.osRelease,
    );
  }

  if (Platform.isLinux) {
    var linuxDeviceInfo = await deviceInfo.linuxInfo;
    return DeviceInfoCustom(
      deviceId: deviceId,
      model: linuxDeviceInfo.versionCodename,
      brand: linuxDeviceInfo.prettyName,
      version: linuxDeviceInfo.version,
    );
  }
  return DeviceInfoCustom();
}

void scrollToFocusedWidget(BuildContext context,
    {required FocusNode focusNode,
    required ScrollController scrollController}) {
  // Calculate the scroll offset to bring the focused widget into view.
  final double offset = scrollController.offset +
      focusNode.offset.dy -
      (MediaQuery.of(context).size.height / 2);

  // Scroll to the calculated offset with some animation (adjust duration as needed).
  scrollController.animateTo(
    offset,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}

String countryCodeToEmoji(String countryCode) {
  // 0x41 is Letter A
  // 0x1F1E6 is Regional Indicator Symbol Letter A
  // Example :
  // firstLetter U => 20 + 0x1F1E6
  // secondLetter S => 18 + 0x1F1E6
  // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}
