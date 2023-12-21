import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/state_controller.dart';
import 'package:flutter_application_1/model/city_class.dart';
import 'package:flutter_application_1/view/city_home.dart';
import 'package:get/get.dart';

class StateHome extends StatelessWidget {
  StateHome({Key? key, required this.id}) : super(key: key);
  final int id;
  final StateCon controller = Get.put(StateCon());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geonames State'),
      ),
      body: GetBuilder<StateCon>(
        init: StateCon(),
        builder: (controller) => FutureBuilder(
          future: controller.stateData(id),
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
                        hintText: 'Enter state name',
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
                      List<CityClass> stateList = controller.myList1.value;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: stateList.length,
                        itemBuilder: (context, index) {
                          final state = stateList[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => CityHome(
                                    q: state.toponymName,
                                  ));
                            },
                            child: ListTile(
                              title: Text(state.name),
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
