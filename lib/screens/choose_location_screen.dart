import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../constract/color_string.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => GgoogleMapScreenState();
}

class GgoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  Future<CameraPosition> _initializeMap() async {
    var _currentLocation = await _determinePosition();
    markedLocation =
        LatLng(_currentLocation.latitude, _currentLocation.longitude);
    return CameraPosition(
      target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
      zoom: 24,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  late var markedLocation = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Location'),
        backgroundColor: AOUAppBar,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _initializeMap(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: snapshot.data!,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      _controller.complete(controller);
                    },
                    onTap: (argument) {
                      if (_markers.length >= 1) {
                        _markers.clear();
                      }

                      _onAddMarkerButtonPressed(argument);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: AOUbackground,
                      ),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _markers.isEmpty
                              ? null
                              : () async {
                                  await FirebaseFirestore.instance
                                      .collection('customers')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set({
                                    'location': {
                                      'latitude': markedLocation.latitude,
                                      'longitude': markedLocation.longitude
                                    }
                                  }, SetOptions(merge: true));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TypeOrder(name: '', phoneNumber: ''),
                                    ),
                                  );
                                },
                          child: Text('Save Location'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AOUAppBar,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
          },
        ),
      ),
    );
  }

  final Set<Marker> _markers = {};

  void _onAddMarkerButtonPressed(LatLng latlang) {
    markedLocation = latlang;
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(latlang.toString()),
        position: latlang,
        infoWindow: InfoWindow(
            // title: address,
            //  snippet: '5 Star Rating',
            ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
