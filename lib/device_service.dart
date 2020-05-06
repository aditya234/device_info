import 'package:device_info/device_info.dart';
import 'package:flutter_udid/flutter_udid.dart';

class DeviceService {
  DeviceService._();

  static DeviceService _instance = DeviceService._();

  factory DeviceService() => _instance;

  Future<String> get deviceId async {
    String udid = await FlutterUdid.consistentUdid;
    print('hdfsjdkfkdsjf $udid');
    return udid;
  }

  Future<AndroidDeviceInfo> get deviceModel async {
    AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    return androidDeviceInfo;
  }
}
