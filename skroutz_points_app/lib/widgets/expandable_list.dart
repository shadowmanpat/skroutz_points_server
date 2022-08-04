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
        Text("Count: ${data.length}",
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

  Widget _drawer (List<SkroutzPoint> data){
    return Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserAccountsDrawerHeader(margin: EdgeInsets.only(bottom: 0.0),
                    accountName: Text('demo'), accountEmail: Text('demo@webkul.com')),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder:(context, index){return _buildList(data[index]);},)
              ],
            ),
          ),
        ));
  }
  Widget _buildList(SkroutzPoint point) {
    return ExpansionTile(
      // leading: Icon(list.icon),
      leading: Text(point.model??""),
      title: Text(
        point.name ??"",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
        children: [
          Text(point.streetName??""),
        ]
    );
  }
}
