import 'package:flutter/material.dart';

class HC1Card extends StatelessWidget {
  final String? title;
  final double height;


  HC1Card({
    required this.title,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      height: height,

    );
  }
}
// The  HC1Card  class is a stateless widget that represents a card with a title and description. It takes two required parameters:  title  and  description . The  build  method returns a  Card  widget with a  ListTile  child that displays the title and description.