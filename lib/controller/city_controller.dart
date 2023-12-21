import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/city_class.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CityCon extends GetxController {
  List<CityClass> myList = [];
  Rx<List<CityClass>> myList1 = Rx<List<CityClass>>([]);
  final TextEditingController searchController = TextEditingController();

  Future<List<CityClass>> cityData(String q) async {
    var response = await http.get(Uri.parse(
        'http://api.geonames.org/searchJSON?q=$q&username=mohammedhajjeeh&lang=ar'));

    if (response.statusCode == 200) {
      myList.clear();
      var data2 = jsonDecode(response.body);
      if (data2.containsKey('geonames') && data2['geonames'] is List) {
        var newsList = data2['geonames'];
        for (var v in newsList) {
          if (v != null) {
            var u = CityClass.fromJson(v);
            myList.add(u);
          }
        }
        myList.sort((a, b) => a.name.compareTo(b.name));
        myList1.value = List<CityClass>.from(myList);
      }
    } else {
      throw Exception('Failed to load data');
    }

    return myList;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void filterCity() {
    List<CityClass> results = [];
    String searchQuery = searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      results = List<CityClass>.from(myList);
    } else {
      results = myList
          .where((element) => element.name.toLowerCase().contains(searchQuery))
          .toList();
    }

    myList1.value = results;
  }
}
