import 'package:flutter/material.dart';

import '../../api/models/card_model.dart';

class HC5Card extends StatelessWidget {
  final CardModel cardDetails;
  final bool isScrollable;
  final bool isFullWidth;

  HC5Card({
    required this.cardDetails,
    this.isScrollable = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8,),
        child: AspectRatio(
          aspectRatio: cardDetails.backgroundImage?.aspectRatio?.toDouble() ?? 16/9,
          child: Container(
            decoration: BoxDecoration(
              color: cardDetails.getBackgroundColor,
              image: DecorationImage(image: cardDetails.backgroundImage!.getImage() as ImageProvider<Object>, fit: BoxFit.cover),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                child: Column(
                  crossAxisAlignment: cardDetails.formattedTitle?.getCrossAxisAlignment ?? CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(text: cardDetails.formattedTitle!.generateSpans()),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
// The  HC5Card  class is a stateless widget that represents a card with an image. It has one property:  imageUrl , which is the URL of the image to be displayed on the card. The card displays the image in a  Card  widget with the  Image.network  widget as its child. The  fit: BoxFit.cover  parameter ensures that the image covers the entire card.
