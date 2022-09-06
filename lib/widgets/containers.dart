import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thought/controllers/maincontroller.dart';
import 'package:thought/models/appmodel.dart';
import 'package:thought/widgets/alltext.dart';
import 'package:thought/widgets/colors.dart';

class ContainerButton extends StatelessWidget {
  var iconk;
  var onPressedk;
  bool colour;
  final bcolour;

  ContainerButton(
      {Key? key,
      required this.iconk,
      this.colour = true,
      this.onPressedk = null,
      this.bcolour = const Color(0xFF1f1f1f)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedk,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: bcolour, borderRadius: BorderRadius.circular(13)),
        child: Icon(
          iconk,
          color: colour ? Colours().secondmaincolour : Colors.white,
        ),
      ),
    );
  }
}

class ContainerText extends StatelessWidget {
  var data;
  var onPressedk;
  double height;
  double width;
  bool colour;
  final bcolour;

  ContainerText(
      {Key? key,
      required this.data,
      this.height = 30.0,
      this.colour = true,
      this.width = 50.0,
      this.onPressedk = null,
      this.bcolour = const Color(0xFF1f1f1f)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: bcolour, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        data,
        style: TextStyle(
            color: colour ? Colours().secondmaincolour : Colors.white),
      )),
    );
  }
}

class CardContainer extends StatelessWidget {
  Colours colours = Colours();
  double width = 200;
  int num;
  TopClass topclass;

  CardContainer(this.num, this.topclass, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colours().supportcolour,
      child: Container(
        margin: EdgeInsets.all(10),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.topRight,
              height: 220,
              width: width * 1.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: [colours.maincolour, colours.secondmaincolour],
                  ),
                  image: DecorationImage(
                      image: AssetImage(topclass.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              // child: Text("#${num}"),
            ),
            SizedBox(
              height: 10,
            ),
            MediumText(data: topclass.name),
            SizedBox(
              height: 5,
            ),
            NormalText(data: topclass.dob),
            SizedBox(
              height: 10,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(data: topclass.job),
                // ContainerButton(
                //   iconk: Icons.add,
                //   bcolour: Colours().maincolour,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeListTile extends StatelessWidget {
  Category option;
  int index;

  HomeListTile(this.option, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        option.name,
        style: TextStyle(
            fontWeight: FontWeight.normal, color: Colours().secondmaincolour),
      ),
      subtitle: Container(
          child: Text(
        option.subtext,
        style: TextStyle(
            fontWeight: FontWeight.normal, color: Colours().secondmaincolour),
      )),
      leading: CircleAvatar(
        backgroundColor: Colours().supportcolour,
        child: Text(
          index.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      trailing: ContainerText(
        data: '${option.count - 3}',
        bcolour: Colours().maincolour,
      ),
    );
  }
}

class ContainerCatTile extends StatelessWidget {
  Thoughts thought;
  int num;

  ContainerCatTile(this.thought, this.num);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        thought.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
            fontWeight: FontWeight.normal, color: Colours().secondmaincolour),
      ),
      // subtitle: Text(
      //   owner.name,
      //   style: TextStyle(
      //       fontWeight: FontWeight.normal, color: Colours().secondmaincolour),
      // ),
      leading: Container(
          height: 35,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
              border: Border.all(color: Colors.red, style: BorderStyle.solid)),
          child: Center(
            child: Text(
              num.toString(),
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}

class InfoContainer extends StatelessWidget {
  Thoughts thought;
  DBHelper controller = Get.find();
  Legend owner;
  bool changeicon;

  InfoContainer(this.thought, this.owner, {this.changeicon = false});

  @override
  Widget build(BuildContext context) {
    RxBool changeicons = changeicon.obs;
    return Container(
      decoration: BoxDecoration(
          color: Colours().supportcolour,
          borderRadius: BorderRadius.circular(20)),
      //alignment: Alignment.topLeft,
      height: 200,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(data: '"${thought.id + 4}"'),
              Obx(() {
                return ContainerButton(
                  onPressedk: () async {
                    var data = await controller.updatelikes(thought);
                    changeicons.value = data;
                  },
                  iconk: changeicons.value
                      ? Icons.bookmark_outline_sharp
                      : Icons.bookmark,
                );
              })
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(child: NormalText(data: thought.name)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: NormalText(data: '--- ${owner.name} ---'),
          ),
        ],
      ),
    );
  }
}
