import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/country_controller.dart';
import 'package:flutter_application_1/model/country_class.dart';
import 'package:flutter_application_1/view/state_home.dart';
import 'package:get/get.dart';

class CountryHome extends StatelessWidget {
  CountryHome({Key? key}) : super(key: key);
  final CountryCon controller = Get.put(CountryCon());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geonames Country'),
      ),
      body: GetBuilder<CountryCon>(
        init: CountryCon(),
        builder: (controller) => FutureBuilder(
          future: controller.countryData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (_) {
                        controller.filterCity();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Enter country name',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      List<Country> countryList = controller.myList1.value;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: countryList.length,
                        itemBuilder: (context, index) {
                          final country = countryList[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => StateHome(
                                    id: country.geonameId,
                                  ));
                            },
                            child: ListTile(
                              title: Text(country.countryName),
                              leading: Image.network(
                                country.flagUrl,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
