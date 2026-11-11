import 'package:url_launcher/url_launcher.dart';

Future<bool> callStore() {
  return launchUrl(
    Uri(scheme: 'tel', path: '052723486'),
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: '_self',
  );
}

Future<bool> openStoreLink(String url) {
  return launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: '_blank',
  );
}