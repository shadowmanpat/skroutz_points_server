import 'package:flutter/material.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart';

class ExpandableListWidget extends StatelessWidget {

  const ExpandableListWidget(this.data ,{Key? key}) : super(key: key);
  final List<SkroutzPoint> data;
  @override
  Widget build(BuildContext context) {

    if (data.isEmpty){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return  Column(
      children: [
        Text("All: ${data.length}, Cleveron: ${data.cleveronCount} Swipbox: ${data.swipboxCount}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
        Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildList(data[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildList(SkroutzPoint point) {
    return ExpansionTile(
      // leading: Icon(list.icon),
      leading: Text(point.isCleveron == true ?"Cleveron": "Swipbpx"),
      title: Text(
        point.name ??"",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
        children: [
          Text( "${point.streetName??""} ${point.streetNumber??""} ${point.city??""} ${point.zip??""} ${point.region??""}"),
          Text( "Weekday ${point.weekdayWorkingHours??""}"),
          Text( "Weekend ${point.weekendWorkingHours??""}"),
          Text( "${point.active == true? "Active" : "Inactive"}"),
        ]
    );
  }
}
