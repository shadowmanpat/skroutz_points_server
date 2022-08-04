import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:skroutz_points_app/models/skroutz_points_reponse.dart';


//http://localhost:6060/api/fetch_skroutz_points?coordinates%5Blat%5D=38.04591429362779&coordinates%5Blng%5D=23.505545947811747&radius=9.630465529133021
Future<SkroutzPointsResponse> fetchPoints({required double lat,required double lng,required double radius}) async {
  var baseUrl = "";
  var apiUrl = "";
  var origin = window.location.origin;
  if(kIsWeb){
    var origin = window.location.origin;
//      Uri(url)
    print("origin $origin");
    baseUrl = origin;
    if(origin.contains("localhost") ){
      baseUrl = "http://localhost:6060";
    }

    apiUrl = baseUrl;
  }
  var path = '$apiUrl/api/fetch_skroutz_points?coordinates[lat]=$lat&coordinates[lng]=$lng&radius=$radius';
  print(path);
  var response = await http
      .get(Uri.parse(path));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var result = jsonDecode(response.body);
    print(response.body);
    return SkroutzPointsResponse.fromJson(result);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}