import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thought/widgets/colors.dart';

import '../models/appmodel.dart';
import '../widgets/alltext.dart';
import '../widgets/containers.dart';

class ThoughtViewPage extends StatelessWidget {
  Thoughts thought;
  Legend owner;
  String head;
  bool changeicon;
  ThoughtViewPage(this.thought, this.owner, this.head,
      {this.changeicon = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours().backcolour,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      iconk: Icons.share,
                      onPressedk: () {
                        Share.share(
                            "${thought.name} \n \nEpic thought by : ${owner.name}");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 220,
                    child:
                        InfoContainer(thought, owner, changeicon: changeicon)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerButton(iconk: Icons.refresh),
                    ContainerButton(
                      iconk: Icons.copy,
                      onPressedk: () {
                        Clipboard.setData(ClipboardData(text: thought.name));
                        Get.snackbar(
                          'Dear User',
                          'Text copied',
                          colorText: Colors.white,
                          backgroundColor: Colours().supportcolour,
                          duration: Duration(seconds: 1),
                        );
                      },
                    ),
                    ContainerButton(
                      iconk: Icons.share,
                      onPressedk: () {
                        Share.share(
                            "${thought.name} \n \nEpic thought by : ${owner.name}");
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
