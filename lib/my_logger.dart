import 'package:my_logger/my_logger_android.dart'
    if (dart.library.html) 'package:my_logger/my_logger_web.dart';

// export 'my_logger_platform_interface.dart';
// export 'my_logger_android.dart'
// if (dart.library.html) 'my_logger_web.dart';
// export 'my_logger_method_channel.dart';

class MyLogger {

  var instance = MyLoggerWeb();
  void logInfo() {
    instance.logInfo();
  }

  void logDebug() {
    instance.logDebug();
  }

  void logException() {
    instance.logException();
  }

  void logError() {
    instance.logError();
  }

  void logWarning() {
    instance.logWarning();
  }

  void logTrace() {
    instance.logTrace();
  }

  void downloadLogs() {
    instance.downloadLogs();
  }
}
