import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thought/controllers/maincontroller.dart';
import 'package:thought/models/appmodel.dart';
import 'package:thought/screens/savespage.dart';
import 'package:thought/screens/searchscreen.dart';
import 'package:thought/widgets/alltext.dart';
import 'package:thought/widgets/colors.dart';

import '../widgets/containers.dart';
import 'thoughtlistpage.dart';

class HomePage extends StatelessWidget {
  DBHelper controller = Get.put(DBHelper());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var option = controller.category;
    return Scaffold(
      backgroundColor: Colours().backcolour,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(
                      iconk: Icons.menu_open_outlined,
                      onPressedk: () async {
                        var saves = await controller.getSaves();
                        Get.to(() => SavesPage());
                      }),
                  TopicText(data: "Home"),
                  ContainerButton(
                    iconk: Icons.search,
                    onPressedk: () async {
                      var allthought = await controller.getallThouhgts();
                      Get.to(() => SearchPage(allthought));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumText(
                        data: "Top Legends",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: topclass.length,
                          itemBuilder: (BuildContext context, int index) {
                            int num = index + 1;
                            return CardContainer(num, topclass[index]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MediumText(data: 'Category'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: option.length,
                            itemBuilder: (BuildContext context, int index) {
                              int num = index + 1;
                              return InkWell(
                                  onTap: () async {
                                    List<Thoughts> thoughts = await controller
                                        .getThouhgts(option[index].option);
                                    Get.to(() => ThoughtListPage(
                                        thoughts, option[index].name));
                                  },
                                  child: HomeListTile(option[index], num));
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
