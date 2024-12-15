import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchHyperlink(String? url, BuildContext context) async {
  if (url == null) {
    return;
  }
  try {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch ${uri.toString()}'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not launch ${url}'),
      ),
    );
  }
}