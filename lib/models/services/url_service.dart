import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher(String url) async {
  // Try to launch the URL
  if (!await launchUrl(Uri.parse(url))) {
    // Throw an exception if the URL can’t be launched
    throw Exception('Could not launch $url');
  }
}
