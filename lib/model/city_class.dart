class CityClass {
  String adminCode1;
  String lng;
  int geonameId;
  String toponymName;
  String countryId;
  String fcl;
  int population;
  String countryCode;
  String name;
  String fclName;
  String countryName;
  String fcodeName;
  String adminName1;
  String lat;
  String fcode;

  CityClass({
    required this.adminCode1,
    required this.lng,
    required this.geonameId,
    required this.toponymName,
    required this.countryId,
    required this.fcl,
    required this.population,
    required this.countryCode,
    required this.name,
    required this.fclName,
    required this.countryName,
    required this.fcodeName,
    required this.adminName1,
    required this.lat,
    required this.fcode,
  });

  factory CityClass.fromJson(Map<String, dynamic> json) {
    return CityClass(
      adminCode1: json['adminCode1'],
      lng: json['lng'],
      geonameId: json['geonameId'],
      toponymName: json['toponymName'],
      countryId: json['countryId'],
      fcl: json['fcl'],
      population: json['population'],
      countryCode: json['countryCode'],
      name: json['name'],
      fclName: json['fclName'],
      countryName: json['countryName'],
      fcodeName: json['fcodeName'],
      adminName1: json['adminName1'],
      lat: json['lat'],
      fcode: json['fcode'],
    );
  }
}
