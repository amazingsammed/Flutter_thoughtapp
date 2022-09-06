import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thought/models/appmodel.dart';
import 'package:thought/screens/thoughtviewpage.dart';

import '../controllers/maincontroller.dart';
import '../widgets/alltext.dart';
import '../widgets/colors.dart';
import '../widgets/containers.dart';

class SavesPage extends StatelessWidget {
  Colours colour = Colours();
  DBHelper controller = Get.find();

  SavesPage();

  @override
  Widget build(BuildContext context) {
    List<Thoughts> saves = controller.saves;
    return Scaffold(
      backgroundColor: colour.backcolour,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(
                    iconk: Icons.arrow_back_ios_new_sharp,
                    onPressedk: () => Get.back(),
                  ),
                  TopicText(data: "Saves"),
                  Container(
                    width: 50,
                  )
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var num = index + 1;
                            return InkWell(
                                onTap: () async {
                                  Legend legend = await controller
                                      .getLegends(saves[index].owner);
                                  Get.to(() => ThoughtViewPage(
                                      saves[index], legend, 'Save'));
                                },
                                child: ContainerCatTile(saves[index], num));
                          },
                          separatorBuilder: (context, inedx) => Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 3),
                              child: Divider(
                                color: Colors.white,
                              )),
                          itemCount: saves.length);
                    })
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
