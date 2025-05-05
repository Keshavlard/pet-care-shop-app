import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class VetHospitalScreen extends StatefulWidget {
  const VetHospitalScreen({super.key});

  @override
  State<VetHospitalScreen> createState() => _VetHospitalScreenState();
}

class _VetHospitalScreenState extends State<VetHospitalScreen> {
  List<dynamic> hospitals = [];
  bool isLoading = true;

  int apiHitCount = 0;
  final int maxApiHits = 50;

  final String apiKey = ''; // paste the api here provided in the link

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(url);
      } catch (e) {
        print("Call launch error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not initiate call.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or dialer not supported.')),
      );
    }
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;

    if (!status.isGranted) {
      status = await Permission.location.request();

      if (status.isGranted) {
        _fetchNearbyVetHospitals();
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is required.')),
        );
      }
    } else {
      _fetchNearbyVetHospitals();
    }
  }

  Future<void> _fetchNearbyVetHospitals() async {
    try {
      if (apiHitCount >= maxApiHits) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Daily API limit reached.')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final lat = position.latitude;
      final lon = position.longitude;

      final placesUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            'location=$lat,$lon&radius=10000&type=veterinary_care&key=$apiKey',
      );

      final response = await http.get(placesUrl);
      if (response.statusCode == 200) {
        apiHitCount++;
        final data = json.decode(response.body);
        final results = data['results'];

        List<dynamic> hospitalsWithPhones = [];

        for (var result in results) {
          final placeId = result['place_id'];
          final phone = await _fetchPhoneNumber(placeId);
          result['phone'] = phone;
          hospitalsWithPhones.add(result);
        }

        setState(() {
          hospitals = hospitalsWithPhones;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch from Google Places API');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> _fetchPhoneNumber(String placeId) async {
    final detailsUrl = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?'
          'place_id=$placeId&fields=name,formatted_phone_number&key=$apiKey',
    );

    try {
      final response = await http.get(detailsUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['result']['formatted_phone_number'];
      } else {
        print("Failed to fetch place details for $placeId");
        return null;
      }
    } catch (e) {
      print("Error fetching phone number: $e");
      return null;
    }
  }

  void _openInGoogleMaps(double lat, double lon) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
    );

    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        print("Error launching URL: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch Google Maps.')),
        );
      }
    } else {
      print("Cannot launch the URL");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid URL, cannot open Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Vet Hospitals"),
        backgroundColor: Colors.redAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hospitals.isEmpty
          ? const Center(child: Text("No vet hospitals found nearby."))
          : ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          final name = hospital['name'] ?? 'Unnamed Vet Hospital';
          final lat = hospital['geometry']['location']['lat'];
          final lon = hospital['geometry']['location']['lng'];
          final phone = hospital['phone'];


          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_hospital, color: Colors.redAccent, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.location_on_outlined, color: Colors.redAccent),
                        label: const Text(
                          "View Map",
                          style: TextStyle(
                            color: Colors.red, // High contrast
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () => _openInGoogleMaps(lat, lon),
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.call_outlined, color: Colors.green),
                        label: const Text(
                          "Call",
                          style: TextStyle(
                            color: Colors.green, // High contrast
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: phone != null
                            ? () => _makePhoneCall(phone)
                            : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Phone number not available')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
