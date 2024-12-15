import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';
import '../../utils/funtions.dart';

class HC5CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double cardSpacing;
  final EdgeInsets cardPadding;
  final EdgeInsets cardMargin;
  final double? height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC5CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
    this.cardSpacing = 8,
    this.cardPadding = const EdgeInsets.symmetric(
      vertical: 8,
    ),
    this.cardMargin = const EdgeInsets.only(
      top: 8,
      bottom: 8,
      left: 10,
    ),
  });

  @override
  Widget build(BuildContext context) {
    if (!isScrollable) {
      return buildIfScrollable(context);
    } else {
      return buildIfNotScrollable();
    }
  }

  Widget buildIfScrollable(BuildContext context) {
    // cardDetails.insert(0, cardDetails.elementAt(0)); // : TO CHECK FOR SCROLLABILITY IF NEEDED
    return Container(
      height: height,
      margin: cardMargin.copyWith(left: 0, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: cardDetails
              .map((card) => card != null
                  ? SizedBox(
                      width: isFullWidth ? MediaQuery.of(context).size.width : null,
                      child: HC5Card(
                        isScrollable: true,
                        height: height,
                        cardDetails: card,
                        padding: cardPadding.copyWith(left: 10, right: 10),
                      ),
                    )
                  : const SizedBox.shrink())
              .toList(),
        ),
      ),
    );
  }

  Widget buildIfNotScrollable() {
    // cardDetails.insert(0, cardDetails.elementAt(0)); : TO CHECK FOR SCROLLABILITY IF NEEDED
    return Container(
      height: height,
      margin: cardMargin.copyWith(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: cardSpacing,
        children: cardDetails
            .map((card) => card != null
                ? Expanded(
                    child: HC5Card(
                      isScrollable: false,
                      height: height,
                      padding: cardPadding,
                      cardDetails: card,
                    ),
                  )
                : const SizedBox.shrink())
            .toList(),
      ),
    );
  }
}

class HC5Card extends StatelessWidget {
  final CardModel cardDetails;
  final double? height;
  final EdgeInsets padding;
  final bool isScrollable;

  HC5Card({
    required this.cardDetails,
    required this.height,
    required this.padding,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        launchHyperlink(cardDetails.url, context);
      },
      child: Container(
        margin: isScrollable ? padding : null,
        height: height,
        decoration: BoxDecoration(
          color: cardDetails.getBackgroundColor,
          image: DecorationImage(
              image: cardDetails.backgroundImage!.getImage() as ImageProvider<Object>),
        ),
        child: AspectRatio(
          aspectRatio: cardDetails.backgroundImage?.aspectRatio?.toDouble() ?? 16 / 9,
          child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment:
                    cardDetails.formattedTitle?.getCrossAxisAlignment ?? CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: cardDetails.formattedTitle!.generateSpans(),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
// The  HC5Card  class is a stateless widget that represents a card with an image. It has one property:  imageUrl , which is the URL of the image to be displayed on the card. The card displays the image in a  Card  widget with the  Image.network  widget as its child. The  fit: BoxFit.cover  parameter ensures that the image covers the entire card.
