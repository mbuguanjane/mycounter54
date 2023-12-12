import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Future getCurrentLocation() async {
    // ignore: non_constant_identifier_names
    bool ServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!ServiceEnabled) {
      // print(Future.error("Location Service disabled"));
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // print(Future.error("Location Permission Denied"));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // print(Future.error("Location Permission Denied"));
    }
    // ignore: unused_local_variable
    var location = await Geolocator.getCurrentPosition();
    // print(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
