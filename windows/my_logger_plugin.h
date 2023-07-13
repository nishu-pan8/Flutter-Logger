#ifndef FLUTTER_PLUGIN_MY_LOGGER_PLUGIN_H_
#define FLUTTER_PLUGIN_MY_LOGGER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace my_logger {

class MyLoggerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MyLoggerPlugin();

  virtual ~MyLoggerPlugin();

  // Disallow copy and assign.
  MyLoggerPlugin(const MyLoggerPlugin&) = delete;
  MyLoggerPlugin& operator=(const MyLoggerPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace my_logger

#endif  // FLUTTER_PLUGIN_MY_LOGGER_PLUGIN_H_
