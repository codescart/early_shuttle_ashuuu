import 'package:url_launcher/url_launcher.dart';


class OpenEmail {

  static Future<void> sendEmail(String recipientEmail,) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      queryParameters: {
        'subject': "Subject",
        'body': "Query",
      },
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}


