import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class LocationReportData {
  final double latitude;
  final double longitude;
  final String address;
  final String formattedDate;
  final String formattedTime;

  LocationReportData({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.formattedDate,
    required this.formattedTime,
  });
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isLoading = false;

  String _statusMessage =
      'Press the button to capture your current location.';

  double? _latitude;
  double? _longitude;
  String _address = '';
  String _date = '';
  String _time = '';

  Future<void> _getCurrentLocation() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _statusMessage = 'Checking location services...';
    });

    try {
      // ==========================================
      // CHECK IF GPS / LOCATION SERVICES ARE ON
      // ==========================================

      final bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
          _statusMessage =
              'Location services are disabled. Please enable location/GPS on the emulator and try again.';
        });
        return;
      }

      // ==========================================
      // CHECK LOCATION PERMISSION
      // ==========================================

      if (!mounted) return;

      setState(() {
        _statusMessage = 'Checking location permission...';
      });

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
          _statusMessage =
              'Location permission was denied. Please allow location access.';
        });
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
          _statusMessage =
              'Location permission is permanently denied. Please enable it in Android app settings.';
        });
        return;
      }

      // ==========================================
      // GET CURRENT GPS LOCATION
      // WITH TIMEOUT
      // ==========================================

      if (!mounted) return;

      setState(() {
        _statusMessage = 'Getting GPS coordinates...';
      });

      Position? position;

      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        ).timeout(
          const Duration(seconds: 20),
        );
      } catch (_) {
        // ==========================================
        // FALLBACK TO LAST KNOWN LOCATION
        // ==========================================

        if (!mounted) return;

        setState(() {
          _statusMessage =
              'Current GPS is taking too long. Checking last known location...';
        });

        position = await Geolocator.getLastKnownPosition();
      }

      // ==========================================
      // NO LOCATION AVAILABLE
      // ==========================================

      if (position == null) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
          _statusMessage =
              'No GPS location is available. Set a location in the Android Emulator and try again.';
        });
        return;
      }

      // ==========================================
      // GET ADDRESS FROM COORDINATES
      // ==========================================

      if (!mounted) return;

      setState(() {
        _statusMessage = 'Getting address from coordinates...';
      });

      String fetchedAddress =
          'Address could not be retrieved';

      try {
        final List<Placemark> placemarks =
            await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        ).timeout(
          const Duration(seconds: 15),
        );

        if (placemarks.isNotEmpty) {
          final Placemark place = placemarks.first;

          final List<String> addressParts = [];

          if (place.name != null &&
              place.name!.trim().isNotEmpty) {
            addressParts.add(place.name!.trim());
          }

          if (place.street != null &&
              place.street!.trim().isNotEmpty &&
              !addressParts.contains(place.street!.trim())) {
            addressParts.add(place.street!.trim());
          }

          if (place.subLocality != null &&
              place.subLocality!.trim().isNotEmpty) {
            addressParts.add(place.subLocality!.trim());
          }

          if (place.locality != null &&
              place.locality!.trim().isNotEmpty) {
            addressParts.add(place.locality!.trim());
          }

          if (place.administrativeArea != null &&
              place.administrativeArea!.trim().isNotEmpty) {
            addressParts.add(place.administrativeArea!.trim());
          }

          if (place.postalCode != null &&
              place.postalCode!.trim().isNotEmpty) {
            addressParts.add(place.postalCode!.trim());
          }

          if (place.country != null &&
              place.country!.trim().isNotEmpty) {
            addressParts.add(place.country!.trim());
          }

          if (addressParts.isNotEmpty) {
            fetchedAddress = addressParts.join(', ');
          }
        }
      } catch (_) {
        fetchedAddress =
            'GPS coordinates captured successfully. Address lookup is unavailable.';
      }

      // ==========================================
      // CAPTURE DATE AND TIME
      // ==========================================

      final DateTime now = DateTime.now();

      if (!mounted) return;

      setState(() {
        _latitude = position!.latitude;
        _longitude = position.longitude;
        _address = fetchedAddress;
        _date = DateFormat('dd MMMM yyyy').format(now);
        _time = DateFormat('hh:mm a').format(now);
        _statusMessage =
            'Current location captured successfully.';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _statusMessage =
            'Unable to get location. Please set an emulator location and try again.';
      });
    }
  }

  void _useLocation() {
    if (_latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please capture your current location first.',
          ),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      LocationReportData(
        latitude: _latitude!,
        longitude: _longitude!,
        address: _address,
        formattedDate: _date,
        formattedTime: _time,
      ),
    );
  }

  Widget _detailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLocation =
        _latitude != null && _longitude != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Capture Current Location',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      hasLocation
                          ? Icons.location_on
                          : Icons.my_location,
                      size: 64,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Inspection Location & GPS',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: CircularProgressIndicator(),
                      ),

                    Text(
                      _statusMessage,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed:
                    _isLoading ? null : _getCurrentLocation,
                icon: const Icon(
                  Icons.gps_fixed,
                ),
                label: Text(
                  hasLocation
                      ? 'REFRESH CURRENT LOCATION'
                      : 'GET CURRENT LOCATION',
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (hasLocation) ...[
              _detailCard(
                icon: Icons.my_location,
                title: 'Latitude',
                value: _latitude!.toStringAsFixed(6),
              ),

              _detailCard(
                icon: Icons.explore,
                title: 'Longitude',
                value: _longitude!.toStringAsFixed(6),
              ),

              _detailCard(
                icon: Icons.location_city,
                title: 'Current Address',
                value: _address,
              ),

              _detailCard(
                icon: Icons.calendar_today,
                title: 'Captured Date',
                value: _date,
              ),

              _detailCard(
                icon: Icons.access_time,
                title: 'Captured Time',
                value: _time,
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _useLocation,
                  icon: const Icon(
                    Icons.check_circle,
                  ),
                  label: const Text(
                    'USE THIS LOCATION IN REPORT',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}