import 'package:flutter/cupertino.dart';
import 'package:thought/widgets/colors.dart';

class TopicText extends StatelessWidget {
  String data;
  TopicText({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colours().secondmaincolour),
    );
  }
}

class MediumText extends StatelessWidget {
  String data;
  MediumText({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: FontWeight.w700, color: Colours().secondmaincolour),
    );
  }
}

class NormalText extends StatelessWidget {
  String data;
  NormalText({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: FontWeight.normal, color: Colours().secondmaincolour),
    );
  }
}
