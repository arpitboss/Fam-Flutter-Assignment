import 'package:url_launcher/url_launcher.dart';

class UrlService {
  // function that tries to open the given 'URL'
  static Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      // checks if the URL can be opened
      await launchUrl(uri as String); // launches the URL if it can be opened
    } else {
      throw 'Could not launch $url'; // throws an error if the URL can't be opened
    }
  }
}
