import 'dart:convert';

class Country {
  String continent;
  String capital;
  String languages;
  int geonameId;
  double south;
  String isoAlpha3;
  double north;
  String fipsCode;
  String population;
  double east;
  String isoNumeric;
  String areaInSqKm;
  String countryCode;
  double west;
  String countryName;
  String postalCodeFormat;
  String continentName;
  String currencyCode;
  String flagUrl; // Add this line for the flag URL

  Country({
    required this.continent,
    required this.capital,
    required this.languages,
    required this.geonameId,
    required this.south,
    required this.isoAlpha3,
    required this.north,
    required this.fipsCode,
    required this.population,
    required this.east,
    required this.isoNumeric,
    required this.areaInSqKm,
    required this.countryCode,
    required this.west,
    required this.countryName,
    required this.postalCodeFormat,
    required this.continentName,
    required this.currencyCode,
    required this.flagUrl, // Add this line for the flag URL
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        continent: json["continent"],
        capital: json["capital"],
        languages: json["languages"],
        geonameId: json["geonameId"],
        south: json["south"]?.toDouble(),
        isoAlpha3: json["isoAlpha3"],
        north: json["north"]?.toDouble(),
        fipsCode: json["fipsCode"],
        population: json["population"],
        east: json["east"]?.toDouble(),
        isoNumeric: json["isoNumeric"],
        areaInSqKm: json["areaInSqKm"],
        countryCode: json["countryCode"],
        west: json["west"]?.toDouble(),
        countryName: json["countryName"],
        postalCodeFormat: json["postalCodeFormat"],
        continentName: json["continentName"],
        currencyCode: json["currencyCode"],
        flagUrl:
            "", // Initialize with an empty string, or provide a default value
      );

  Map<String, dynamic> toJson() => {
        "continent": continent,
        "capital": capital,
        "languages": languages,
        "geonameId": geonameId,
        "south": south,
        "isoAlpha3": isoAlpha3,
        "north": north,
        "fipsCode": fipsCode,
        "population": population,
        "east": east,
        "isoNumeric": isoNumeric,
        "areaInSqKm": areaInSqKm,
        "countryCode": countryCode,
        "west": west,
        "countryName": countryName,
        "postalCodeFormat": postalCodeFormat,
        "continentName": continentName,
        "currencyCode": currencyCode,
        "flagUrl": flagUrl, // Include the flag URL in the JSON output
      };
}
