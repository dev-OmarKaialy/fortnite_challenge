import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutMeIcon extends StatelessWidget {
  const AboutMeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          launchUrlString(
            'https://dev-omarkaialy.github.io/portfolio/',

            mode: LaunchMode.inAppWebView,
          );
        },
        child: Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
