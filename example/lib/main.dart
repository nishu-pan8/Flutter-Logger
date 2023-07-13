import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  // final _myLoggerPlugin = MyLoggerAndroid();
  MyLogger instance = MyLogger();
  // MyLoggerWeb web = MyLoggerWeb();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Logger"),
        ),
        body: (!kIsWeb)
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Running on: $_platformVersion\n'),
                    ),
                    const SizedBox(height: 50),
                    _buildRow1(context),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Running on: $_platformVersion\n'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          instance.logInfo();
                          instance.logDebug();
                          instance.logException();
                          instance.logError();
                          instance.logWarning();
                          instance.logTrace();
                        },
                        child: const Text('Log')),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          instance.downloadLogs();
                        },
                        child: const Text('Download logs'))
                  ],
                ),
              ),
      ),
    );
  }

  _buildRow1(BuildContext context) {
    return Row(
      children: [
        _buildButton("Log Event", () {
          instance.logInfo();
          instance.logDebug();
          instance.logException();
          instance.logError();
          instance.logWarning();
          instance.logTrace();
        }),
      ],
    );
  }

  _buildButton(String title, VoidCallback onPressed) {
    return Expanded(
      child: (MaterialButton(
        onPressed: onPressed,
        textColor: Colors.white,
        color: Colors.blueAccent,
        child: Text(title),
      )),
    );
  }
}
