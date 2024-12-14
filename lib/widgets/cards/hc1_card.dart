import 'package:flutter/material.dart';

import '../../api/models/card_model.dart';

class HC1CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC1CardBuilder({
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isScrollable) {
      return buildIfScrollable();
    } else {
      return buildIfNotScrollable();
    }
  }

  Widget buildIfScrollable() {
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cardDetails
              .map((card) => card != null ? HC1Card(
            cardDetails: card,
          ): const SizedBox.shrink())
              .toList(),
        ),
      ),
    );

  }

  Widget buildIfNotScrollable() {
    return Row(
      children: cardDetails
          .map((card) => card != null ? Expanded(
            child: HC1Card(
                    cardDetails: card,
                  ),
          ): const SizedBox.shrink())
          .toList(),
    );
  }
}
// The  HC1Card  class is a stateless widget that represents a card with a title and description. It takes two required parameters:  title  and  description . The  build  method returns a  Card  widget with a  ListTile  child that displays the title and description.

class HC1Card extends StatelessWidget {
  final CardModel cardDetails;

  const HC1Card({required this.cardDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: cardDetails.getBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: RichText(text: cardDetails.formattedTitle!.generateSpans(),),
        subtitle: RichText(text: cardDetails.formattedTitle!.generateSpans()),
      ),
    );
  }
}