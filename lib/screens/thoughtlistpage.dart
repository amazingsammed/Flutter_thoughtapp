import 'package:flutter/material.dart';
import 'package:thought/models/appmodel.dart';
import 'package:get/get.dart';
import 'package:thought/screens/thoughtviewpage.dart';
import '../controllers/maincontroller.dart';
import '../widgets/alltext.dart';
import '../widgets/colors.dart';
import '../widgets/containers.dart';

class ThoughtListPage extends StatelessWidget {
  DBHelper controller = Get.put(DBHelper());
  List<Thoughts> thoughts;
  String head;
  //Owners owner;
  ThoughtListPage(this.thoughts, this.head, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours().backcolour,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(
                    iconk: Icons.arrow_back_ios_new_sharp,
                    onPressedk: () {
                      Get.back();
                    },
                  ),
                  TopicText(data: head),
                  ContainerButton(
                    iconk: Icons.notifications_none,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: thoughts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var num = index + 1;
                    return InkWell(
                        onTap: () async {
                          bool changeicon =
                              await controller.checkicon(thoughts[index]);
                          Legend legend = await controller
                              .getLegends(thoughts[index].owner);
                          Get.to(() => ThoughtViewPage(
                              thoughts[index], legend, head,
                              changeicon: changeicon));
                        },
                        child: ContainerCatTile(thoughts[index], num));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3),
                          child: Divider(
                            color: Colors.white,
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
