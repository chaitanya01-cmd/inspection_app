import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

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
  final Geocoding _geocoding = Geocoding();

  bool _isLoading = true;
  String _statusMessage = 'Fetching location...';

  double? _latitude;
  double? _longitude;
  String _address = 'Fetching address...';
  String _date = '';
  String _time = '';

  @override
  void initState() {
    super.initState();
    _fetchLocationAndDetails();
  }

  Future<void> _fetchLocationAndDetails() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Checking permissions...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _statusMessage = 'Location services are disabled on this device.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _statusMessage = 'Location permissions are denied.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _statusMessage = 'Location permissions are permanently denied.';
          _isLoading = false;
        });
        return;
      }

      setState(() => _statusMessage = 'Getting GPS location...');
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      setState(() => _statusMessage = 'Fetching address...');
      String fetchedAddress = 'Address unavailable';
      try {
        List<Placemark> placemarks = await _geocoding.placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          fetchedAddress = '${place.street}, ${place.locality}, ${place.postalCode}';
        }
      } catch (e) {
        fetchedAddress = 'Could not retrieve address details';
      }

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd MMMM yyyy').format(now);
      String formattedTime = DateFormat('hh:mm a').format(now);

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _address = fetchedAddress;
        _date = formattedDate;
        _time = formattedTime;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error fetching data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proof of Location & Time'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_statusMessage),
                ],
              ),
            )
          : _latitude == null || _longitude == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_statusMessage),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchLocationAndDetails,
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(_latitude!, _longitude!),
                              initialZoom: 15.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.flutter_application_1',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(_latitude!, _longitude!),
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Inspection Report Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 8),
                                _buildDetailRow(
                                  Icons.my_location,
                                  'Coordinates',
                                  '${_latitude!.toStringAsFixed(4)}, ${_longitude!.toStringAsFixed(4)}',
                                ),
                                const SizedBox(height: 12),
                                _buildDetailRow(
                                  Icons.home,
                                  'Address',
                                  _address,
                                ),
                                const SizedBox(height: 12),
                                _buildDetailRow(
                                  Icons.calendar_today,
                                  'Date',
                                  _date,
                                ),
                                const SizedBox(height: 12),
                                _buildDetailRow(
                                  Icons.access_time,
                                  'Time',
                                  _time,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              final reportData = LocationReportData(
                                latitude: _latitude!,
                                longitude: _longitude!,
                                address: _address,
                                formattedDate: _date,
                                formattedTime: _time,
                              );
                              Navigator.pop(context, reportData);
                            },
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Submit Location Data'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}