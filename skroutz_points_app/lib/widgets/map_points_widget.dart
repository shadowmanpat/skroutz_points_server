import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by 'flutter_map.dart'
import 'package:latlong2/latlong.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart'; // Recommended for most use-cases

class MapPointsWidget extends StatefulWidget {
  const MapPointsWidget(this.data, {Key? key}) : super(key: key);
  final List<SkroutzPoint> data;

  @override
  State<MapPointsWidget> createState() => _MapPointsWidgetState();
}

class _MapPointsWidgetState extends State<MapPointsWidget> {
  List<Marker>  allMarkers() {

    List<Marker> allMarkers = [];
    allMarkers = widget.data.map((e) => Marker(
      point: LatLng(
        e.location![1],
        e.location![0]
      ),
      builder: (context) => const Icon(
        Icons.account_balance_wallet,
        color: Colors.orange,
        size: 20,
      ),
    )).toList();
    return allMarkers;

  }

  @override
  Widget build(BuildContext context) {
    print("allMarkers().length ${allMarkers().length}");
    if (widget.data.length == 0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return FlutterMap(
      options: MapOptions(
        bounds: widget.data.getMaxLat(),
        // center: LatLng(51.509364, -0.128928),
        // zoom: 9.2,
      ),
      layers: [

        TileLayerOptions(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.nickagas.skroutzpoints',
        ),
        MarkerLayerOptions(
            markers: allMarkers()),

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
