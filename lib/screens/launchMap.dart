// ignore: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchMap extends StatefulWidget {
  const LaunchMap({super.key});

  @override
  State<LaunchMap> createState() => _LaunchMapState();
}

class _LaunchMapState extends State<LaunchMap> {
  Future<void> _launchUrl() async {
    const String homeLat = "37.3230";
    const String homeLng = "-122.0312";
    // ignore: no_leading_underscores_for_local_identifiers
    final Uri _url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$homeLat,$homeLng");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchUrl();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
