import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_logger_method_channel.dart';

abstract class MyLoggerPlatform extends PlatformInterface {
  /// Constructs a MyLoggerPlatform.
  MyLoggerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyLoggerPlatform _instance = MethodChannelMyLogger();

  /// The default instance of [MyLoggerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyLogger].
  static MyLoggerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyLoggerPlatform] when
  /// they register themselves.
  static set instance(MyLoggerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
