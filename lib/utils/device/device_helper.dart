import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceHelper {
  DeviceHelper._();

  static Future<Map<String, String>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String model = '';
    String name = '';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
      name = androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
      name = iosInfo.name;
    }

    return {
      'model': model,
      'name': name,
    };
  }
}
