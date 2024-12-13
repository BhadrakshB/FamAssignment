import 'package:flutter/material.dart';

class HC6Card extends StatelessWidget {
  final String? title;

  HC6Card({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title ?? ''),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
// The  HC6Card  class is a stateless widget that represents a card with a title and a trailing icon. It has one property:  title , which is the title of the card. The card displays the title in a  ListTile  widget with an arrow icon as the trailing widget. The  Icon(Icons.arrow_forward)  widget creates the arrow icon that appears on the right side of the card.