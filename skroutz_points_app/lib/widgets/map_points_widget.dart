import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by 'flutter_map.dart'
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart';
import 'package:skroutz_points_app/widgets/marker_popup.dart';
import 'package:skroutz_points_app/widgets/zoom_buttons_plugin_option.dart'; // Recommended for most use-cases


typedef ZoomPointValue =  Function(SkroutzPoint);

typedef void ZoomToPoint(SkroutzPoint point);
class ZoomToPointController {
  late void Function(SkroutzPoint point) zoom;
}
class MapPointsWidget extends StatefulWidget {
  MapPointsWidget(this.data,this.zoomToPointController, {Key? key}) : super(key: key);
  final List<SkroutzPoint> data;
  final ZoomToPointController? zoomToPointController;


  @override
  State<MapPointsWidget> createState() => _MapPointsWidgetState();
}

class _MapPointsWidgetState extends State<MapPointsWidget>  with TickerProviderStateMixin {

  late final MapController mapController;
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();
  // List<Marker> allMarkers = [];

  @override
  initState() {
    super.initState();
    mapController = MapController();
    widget.zoomToPointController?.zoom = zoomToPoint;
  }

  List<Marker> getMarkers() {
    List<Marker> tempmarkers = [];
    widget.data.asMap().forEach((key, e) {
      tempmarkers.add(Marker(
        point: LatLng(
            e.location![1],
            e.location![0]
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (context) => GestureDetector(
          onTap: (){
            _animatedMapMove(key);
          },
          child: const Icon(
            Icons.account_balance_wallet,
            color: Colors.orange,
            size: 30,
          ),
        ),
      ));
    });

    return tempmarkers;
  }


  @override
  Widget build(BuildContext context) {
    print("allMarkers().length ${getMarkers().length}");
    if (widget.data.length == 0){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        plugins: [
          ZoomButtonsPlugin(),
        ],
        onTap: (_, __) => _popupLayerController
            .hideAllPopups(), // H
        bounds: widget.data.getMaxLat(),
      ),

      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),

      ],

      nonRotatedLayers: [
        ZoomButtonsPluginOption(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomRight,
        ),
      ],
      // layers: [
      //
      //   TileLayerOptions(
      //     urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      //     userAgentPackageName: 'com.nickagas.skroutzpoints',
      //   ),
      //   MarkerLayerOptions(
      //       markers: getMarkers()),
      //
      // ],
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.nickagas.skroutzpoints',
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            // onPopupEvent: onPopupEvent,
            popupController: _popupLayerController,
            markers: getMarkers(),
            markerRotateAlignment:
            PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker) => getPointPopup(marker)),

        )
      ],
    );
  }

  Widget getPointPopup(Marker marker){
    // getMarkers().firstWhere((element) => element == marker);
    Widget toReturn = Container();
    widget.data.forEach((element) {
      print(element.location);
      if (element.location![0] == marker.point.longitude && element.location![1] ==  marker.point.latitude){
        toReturn = PointPopup(element);
        print("found equal");
      }
    });

   return toReturn;

  }


  void zoomToPoint(SkroutzPoint point){
    print("MapPointsWidget $point" );
    widget.data.asMap().forEach((key, element) {
      if (element.location![0] == point.location![0] && element.location![1] ==  point.location![1] ){
        _animatedMapMove(key);
      }
    });
  }
  void _animatedMapMove(int position) {

    _popupLayerController.showPopupsOnlyFor([getMarkers()[position]]);
    mapController.move(
        getMarkers()[position].point,
        17);

  }

}

