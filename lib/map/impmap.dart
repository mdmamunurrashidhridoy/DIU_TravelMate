import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FMap extends StatefulWidget {
  const FMap({super.key});

  @override
  State<FMap> createState() => _FMapState();
}

class _FMapState extends State<FMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(1.2878, 103.8661),
        initialZoom: 13.0,
        interactionOptions: InteractionOptions(
          flags: ~InteractiveFlag.doubleTapDragZoom,
        ),
      ),
      children: [
        openStreetMapTileLayer,
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
