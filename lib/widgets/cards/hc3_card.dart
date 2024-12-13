import 'package:flutter/material.dart';

import '../../api/models/card_model.dart';

class HC3Card extends StatelessWidget {
  final CardModel cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;

  HC3Card({
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
        child: Column(
          children: [
            ...cardDetails.formattedTitle!.entities!.map((entity) {
              if (entity!.type == 'generic_text') {
                return Text(
                  entity.text!,
                  style: TextStyle(
                    fontSize: entity.getFontSize,
                    fontWeight: entity.getFontWeight,
                    color: entity.getColor,
                    fontStyle:
                        entity.getStyling.runtimeType == FontStyle ? entity.getStyling : null,
                    decoration:
                        entity.getStyling.runtimeType == TextDecoration ? entity.getStyling : null,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            ...?cardDetails.callToAction?.map((cta) {
              return ElevatedButton(

                onPressed: () {},
                child: Text(cta!.text!),
                style: ButtonStyle(

                  shape: cta.isCircular! ? WidgetStateProperty.all<OutlinedBorder>(CircleBorder(
                    side: BorderSide(width: cta.strokeWidth!.toDouble()),
                  )) : WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  )),
                  backgroundColor: WidgetStateProperty.all<Color>(cta.getColor),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
// The  HC3Card  class is a stateless widget that represents a card with an image and a title. It has three properties:  title ,  imageUrl , and  onLongPress . The  title  property is the title of the card, the  imageUrl  property is the URL of the image to be displayed on the card, and the  onLongPress  property is a callback that is called when the card is long-pressed.
