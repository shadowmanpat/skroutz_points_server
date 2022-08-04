import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by 'flutter_map.dart'
import 'package:latlong2/latlong.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart'; // Recommended for most use-cases

class MapPointsWidget extends StatelessWidget {
  const MapPointsWidget(this.data, {Key? key}) : super(key: key);
  final List<SkroutzPoint> data;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        bounds: data.getMaxLat(),
        // center: LatLng(51.509364, -0.128928),
        // zoom: 9.2,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
    );
  }
}
