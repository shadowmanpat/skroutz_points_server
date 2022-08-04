import 'package:flutter/material.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart';
import 'package:skroutz_points_app/services/api.dart';
import 'package:skroutz_points_app/widgets/expandable_list.dart';
import 'package:skroutz_points_app/widgets/map_points_widget.dart';
import 'package:split_view/split_view.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {

  List<SkroutzPoint> data = [];

  @override
  initState() {
    super.initState();
    getPoints();
  }

  void getPoints() async{
    var results = await fetchPoints(lat: 38.04591429362779,lng:23.505545947811747, radius: 100000000.0  );
    setState(() {
      data = results.skroutzPoints?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Skroutz points locator"),
      ),
      body: SafeArea(
        child: SplitView(
          viewMode: SplitViewMode.Horizontal,
          indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
          activeIndicator: SplitIndicator(
            viewMode: SplitViewMode.Horizontal,
            isActive: true,
          ),
          children: [
            ExpandableListWidget(data),
            MapPointsWidget(),

          ],
          controller: SplitViewController(weights: [0.3, 0.7],limits: [WeightLimit(min:0.3,max: 0.6)]),
        ),
      ),
    );
  }
}
