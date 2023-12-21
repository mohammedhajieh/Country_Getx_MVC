import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/city_controller.dart';
import 'package:flutter_application_1/model/city_class.dart';
import 'package:get/get.dart';

class CityHome extends StatelessWidget {
  CityHome({Key? key, required this.q}) : super(key: key);
  final String q;
  final CityCon controller = Get.put(CityCon());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geonames City'),
      ),
      body: GetBuilder<CityCon>(
        init: CityCon(),
        builder: (controller) => FutureBuilder(
          future: controller.cityData(q),
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
                        hintText: 'Enter city name',
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
                      List<CityClass> cityList = controller.myList1.value;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cityList.length,
                        itemBuilder: (context, index) {
                          final city = cityList[index];
                          return InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: Text(city.name),
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
