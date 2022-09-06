import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/maincontroller.dart';
import '../models/appmodel.dart';
import '../widgets/colors.dart';
import '../widgets/containers.dart';
import 'thoughtviewpage.dart';

class SearchPage extends StatelessWidget {
  TextEditingController data = TextEditingController();
  var result = 0.obs;
  DBHelper controller = Get.put(DBHelper());
  List<Thoughts> allthought;

  SearchPage(this.allthought);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours().backcolour,
      body: SafeArea(
        child: Obx(() {
          var search = controller.searchlist;
          search.isNotEmpty
              ? result.value = search.length
              : result.value = allthought.length;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerButton(
                      iconk: Icons.arrow_back_ios_new_sharp,
                      onPressedk: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFF1f1f1f),
                            borderRadius: BorderRadius.circular(13)),
                        width: 20,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Thought",
                              hintStyle: TextStyle(color: Colors.white70),
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              iconColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                          controller: data,
                          onChanged: (value) => controller.Searchtile(value),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ContainerText(
                        data: result.value.toString(),
                        height: 40,
                        width: 40,
                        colour: false)
                  ],
                ),
                Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (search.isNotEmpty) {
                            var num = index + 1;
                            return InkWell(
                                onTap: () async {
                                  Legend legend = await controller
                                      .getLegends(search[index].owner);
                                  Get.to(() => ThoughtViewPage(
                                      search[index], legend, 'Search'));
                                },
                                child: ContainerCatTile(search[index], num));
                          } else {
                            var num = index + 1;
                            return InkWell(
                                onTap: () async {
                                  Legend legend = await controller
                                      .getLegends(allthought[index].owner);
                                  Get.to(() => ThoughtViewPage(
                                      allthought[index], legend, 'Search'));
                                },
                                child:
                                    ContainerCatTile(allthought[index], num));
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 3),
                              child: Divider(
                                color: Colors.white,
                              ));
                        },
                        itemCount: result.value))
              ],
            ),
          );
        }),
      ),
    );
  }
}
