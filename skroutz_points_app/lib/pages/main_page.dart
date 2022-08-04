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
  ZoomToPointController zoomToPointController = ZoomToPointController();
  List<SkroutzPoint> data = [];

  bool isCleveronSwitched = false;
  bool isSwipboxSwitched = false;

  List<SkroutzPoint> getDataFiltered(){
    List<SkroutzPoint> toReturn = [];
    if (isCleveronSwitched){
      toReturn.addAll(data.where((element) => element.isCleveron));
    }
    if (isSwipboxSwitched){
      toReturn.addAll(data.where((element) => element.isSwipbox));
    }
    if(isCleveronSwitched == false && isSwipboxSwitched == false){
      return data;
    }else{
      return toReturn;
    }
  }
  @override
  initState() {
    super.initState();
    getPoints();
  }

  void getPoints() async{
    var results = await fetchPoints(lat: 38.04591429362779,lng:23.505545947811747, radius: 100000000.0  );
    setState(() {
      data = results.skroutzPoints?.where((element) => element.active == true).toList()?? [];
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
          controller: SplitViewController(weights: [0.3, 0.7],limits: [WeightLimit(min:0.3,max: 0.6)]),
          children: [
            ExpandableListWidget(getDataFiltered(),zoomToPoint),
            Stack(
                children:[

                  MapPointsWidget(getDataFiltered(),zoomToPointController),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          color: Colors.white,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Cleveron"),   Switch(
                                value: isCleveronSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isCleveronSwitched = value;
                                    print(isCleveronSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                              Divider(),
                              Text("Swipbox"),
                              Switch(
                                value: isSwipboxSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwipboxSwitched = value;
                                    print(isSwipboxSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      )),
                ] ,
            ),
          ],
        ),
      ),
    );
  }
  zoomToPoint(SkroutzPoint point){
    zoomToPointController.zoom(point);
  }

}
