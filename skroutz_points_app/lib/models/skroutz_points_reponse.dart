class SkroutzPointsResponse {
  List<SkroutzPoint>? skroutzPoints;

  SkroutzPointsResponse({this.skroutzPoints});

  SkroutzPointsResponse.fromJson(Map<String, dynamic> json) {
    if (json['skroutz_points'] != null) {
      skroutzPoints = <SkroutzPoint>[];
      json['skroutz_points'].forEach((v) {
        skroutzPoints!.add(new SkroutzPoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.skroutzPoints != null) {
      data['skroutz_points'] =
          this.skroutzPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkroutzPoint {
  String? id;
  String? type;
  String? name;
  String? streetName;
  String? streetNumber;
  String? city;
  String? zip;
  String? region;
  String? weekdayWorkingHours;
  String? weekendWorkingHours;
  bool? indoor;
  List<double>? location;
  bool? active;
  String? model;

  SkroutzPoint(
      {this.id,
        this.type,
        this.name,
        this.streetName,
        this.streetNumber,
        this.city,
        this.zip,
        this.region,
        this.weekdayWorkingHours,
        this.weekendWorkingHours,
        this.indoor,
        this.location,
        this.active,
        this.model});

  SkroutzPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    streetName = json['street_name'];
    streetNumber = json['street_number'];
    city = json['city'];
    zip = json['zip'];
    region = json['region'];
    weekdayWorkingHours = json['weekday_working_hours'];
    weekendWorkingHours = json['weekend_working_hours'];
    indoor = json['indoor'];
    location = json['location'].cast<double>();
    active = json['active'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['street_name'] = this.streetName;
    data['street_number'] = this.streetNumber;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['region'] = this.region;
    data['weekday_working_hours'] = this.weekdayWorkingHours;
    data['weekend_working_hours'] = this.weekendWorkingHours;
    data['indoor'] = this.indoor;
    data['location'] = this.location;
    data['active'] = this.active;
    data['model'] = this.model;
    return data;
  }
}
