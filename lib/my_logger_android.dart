import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'my_logger_platform_interface.dart';

/// An android implementation of the MyLoggerPlatform of the MyLoggerPlugin plugin.
class MyLoggerWeb extends MyLoggerPlatform {
  /// Constructs a MyLoggerAndroid
  MyLoggerWeb();

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    if (Platform.isAndroid) {
      return 'Android ${Platform.version.substring(0, 6)}';
    } else if (Platform.isIOS) {
      return 'iOS ${Platform.version.substring(0, 6)}';
    } else if (Platform.isMacOS) {
      return 'macOS ${Platform.version.substring(0, 6)}';
    } else if (Platform.isWindows) {
      return 'Windows ${Platform.operatingSystemVersion.substring(0, 6)}';
    } else if (Platform.isLinux) {
      return 'Linux ${Platform.operatingSystemVersion.substring(0, 6)}';
    }
    return null;
  }

  Future<String?> get _localPath async {
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } else if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      return directory?.path;
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      Directory appDir = await getApplicationDocumentsDirectory();
      return appDir.path;
    }
    return null;
  }

  Future<void> logWithLevel(String message, String level, String type) async {
    switch (level) {
      case 'debug':
        log(message, name: 'DEBUG', time: DateTime.now(), level: 0);
        break;
      case 'info':
        log(message, name: 'INFO');
        break;
      case 'exception':
        log(message, name: 'EXCEPTION');
        break;
      case 'warning':
        log(message, name: 'WARNING');
        break;
      case 'error':
        log(message, name: 'ERROR');
        break;
      case 'trace':
        log(message, name: 'TRACE');
        break;
      default:
        log(message, name: 'INFO');
    }

    // Write logs to a file
    final path = await _localPath;
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    File file = File('$path/$formattedDate.txt');
    print(file);
    if (!file.existsSync()) {
      // If the file does not exist, create a new one.
      file.createSync();
    } else {
      // If the file exists, check whether the date matches today's date.
      String existingDate = file.path.substring(0, 15);
      if (existingDate != formattedDate) {
        final yesterday = now.subtract(const Duration(days: 1));
        final yesterdayFileName =
            '${yesterday.year}-${yesterday.month}-${yesterday.day}.txt';
        final yesterdayFile = File(yesterdayFileName);
        if (yesterdayFile.existsSync()) {
          yesterdayFile.deleteSync();
        }

        // If the date does not match, create a new file.
        File file = File("$path/$formattedDate.txt");
        file.createSync();
        String date =
            "${now.day}-${now.month}-${now.year} ${now.hour}:${now.second}:${now.millisecond}";
        String logLine = '{$date} [$level] $message $type\n';
        file.writeAsStringSync(logLine, mode: FileMode.writeOnlyAppend);
      } else {
        // If the date matches, overwrite the existing file.
        String date =
            "${now.day}-${now.month}-${now.year} ${now.hour}:${now.second}:${now.millisecond}";
        String logLine = '{$date} [$level] $message $type\n';
        file.writeAsStringSync(logLine, mode: FileMode.writeOnlyAppend);
      }
    }
  }

  void logInfo() {
    logWithLevel("{This is an Info message}", 'info', '{LogLevel.INFO}');
  }

  void logDebug() {
    logWithLevel("{This is a Debug message}", 'debug', '{LogLevel.INFO}');
  }

  void logException() {
    try {
      var result = 9 ~/ 0;
      print(result);
    } catch (exception) {
      logWithLevel("{This is an Exception message}", 'exception',
          '{LogLevel.EXCEPTION}');
    }
  }

  void logError() {
    try {
      var string = "Hello!";
      var index = string[-1];
      debugPrint(index.toString());
    } catch (error) {
      logWithLevel("{This is an Error message}", 'error', '{LogLevel.ERROR}');
    }
  }

  void logWarning() {
    logWithLevel(
        "{This is a Warning message}", 'warning', '{LogLevel.WARNING}');
  }

  void logTrace() {
    logWithLevel("{This is a Trace message}", 'trace', '{LogLevel.TRACE}');
  }

  void downloadLogs() {}
}
