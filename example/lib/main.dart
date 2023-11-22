import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_openinstall_plugin/flutter_openinstall_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String wakeUpLog = "";
  String installLog = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // FlutterOpenInstallPlugin.setDebug(false);
    FlutterOpenInstallPlugin.init(wakeupHandler);
    // 错误：应该在业务需要时再调用 install 获取参数
    // FlutterOpenInstallPlugin.install(installHandler);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('openinstall plugin demo'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(installLog, style: const TextStyle(fontSize: 18)),
              Text(wakeUpLog, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  FlutterOpenInstallPlugin.install(installHandler, 10);
                },
                child: const Text('getInstall', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  FlutterOpenInstallPlugin.reportRegister();
                },
                child: const Text('reportRegister',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  FlutterOpenInstallPlugin.reportEffectPoint("effect_test", 1);
                },
                child: const Text('reportEffectPoint',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Map<String, String> extraMap = {
                    "systemVersion": Platform.operatingSystemVersion,
                    "flutterVersion": Platform.version
                  };
                  FlutterOpenInstallPlugin.reportEffectPoint(
                      "effect_detail", 1, extraMap);
                },
                child: const Text('reportEffectDetail',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    FlutterOpenInstallPlugin.reportShare(
                            "123456", "WechatSession")
                        .then((data) => log("reportShare : $data"));
                  },
                  child: const Text('reportShare',
                      style: TextStyle(fontSize: 16))),
            ],
          ),
        ),
      ),
    );
  }

  Future installHandler(Map<String, Object> data) async {
    log("installHandler : $data");
    setState(() {
      installLog =
          "install result : channel=${data['channelCode']}, data=${data['bindData']}\n${data['shouldRetry']}";
    });
  }

  Future wakeupHandler(Map<String, Object> data) async {
    log("wakeupHandler : $data");
    setState(() {
      wakeUpLog =
          "wakeup result : channel=${data['channelCode']}, data=${data['bindData']}\n";
    });
  }
}
