import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart';


class PointPopup extends StatefulWidget {
  final SkroutzPoint point;

  const PointPopup(this.point, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PointPopupState();
}

class _PointPopupState extends State<PointPopup> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon( Icons.account_balance_wallet,
                color: Colors.orange,
                size: 30,),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Text(
              widget.point.isCleveron == true ?"Cleveron": "Swipbox",
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
             Text(
               widget.point.name ??"",
              style: TextStyle( fontWeight: FontWeight.bold),
            ),
              Text( "${widget.point.streetName??""} ${widget.point.streetNumber??""} ${widget.point.city??""} ${widget.point.zip??""} ${widget.point.region??""}"),
              Text( "Weekday ${widget.point.weekdayWorkingHours??""}"),
              Text( "Weekend ${widget.point.weekendWorkingHours??""}"),

          ],
        ),
      ),
    );
  }
}