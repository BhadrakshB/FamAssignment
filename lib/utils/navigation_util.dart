import 'package:flutter/material.dart';

class NavigationUtil {
  /// Navigate to a new screen.
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Handle deep linking URLs.
  static void handleDeepLink(BuildContext context, String url) {
    // Example: Redirect based on URL structure
    if (url.contains("example.com/special")) {
      navigateTo(context, const SpecialScreen());
    } else {
      debugPrint("Unhandled deep link: $url");
    }
  }
}

/// Placeholder widget for special deep links.
class SpecialScreen extends StatelessWidget {
  const SpecialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Special Screen")),
      body: const Center(child: Text("You navigated here via deep link!")),
    );
  }
}
