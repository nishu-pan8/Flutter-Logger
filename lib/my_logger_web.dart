// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:developer';
import 'dart:html' as html show window;
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'my_logger_platform_interface.dart';

/// A web implementation of the MyLoggerPlatform of the MyLogger plugin.
class MyLoggerWeb extends MyLoggerPlatform {
  /// Constructs a MyLoggerWeb
  MyLoggerWeb();

  static void registerWith(Registrar registry) {
    MyLoggerPlatform.instance = MyLoggerWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    if (kIsWeb) {
      final version = html.window.navigator.userAgent;
      return version;
    }
    throw UnimplementedError();
  }

  List<String> logs = [];

  Future<void> logWithLevel(String message, String level, String type) async {
    switch (level) {
      case 'debug':
        log(message, name: 'DEBUG', time: DateTime.now(), level: 0);
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
    DateTime now = DateTime.now();
    String date =
        "${now.day}-${now.month}-${now.year} ${now.hour}:${now.second}:${now.millisecond}";
    String logLine = '{$date} [$level] $message $type\n';
    logs.add(logLine);
    print(logLine);
    print("-------------");
    print(logs);
  }

  void downloadLogs() {
    String logText = logs.join('\n');
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print(logText);
    Blob blob = Blob([logText], 'text/plain', 'native');
    String url = Url.createObjectUrlFromBlob(blob);
    AnchorElement downloadLink = AnchorElement(href: url);
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    downloadLink.download = '$formattedDate.txt';
    downloadLink.click();
    Url.revokeObjectUrl(url);
  }

  void logInfo() {
    logWithLevel("{This is an Info message}", 'info', '{LogLevel.INFO}');
  }

  void logDebug() {
    logWithLevel("{This is a Debug message}", 'debug', '{LogLevel.DEBUG}');
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
}
