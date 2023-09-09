
import 'package:url_launcher/url_launcher.dart';

class OpenDailerPad {
  static const String dialPadScheme = 'tel';
  static const String errorMessage = 'Could not launch dial pad';

  static Future<void> openDialPad(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: dialPadScheme,
      path: phoneNumber,
    );

    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      throw errorMessage;
    }
  }
}