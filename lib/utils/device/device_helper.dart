import 'package:device_info_plus/device_info_plus.dart';
import 'package:fdag/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  static Future<void> sendEmail(String email, BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      // query: Uri.encodeFull('subject=Hello&body=How are you?'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      UiHelper.showSnackBar(context, 'Could not launch email client',
          type: SnackBarType.error);
      debugPrint('Could not launch email client');
    }
  }

  static Future<void> callPhone(
      String phoneNumber, BuildContext context) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      UiHelper.showSnackBar(context, 'Could not launch phone app',
          type: SnackBarType.error);
      debugPrint('Could not launch phone app');
    }
  }
}
