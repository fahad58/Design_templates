import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address to Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _addressController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng? _location;
  String? _errorMessage;
  bool _isSearching = false;

  Future<void> _searchAddress() async {
    setState(() {
      _location = null;
      _errorMessage = null;
      _isSearching = true;
    });

    try {
      if (_addressController.text.isEmpty) {
        throw Exception('Please enter an address');
      }

      final locations = await locationFromAddress(_addressController.text);
      if (locations.isEmpty) {
        throw Exception('No location found for this address');
      }

      final firstLocation = locations.first;
      setState(() {
        _location = LatLng(firstLocation.latitude, firstLocation.longitude);
        _isSearching = false;
      });

      // Center the map on the new location
      _mapController.move(_location!, 15.0);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address to Map'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Address',
                      border: OutlineInputBorder(),
                      hintText: 'e.g. 1600 Amphitheatre Parkway, Mountain View',
                    ),
                    onSubmitted: (_) => _searchAddress(),
                  ),
                ),
                IconButton(
                  icon: _isSearching
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.search),
                  onPressed: _isSearching ? null : _searchAddress,
                ),
              ],
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _location ?? const LatLng(0, 0),
                zoom: _location != null ? 15.0 : 1.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.address_to_map',
                ),
                if (_location != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _location!,
                        builder: (ctx) => const Icon(
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
        ],
      ),
    );
  }
}
....................
  dependencies:
  flutter:
    sdk: flutter
  flutter_map: ^4.0.0
  latlong2: ^0.9.0
  geocoding: ^2.1.0
