import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';

typedef EventHandler = Future Function(Map<String, Object> data);

class FlutterOpenInstallPlugin {
  static final FlutterOpenInstallPlugin _instance =
      FlutterOpenInstallPlugin._internal();

  factory FlutterOpenInstallPlugin() => _instance;

  FlutterOpenInstallPlugin._internal();

  static late EventHandler _wakeupHandler;
  static late EventHandler _installHandler;

  static const MethodChannel _channel =
      MethodChannel('flutter_openinstall_plugin');

  // Deprecated
  // 旧版本使用，保留一段时间，防止 npm 自动升级使用最新版本插件出现问题
  static Future<void> config(bool adEnabled, String? oaid, String? gaid) async {
    log("config(bool adEnabled, String? oaid, String? gaid) 后续版本将移除，请使用configAndroid(Map options)");
    if (Platform.isAndroid) {
      var args = {};
      args["adEnabled"] = adEnabled;
      args["oaid"] = oaid;
      args['gaid'] = gaid;
      _channel.invokeMethod('config', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  static Future<void> setlog(bool enabled) async {
    if (Platform.isAndroid) {
      var args = {};
      args["enabled"] = enabled;
      _channel.invokeMethod('setlog', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  // 广告平台配置，请参考文档
  static Future<void> configAndroid(Map options) async {
    if (Platform.isAndroid) {
      _channel.invokeMethod('config', options);
    } else {
      // 仅使用于 Android 平台
    }
  }

  // 关闭剪切板读取
  static Future<void> clipBoardEnabled(bool enabled) async {
    if (Platform.isAndroid) {
      var args = {};
      args["enabled"] = enabled;
      _channel.invokeMethod('clipBoardEnabled', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  // Deprecated
  // 关闭SerialNumber读取
  static Future<void> serialEnabled(bool enabled) async {
    log("serialEnabled(bool enabled) 后续版本将移除，请使用configAndroid(Map options)");
    if (Platform.isAndroid) {
      var args = {};
      args["enabled"] = enabled;
      _channel.invokeMethod('serialEnabled', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  //设置参数并初始化
  //options可设置参数：
  //AdPlatformEnable：必要，是否开启广告平台统计功能
  //ASAEnable：必要，是否开启ASA功能
  //ASAlog：可选，使用ASA功能时是否开启log模式,正式环境中请关闭
  //idfaStr：可选，用户可以自行传入idfa字符串，不传则插件内部会获取，通过其它插件获取的idfa字符串一般格式为xxxx-xxxx-xxxx-xxxx
  Future<void> configIos(Map options) async {
    if (Platform.isAndroid) {
      //仅使用于 iOS 平台
    } else {
      _channel.invokeMethod("config", options);
    }
  }

  // wakeupHandler 拉起回调.
  // alwaysCallback 是否总是有回调。当值为true时，只要触发了拉起方法调用，就会有回调
  // permission 初始化时是否申请 READ_PHONE_STATE 权限，Deprecated。请用户自行进行权限申请
  static Future<void> init(EventHandler wakeupHandler,
      {bool alwaysCallback = false, bool permission = false}) async {
    _wakeupHandler = wakeupHandler;
    _channel.setMethodCallHandler(_handleMethod);
    _channel.invokeMethod("registerWakeup");
    if (Platform.isAndroid) {
      var args = {};
      args["alwaysCallback"] = alwaysCallback;
      if (permission) {
        log("initWithPermission 后续版本将移除，请自行进行权限申请");
        _channel.invokeMethod("initWithPermission", args);
      } else {
        _channel.invokeMethod("init", args);
      }
    } else {
      log("插件版本>=2.3.1后，由于整合了广告和ASA系统，iOS平台将通过用户手动调用init方法初始化SDK，需要广告平台或者ASA统计服务的请在init方法前调用configIos方法配置参数");
    }
  }

  // SDK内部将会一直保存安装数据，每次调用install方法都会返回值。
  // 如果调用install获取到数据并处理了自己的业务，后续不想再被触发，那么可以自己在业务调用成功时，设置一个标识，不再调用install方法
  static Future<void> install(EventHandler installHandler,
      [int seconds = 10]) async {
    var args = {};
    args["seconds"] = seconds;
    _installHandler = installHandler;
    _channel.invokeMethod('getInstall', args);
  }

  // 只有在用户进入应用后在较短时间内需要返回安装参数，但是又不想影响参数获取精度时使用。
  // 在shouldRetry为true的情况下，后续再次通过install依然可以获取安装数据
  // 通常情况下，请使用 install 方法获取安装参数
  Future<void> getInstallCanRetry(EventHandler installHandler,
      [int seconds = 3]) async {
    if (Platform.isAndroid) {
      var args = {};
      args["seconds"] = seconds;
      _installHandler = installHandler;
      _channel.invokeMethod('getInstallCanRetry', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  static Future<void> reportRegister() async {
    _channel.invokeMethod('reportRegister');
  }

  static Future<void> reportEffectPoint(String pointId, int pointValue,
      [Map<String, String>? extraMap]) async {
    var args = {};
    args["pointId"] = pointId;
    args["pointValue"] = pointValue;
    if (extraMap != null) {
      args["extras"] = extraMap;
    }
    _channel.invokeMethod('reportEffectPoint', args);
  }

  static Future<Object> reportShare(String shareCode, String platform) async {
    var args = {};
    args["shareCode"] = shareCode;
    args["platform"] = platform;
    return _channel.invokeMethod('reportShare', args);
  }

  static Future<String?> getOpid() async {
    if (Platform.isAndroid) {
      log("getOpid 当初始化未完成时，将返回空，请在业务需要时再获取，并且使用时做空判断");
      String? opid = await _channel.invokeMethod('getOpid');
      return opid;
    } else {
      // 仅使用于 Android 平台
      return "";
    }
  }

  static Future<void> setChannel(String channelCode) async {
    if (Platform.isAndroid) {
      var args = {};
      args["channelCode"] = channelCode;
      _channel.invokeMethod('setChannel', args);
    } else {
      // 仅使用于 Android 平台
    }
  }

  static Future<void> _handleMethod(MethodCall call) async {
    log(call.method);
    switch (call.method) {
      case "onWakeupNotification":
        return _wakeupHandler(call.arguments.cast<String, Object>());
      case "onInstallNotification":
        return _installHandler(call.arguments.cast<String, Object>());
      default:
        throw UnsupportedError("Unrecognized Event");
    }
  }
}
