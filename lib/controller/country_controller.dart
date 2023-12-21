import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/model/country_class.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CountryCon extends GetxController {
  List<Country> myList = [];
  Rx<List<Country>> myList1 = Rx<List<Country>>([]);
  final TextEditingController searchController = TextEditingController();

  Future<List<Country>> countryData() async {
    // Fetch country info from the first API
    var response = await http.get(Uri.parse(
        'https://www.geonames.org/countryInfoJSON?lang=ar&username=mohammedhajjeeh'));

    // Fetch flag data from the second API
    var response1 = await http
        .get(Uri.parse('https://restcountries.com/v3.1/all?fields=flags,cca2'));

    if (response.statusCode == 200 && response1.statusCode == 200) {
      myList.clear();

      var data2 = jsonDecode(response.body);
      var flagData = jsonDecode(response1.body);

      if (data2.containsKey('geonames') && data2['geonames'] is List) {
        var newsList = data2['geonames'];

        for (var v in newsList) {
          if (v != null) {
            var u = Country.fromJson(v);

            // Find the flag data for the current country
            var flagInfo = flagData.firstWhere(
              (flag) => flag['cca2'] == u.countryCode,
              orElse: () => null,
            );

            if (flagInfo != null && flagInfo.containsKey('flags')) {
              u.flagUrl = flagInfo['flags']['png'];
              myList.add(u); // Only add to the list if the flag is found
            }
          }
        }

        // Sort the list alphabetically by the country name
        myList.sort((a, b) => a.countryName.compareTo(b.countryName));
        myList1.value = List<Country>.from(myList);
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
    List<Country> results = [];
    String searchQuery = searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      results = List<Country>.from(myList);
    } else {
      results = myList
          .where((element) =>
              element.countryName.toLowerCase().contains(searchQuery))
          .toList();
    }

    myList1.value = results;
  }
}
