import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path/path.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/widget/_widget.dart';
import '_utils.dart';

void printDebug(Object? message, {String? title}) {
  if (kDebugMode) {
    if (!isProduction) {
      if (title != null) {
        print('****$title: $message');
      } else {
        print('***$message');
      }
    }
  }
}

/// Screen Size ----------------------------------------------------------------
double height(BuildContext context) {
  final prefHeight = MediaQuery.sizeOf(context).height;
  return prefHeight;
}

double width(BuildContext context) {
  final prefWidth = MediaQuery.sizeOf(context).width;
  return prefWidth;
}

bool isExtraSmallDevice(BuildContext context) {
  return MediaQuery.of(context).size.width <= 360;
}

bool isMobile(BuildContext context) {
  return ResponsiveBreakpoints.of(context).isMobile;
}

bool get isTablet {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalShortestSide = firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  return logicalShortestSide > 600;
}

/// Request Permission ---------------------------------------------------------
Future<void> checkPermission({Function? function}) async {
  final PermissionStatus status = await Permission.camera.status;
  switch (status) {
    case PermissionStatus.granted:
      // debugPrint('Camera permission granted.');
      appRequestPermission();
      break;
    case PermissionStatus.restricted:
      // debugPrint('Camera permission restricted.');
      appRequestPermission();
      break;
    case PermissionStatus.denied:
      // debugPrint('Camera permission denied.');
      appRequestPermission();
      break;
    case PermissionStatus.permanentlyDenied:
      // debugPrint('Camera permission permanentlyDenied.');
      openAppSettings();
      break;
    default:
  }
}

Future<void> appRequestPermission() async {
  await [
    Permission.camera,
    Permission.microphone,
    Permission.storage,
  ].request();
}

/// Check Internet -------------------------------------------------------------
Future<bool> check() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}

/// Encrypt --------------------------------------------------------------------
String encryptMd5({required String value}) {
  final List<int> bytes = utf8.encode(value); /// data being hashed
  final Digest digest = md5.convert(bytes);
  return digest.toString();
}

String encryptSHA1({required String value}) {
  final List<int> bytes = utf8.encode(value); /// data being hashed
  final Digest digest = sha1.convert(bytes);
  return digest.toString();
}

String encryptSHA256({required String value}) {
  final List<int> bytes = utf8.encode(value); /// data being hashed
  final Digest digest = sha256.convert(bytes);
  return digest.toString();
}

String encryptSHA512({required String value}) {
  final List<int> bytes = utf8.encode(value); /// data being hashed
  final Digest digest = sha512.convert(bytes);
  return digest.toString();
}

String encryptAES(String plainText, String passphrase) {
  try {
    final Uint8List salt = genRandomWithNonZero(8);
    final Tuple2<Uint8List, Uint8List> keyndIV = deriveKeyAndIV(passphrase, salt);
    final encrypt.Key key = encrypt.Key(keyndIV.item1);
    final encrypt.IV iv = encrypt.IV(keyndIV.item2);

    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypt.Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
    final Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString('Salted__') + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    rethrow;
  }
}

String encryptAES1(String text) {
  final encrypt.Key key = encrypt.Key.fromLength(32);
  final encrypt.IV iv = encrypt.IV.fromLength(16);
  final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(text, iv: iv);
  return encrypted.base64;
}

String decryptAES1(String text) {
  String passphrase = 'ti-I9rnWR6-GWF23etsy-idchEmSzU7bSMwqOaqdrXE=';
  /// Generate a 256-bit key from the passphrase using a key derivation function (e.g., PBKDF2)
  final key = encrypt.Key.fromBase64(encrypt.Key.fromUtf8(passphrase).base64);

  // final encrypt.Key key = encrypt.Key.fromUtf8(bytes.toString());
  final encrypt.IV iv = encrypt.IV.fromLength(16);
  final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));
  return encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
}

String decryptAES(String encrypted, String passphrase) {
  try {
    final Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    final Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final Uint8List salt = encryptedBytesWithSalt.sublist(8, 16);
    final Tuple2<Uint8List, Uint8List> keyndIV = deriveKeyAndIV(passphrase, salt);
    final encrypt.Key key = encrypt.Key(keyndIV.item1);
    final encrypt.IV iv = encrypt.IV(keyndIV.item2);

    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final String decrypted = encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (error) {
    rethrow;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  final Uint8List password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    // final int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.isNotEmpty) {
      preHash = Uint8List.fromList(currentHash + password + salt);
    } else {
      preHash = Uint8List.fromList(password + salt);
    }

    currentHash = md5.convert(preHash).bytes as Uint8List;
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) {
      enoughBytesForKey = true;
    }
  }

  final Uint8List keyBytes = concatenatedHashes.sublist(0, 32);
  final Uint8List ivBytes = concatenatedHashes.sublist(32, 48);
  return Tuple2(keyBytes, ivBytes);
}

Uint8List createUint8ListFromString(String s) {
  final Uint8List ret = Uint8List(s.length);
  for (int i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final Random random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}

String generateRandomString(int len) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

/// Clear Data -----------------------------------------------------------------
Future<void> clearCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      printDebug('Cache cleared.');
    }
  } catch (e) {
    printDebug('Error clearing cache: $e');
  }
}

Future<void> clearAppData() async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
      printDebug('App data directory cleared.');
    }
  } catch (e) {
    printDebug('Error clearing app data: $e');
  }
}

/// File -----------------------------------------------------------------------
String getFileExtension(String filePath) {
  return extension(filePath);
}

String getFileName(File file) {
  return path.basename(file.path);
}

Future<Uint8List?> fileToUint8List(File? captureID) async {
  if (captureID == null) return null;
  return await captureID.readAsBytes();
}

Future<File> saveSignatureImage(Uint8List bytes) async {
  final tempDir = await getApplicationDocumentsDirectory();
  return await File("${tempDir.path}/signature.jpg").writeAsBytes(bytes);
}

String? getMimeTypeFromExtension(String ext) {
  switch (ext.toLowerCase()) {
    case '.jpg':
      return 'image/jpeg';
    case '.jpeg':
      return 'image/jpeg';
    case '.png':
      return 'image/png';
    case '.pdf':
      return 'application/pdf';
    case '.doc':
      return 'application/msword';
    case '.docx':
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    default:
      return 'application/octet-stream'; // default binary type
  }
}

bool isImage(String url) {
  return url.endsWith('.png') ||
      url.endsWith('.jpg') ||
      url.endsWith('.jpeg') ||
      url.endsWith('.gif') ||
      url.endsWith('.bmp') ||
      url.endsWith('.webp');
}

bool isVideo(String url) {
  return url.endsWith('.mp4') ||
      url.endsWith('.mov') ||
      url.endsWith('.avi') ||
      url.endsWith('.wmv') ||
      url.endsWith('.flv') ||
      url.endsWith('.mkv') ||
      url.endsWith('.webm');
}

Future<File?> pickImageFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null || result.files.isEmpty) {
      showToastError(message: 'File pick canceled');
      return null;
    }

    final pickedFile = result.files.first;

    if (pickedFile.path == null) {
      showToastError(message: 'Invalid file path');
      return null;
    }

    final file = File(pickedFile.path!);

    /// Get file size safely
    int fileSizeInBytes;
    try {
      fileSizeInBytes = file.lengthSync();
    } catch (e) {
      showToastError(message: 'Could not read file size');
      return null;
    }

    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    printDebug('File size: ${fileSizeInMB.toStringAsFixed(2)} MB');

    if (fileSizeInMB > 5) {
      showToastError(message: 'File too large. Limit is 5MB.');
      return null;
    }

    return file;
  } catch (e) {
    showToastError(message: 'Something went wrong while picking the file.');
    return null;
  }
}

/// ----------------------------------------------------------------------------
bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri != null && (uri.isScheme('http') || uri.isScheme('https')) && uri.host.isNotEmpty;
}

String capitalize(String input) =>
    input.isEmpty ? '' : input[0].toUpperCase() + input.substring(1).toLowerCase();

String getFullName({
  String? firstname,
  String? middlename,
  String? lastname,
  String? suffix,
  bool middleInitialOnly = false,
  bool lastnameFirst = false,
  bool uppercase = false,
}) {
  String format(String? value) {
    final text = (value ?? '').trim();

    if (text.isEmpty) return '';

    final formatted = capitalize(text);

    return uppercase ? formatted.toUpperCase() : formatted;
  }

  String middle = format(middlename);

  /// Convert middle name to initial if enabled
  if (middleInitialOnly && middle.isNotEmpty) {
    middle = '${middle[0]}.';
  }

  final first = format(firstname);
  final last = format(lastname);
  final suf = format(suffix);

  final parts = lastnameFirst
      ? [last, first, middle, suf]
      : [first, middle, last, suf];

  return parts.where((e) => e.isNotEmpty).join(' ');
}

String normalizeSex(String? value) {
  if (value == null) return '';

  final v = value.trim().toUpperCase();

  if (v == 'M') return 'MALE';
  if (v == 'F') return 'FEMALE';

  return value; // Return original (e.g., "MALE", "FEMALE", or other)
}

/// Maps -----------------------------------------------------------------------
Future<String> getAddressFromLatLng(double lat, double lng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }
    return "Unknown location";
  } catch (e) {
    return "Error fetching location";
  }
}

Future<void> openGoogleMapsNavigation(double? lat, double? lng) async {
  if (lat == null || lng == null) {
    // Optionally log or show a snackbar/toast here
    return;
  }

  final Uri url = Uri.parse(
    'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open Google Maps';
  }
}

Future<void> openGoogleMaps(double? lat, double? lng) async {
  if (lat == null || lng == null) {
    // Optionally log or show a snackbar/toast here
    return;
  }

  // Optional but recommended: validate coordinate range
  if (lat < -90 || lat > 90 || lng < -180 || lng > 180) {
    return;
  }

  final Uri url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not open Google Maps';
  }
}

Future<void> openGoogleMapsByName(String? place) async {
  if (place == null || place.trim().isEmpty) {
    // Optionally log or show a snackbar/toast here
    return;
  }

  final Uri url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(place)}',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open Google Maps';
  }
}

/// Secure Storage -------------------------------------------------------------
AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

Future<void> writeSecureStorage({required String key, required dynamic value}) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  await storage.write(key: key, value: value);
}

Future<String?> readSecureStorage({required String key}) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String? value = await storage.read(key: key);
  return value;
}

/// Number ---------------------------------------------------------------------
String formatNumber(String? number) {
  if (number == null || number.isEmpty) return '';

  try {
    final parsed = double.parse(number);
    return NumberFormat('#,##0').format(parsed); //e.g. 1,000
  } catch (e) {
    return ''; // or handle the error accordingly
  }
}

String formatNumber2(
  String? number, {
    int decimalPlaces = 2,
    String fallback = '',
  })
{
  if (number == null) return fallback;

  final cleaned = number.replaceAll(',', '').trim();
  if (cleaned.isEmpty) return fallback;

  try {
    final parsed = double.parse(cleaned);

    final formatter = NumberFormat(
      decimalPlaces > 0
          ? '#,##0.${'0' * decimalPlaces}'
          : '#,##0',
    );

    return formatter.format(parsed);
  } catch (_) {
    return fallback;
  }
}

/// Phone Format ---------------------------------------------------------------
String formatPhoneNumber(String? mobileNumber) {
  if (mobileNumber == null || mobileNumber.trim().isEmpty) return '';

  // remove spaces, dashes, parentheses
  String num = mobileNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');

  // convert international formats
  if (num.startsWith('+63')) {
    num = '0${num.substring(3)}';
  } else if (num.startsWith('63')) {
    num = '0${num.substring(2)}';
  } else if (!num.startsWith('0')) {
    num = '0$num';
  }

  // validate Philippine mobile (11 digits, starts with 09)
  final phRegex = RegExp(r'^09\d{9}$');

  return phRegex.hasMatch(num) ? num : '';
}

String formatPhoneNumber2(String? mobileNumber) {
  if (mobileNumber == null || mobileNumber.trim().isEmpty) return '';

  // Remove spaces, dashes, parentheses
  String num = mobileNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');

  // Convert international formats to local first
  if (num.startsWith('+63')) {
    num = '0${num.substring(3)}';
  } else if (num.startsWith('63')) {
    num = '0${num.substring(2)}';
  } else if (!num.startsWith('0')) {
    num = '0$num';
  }

  // Validate Philippine mobile number
  final phRegex = RegExp(r'^09\d{9}$');

  if (!phRegex.hasMatch(num)) return '';

  // Remove leading 0 before returning
  return num.substring(1);
}

bool isValidPHPhone(String? mobileNumber) {
  return formatPhoneNumber(mobileNumber).isNotEmpty;
}

void makePhoneCall(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

/// Date and Time --------------------------------------------------------------
DateTime? parseDateByString(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

String getTimeAgo(DateTime? date) {
  return (date != null) ? timeago.format(date) : ''; //e.g a moment ago
}

String formatDate(DateTime? date) {
  //e.g. February 14, 2025
  return (date != null) ? DateFormat('MMMM dd, yyyy').format(date) : '';
}

String formatDate2(DateTime? date) {
  //e.g 2026-02-14
  return (date != null) ? DateFormat('yyyy-MM-dd').format(date) : '';
}

String formatDate3(DateTime? date) {
  //e.g. 02/14/2026
  return (date != null) ? DateFormat('MM/dd/yyyy').format(date) : '';
}

String formatDate4(DateTime? date) {
  //e.g. 02-14-2026
  return (date != null) ? DateFormat('MM-dd-yyyy').format(date) : '';
}

String formatDateWithTime(DateTime? date) {
  //e.g. February 14, 2026 08:31AM
  return (date != null) ? DateFormat('MMMM dd, yyyy hh:mma').format(date) : '';
}

String formatTime(DateTime? date) {
  //e.g 08:35 AM
  return (date != null) ? DateFormat('hh:mm a').format(date) : '';
}

String formatTimeBy24Hours(String? time24) {
  if (time24 == null || time24.trim().isEmpty) return '';

  try {
    DateTime dateTime;

    if (time24.length == 5) {
      dateTime = DateFormat('HH:mm').parse(time24);
    } else {
      dateTime = DateFormat('HH:mm:ss').parse(time24);
    }

    return DateFormat('h:mm a').format(dateTime); //e.g 8:35 AM
  } catch (_) {
    return '';
  }
}

String formatTimeByTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('hh:mm a').format(dateTime); // e.g., "03:30 PM"
}

String calculateAge(DateTime? birthDate) {
  if (birthDate == null) return '';

  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;

  /// Adjust if the birthdate hasn't occurred yet this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return '$age';
}

Future<DateTime?> callCalendar(BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime? date;
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime.now(),
  );

  if (pickedDate != null) {
    date = pickedDate;
  } else {
    printDebug('Date is not selected');
  }

  return date;
}

Future<DateTime?> callCalendarFor18YearsOld(BuildContext context) async {
  DateTime? date;
  final today = DateTime.now();
  final eighteenYearsAgo = DateTime(today.year - 18, today.month, today.day);
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: eighteenYearsAgo,
    firstDate: DateTime(1900),
    lastDate: eighteenYearsAgo,
  );

  if (pickedDate != null) {
    date = pickedDate;
  } else {
    printDebug('Date is not selected');
  }

  return date;
}

Future<TimeOfDay?> callTimePicker(BuildContext context, {TimeOfDay? initialTime}) async {
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
  );

  if (selectedTime == null) {
    printDebug('Time is not selected');
  }

  return selectedTime;
}

/// Show SnackBar --------------------------------------------------------------
void showSnackBar(BuildContext context, {
  required String message,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final SnackBar snackBar = SnackBar(
    content: CustomText(
      text: message,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    action: null,
    backgroundColor: backgroundColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarNormal(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final SnackBar snackBar = SnackBar(
    content: CustomText(
      text: message,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    action: null,
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarError(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final SnackBar snackBar = SnackBar(
    content: CustomText(
      text: message,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    action: null,
    backgroundColor: Colors.orange,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarInfo(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final SnackBar snackBar = SnackBar(
    content: CustomText(
      text: message,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    action: null,
    backgroundColor: Colors.blue,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarWarning(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final SnackBar snackBar = SnackBar(
    content: CustomText(
      text: message,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    action: null,
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

void showSnackBarDefault(
  BuildContext context, {
    required String message,

    // Widgets
    Widget? prefixIcon,
    Widget? suffixWidget,

    // Colors
    Color? backgroundColor,
    Color textColor = Colors.white,

    // Layout
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),

    double borderRadius = 12,
    double elevation = 6,
    double? width,

    // Behavior
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    Duration duration = const Duration(seconds: 3),

    // Preset
    SnackBarType? type,

    // Action
    SnackBarAction? action,

    // Callback
    VoidCallback? onVisible,
  })
{
  final messenger = ScaffoldMessenger.of(context);

  messenger.removeCurrentSnackBar();

  // Auto background color
  final Color resolvedBackgroundColor = backgroundColor ??
      switch (type) {
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.red,
        SnackBarType.warning => Colors.orange,
        SnackBarType.info => Colors.blue,
        null => Colors.black87,
      };

  // Margin only works for floating snackbar
  final EdgeInsetsGeometry? resolvedMargin =
  behavior == SnackBarBehavior.floating
      ? (margin ?? const EdgeInsets.all(16))
      : null;

  // Fixed snackbar should not have border radius
  final double resolvedBorderRadius =
  behavior == SnackBarBehavior.fixed
      ? 0
      : borderRadius;

  final snackBar = SnackBar(
    content: Row(
      children: [
        if (prefixIcon != null) ...[
          prefixIcon,
          const SizedBox(width: 10),
        ],

        Expanded(
          child: CustomText(
            text: message,
            color: textColor,
            overflow: TextOverflow.fade,
          ),
        ),

        if (suffixWidget != null) ...[
          const SizedBox(width: 10),
          suffixWidget,
        ],
      ],
    ),

    // Appearance
    backgroundColor: resolvedBackgroundColor,
    padding: padding,
    margin: resolvedMargin,
    width: width,
    elevation: elevation,

    // Shape
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        resolvedBorderRadius,
      ),
    ),

    // Behavior
    behavior: behavior,
    dismissDirection: dismissDirection,
    duration: duration,

    // Extras
    action: action,
    onVisible: onVisible,
  );

  messenger.showSnackBar(snackBar);
}

/// Show Toast -----------------------------------------------------------------
void showToast({required String message, required Color backgroundColor}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
  );
}

void showToastNormal({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.green,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
  );
}

void showToastError({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
  );
}

/// Dialog ---------------------------------------------------------------------
// Future<void> showDefaultDialog(BuildContext context, {
//   String? title,
//   required String message,
//   String? textButton,
//   String? cancelTextButton,
//   double? dialogWidth,
//   bool visibleCancelButton = false,
//   Function()? onTap,
//   Function()? onTapCancel,
//   Function()? onTapExit,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return DefaultDialog(
//         title: title,
//         message: message,
//         textButton: textButton,
//         cancelTextButton: cancelTextButton,
//         dialogWidth: dialogWidth,
//         visibleCancelButton: visibleCancelButton,
//         onTap: onTap,
//         onTapCancel: onTapCancel,
//         onTapExit: onTapExit,
//       );
//     },
//   );
// }

// Future<void> showLogoutDialog(BuildContext context) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return LogoutDialog();
//     },
//   );
// }

// Future<void> showFeedbackDialog(BuildContext context) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return FeedbackDialog();
//     },
//   );
// }

// Future<void> showVerificationDialog(BuildContext context, {
//   required String title,
//   required Profile profile,
//   Function()? onTapExit,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return VerificationDialog(
//         title: title,
//         profile: profile,
//         onTapExit: onTapExit,
//       );
//     },
//   );
// }

// Future<void> showComplianceDialog(BuildContext context, {
//   required String title,
//   required String body,
//   required String declineReason,
//   required Profile profile,
//   Function()? onTapExit,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return ForComplianceDialog(
//         title: title,
//         body: body,
//         declineReason: declineReason,
//         profile: profile,
//         onTapExit: onTapExit,
//       );
//     },
//   );
// }

// Future<void> showProcessedDialog(BuildContext context, {
//   required String title,
//   Function()? onTapExit,
//   Function()? onTapClose,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return ProcessedDialog(
//         title: title,
//         onTapExit: onTapExit,
//         onTapClose: onTapClose,
//       );
//     },
//   );
// }

// Future<void> showSmartCardDialog(BuildContext context, {
//   required String qrCode,
//   Function()? onTapExit,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return SmartCardDialog(
//         qrCode: qrCode,
//         onTapExit: onTapExit,
//       );
//     },
//   );
// }

// Future<void> showCancelDialog(BuildContext context, {
//   required String title,
//   String? titleRadio,
//   required List<String> listItems,
//   required String? selectedValue,
//   required ValueChanged<String?> onChanged,
//   String? textButtonCancel,
//   String? textButtonProceed,
//   Function()? onTapCancel,
//   Function()? onTapProceed,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return CancelDialog(
//         title: title,
//         titleRadio: titleRadio,
//         listItems: listItems,
//         selectedValue: selectedValue,
//         onChanged: onChanged,
//         textButtonCancel: textButtonCancel,
//         textButtonProceed: textButtonProceed,
//         onTapCancel: onTapCancel,
//         onTapProceed: onTapProceed,
//       );
//     },
//   );
// }

// Future<void> showErrorDialog(BuildContext context, {
//   required String title,
//   bool? noConnection,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return ErrorDialog(
//         title: title,
//         noConnection: noConnection,
//       );
//     },
//   );
// }

// Future<void> showSuccessDialog(BuildContext context, {
//   required String title,
//   Function()? onTapCancel,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return SuccessDialog(
//         title: title,
//         onTapCancel: onTapCancel,
//       );
//     },
//   );
// }

// Future<void> showVaccineDoseDialog(BuildContext context, {
//   required VaccineHistory item,
// }) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return VaccineDoseDialog(
//         item: item,
//       );
//     },
//   );
// }

/// Bottom Sheet ---------------------------------------------------------------
// void showPrivacyPolicyBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     enableDrag: false,
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     builder: (context) {
//       return const SignupPrivacyBottomSheet();
//     },
//   );
// }

// void showTermsAndConditionBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     enableDrag: false,
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     builder: (context) {
//       return const SignupTermsBottomSheet();
//     },
//   );
// }

/// Load Data ------------------------------------------------------------------
// Future<List<PHLocation>> loadSearchLocation({required BuildContext context, required String region, required String province, required String city, required String barangay}) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchSearchLocation(region: region, province: province, city: city, barangay: barangay);
//     context.read<SearchLocationListCubit>().emitSetValue(post);
//     return post;
//   } catch (error) {
//     printDebug('Error loading data: $error');
//     return [];
//   }
// }

// void loadDataRegion({required BuildContext context}) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchRegion();
//     context.read<RegionListCubit>().emitSetValue(post);
//   } catch (error) {
//     printDebug('Error loading data: $error');
//   }
// }
//
// Future<List<String>> loadDataRegion2() async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchRegion();
//     List<String> item = [];
//     for (int i = 0; i < post.length; i++) {
//       item.add(post[i].region ?? '');
//     }
//
//     return item;
//   } catch (error) {
//     printDebug('Error loading data: $error');
//     return [];
//   }
// }
//
// void loadDataProvince({
//   required BuildContext context,
//   required String selectedRegion,
// }) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchProvince(region: selectedRegion);
//     context.read<ProvinceListCubit>().emitSetValue(post);
//   } catch (error) {
//     printDebug('Error loading data: $error');
//   }
// }
//
// Future<List<String>> loadDataProvince2({required String selectedRegion}) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchProvince(region: selectedRegion);
//     List<String> item = [];
//     for (int i = 0; i < post.length; i++) {
//       item.add(post[i].province ?? '');
//     }
//
//     return item;
//   } catch (error) {
//     printDebug('Error loading data: $error');
//     return [];
//   }
// }
//
// Future<void> loadDataCity({
//   required BuildContext context,
//   required String selectedProvince,
// }) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchCity(province: selectedProvince);
//     context.read<CityListCubit>().emitSetValue(post);
//   } catch (error) {
//     printDebug('Error loading data: $error');
//   }
// }
//
// Future<List<String>> loadDataCity2({required String selectedProvince}) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchCity(province: selectedProvince);
//     List<String> item = [];
//     for (int i = 0; i < post.length; i++) {
//       item.add(post[i].city_municipality ?? '');
//     }
//
//     return item;
//   } catch (error) {
//     printDebug('Error loading data: $error');
//     return [];
//   }
// }
//
// void loadDataBarangay({
//   required BuildContext context,
//   required String selectedCity,
// }) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchBarangay(municipality: selectedCity);
//     context.read<BarangayListCubit>().emitSetValue(post);
//   } catch (error) {
//     printDebug('Error loading data: $error');
//   }
// }
//
// Future<List<String>> loadDataBarangay2({required String selectedCity}) async {
//   try {
//     List<PHLocation> post = await PostsRepo.fetchBarangay(municipality: selectedCity);
//     List<String> item = [];
//     for (int i = 0; i < post.length; i++) {
//       item.add(post[i].barangay ?? '');
//     }
//
//     return item;
//   } catch (error) {
//     printDebug('Error loading data: $error');
//     return [];
//   }
// }






