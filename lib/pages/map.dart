import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tarvel_mate/pages/design_tm.dart';

class MapLoca extends StatefulWidget {
  const MapLoca({super.key});

  @override
  State<MapLoca> createState() => _MapLocaState();
}

class _MapLocaState extends State<MapLoca> {
  static const LatLng _pGooglrplex = LatLng(37.4223, -122.0848);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerD(),

      appBar:AppbarTop(),

      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglrplex, zoom: 13),
      ),

    );
  }
}
