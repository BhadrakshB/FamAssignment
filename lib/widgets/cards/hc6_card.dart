import 'package:flutter/material.dart';

import '../../api/models/card_model.dart';

class HC6Card extends StatelessWidget {
  final CardModel cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;

  HC6Card({
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: cardDetails.getBackgroundColor,

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
          child: Row(
            children: [
              if (cardDetails.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: cardDetails.getIcon(isDecorationImage:false) as Widget,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: cardDetails.formattedTitle!.generateSpans()),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
// The  HC6Card  class is a stateless widget that represents a card with a title and a trailing icon. It has one property:  title , which is the title of the card. The card displays the title in a  ListTile  widget with an arrow icon as the trailing widget. The  Icon(Icons.arrow_forward)  widget creates the arrow icon that appears on the right side of the card.