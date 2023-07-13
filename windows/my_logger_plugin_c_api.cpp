#include "include/my_logger/my_logger_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_logger_plugin.h"

void MyLoggerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_logger::MyLoggerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
