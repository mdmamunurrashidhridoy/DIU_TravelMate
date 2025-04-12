import 'package:flutter/material.dart';
//import 'package:tarvel_mate/map/impmap.dart';
import 'package:tarvel_mate/map/maplocation.dart';
import 'package:tarvel_mate/pages/design_tm.dart';

class MapLoca extends StatefulWidget {
  const MapLoca({super.key});

  @override
  State<MapLoca> createState() => _MapLocaState();
}

class _MapLocaState extends State<MapLoca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppbarTop(),
      // drawer: DrawerD(),

      body: LiveTrackingPage(),

    );
  }
}
