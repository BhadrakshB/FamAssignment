import 'package:fam_assignment/utils/funtions.dart';
import 'package:flutter/material.dart';

import '../../api/models/card_model.dart';

class HC6CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double cardSpacing;
  final EdgeInsets cardPadding;
  final EdgeInsets cardMargin;
  final double? height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC6CardBuilder({
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
    print("Height: $height");
    if (!isScrollable) {
      return buildIfScrollable(context);
    } else {
      return buildIfNotScrollable();
    }
  }

  Widget buildIfScrollable(BuildContext context) {
    cardDetails.insert(0, cardDetails.elementAt(0)); // : TO CHECK FOR SCROLLABILITY IF NEEDED
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: cardDetails
            .map((card) => card != null
                ? SizedBox(
                    width: isFullWidth ? MediaQuery.of(context).size.width : null,
                    child: HC6Card(
                      isScrollable: true,
                      height: height,
                      cardDetails: card,
                      padding: cardPadding.copyWith(left: 10, right: 10),
                    ),
                  )
                : const SizedBox.shrink())
            .toList(),
      ),
    );
  }

  Widget buildIfNotScrollable() {
    // cardDetails.insert(0, cardDetails.elementAt(0)); // : TO CHECK FOR SCROLLABILITY IF NEEDED
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: cardDetails
          .map((card) => card != null
              ? Expanded(
                  child: HC6Card(
                    isScrollable: false,
                    height: height,
                    padding: cardPadding,
                    cardDetails: card,
                  ),
                )
              : const SizedBox.shrink())
          .toList(),
    );
  }
}

class HC6Card extends StatelessWidget {
  final CardModel cardDetails;
  final double? height;
  final bool isScrollable;
  final bool isFullWidth;
  final EdgeInsets padding;

  HC6Card({
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchHyperlink(cardDetails.url, context);
      },
      child: Container(
        height: height,
        margin: isScrollable
            ? padding.copyWith(
                left: 10,
                right: 10,
                top: 0,
                bottom: 0,
              )
            : padding.copyWith(
                right: 10,
                left: 10,
              ),
        decoration: BoxDecoration(
          color: cardDetails.getBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (cardDetails.icon != null)
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: AspectRatio(
                          aspectRatio: cardDetails.icon!.aspectRatio?.toDouble() ?? 1,
                          child: cardDetails.getIcon(isDecorationImage: false) as Widget)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardDetails.formattedTitle?.text != null
                          ? RichText(
                              text: cardDetails.formattedTitle!.generateSpans(),
                              softWrap: false,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            )
                          : const SizedBox.shrink(),
                      cardDetails.formattedDescription?.text != null
                          ? const SizedBox(height: 5)
                          : const SizedBox.shrink(),
                      cardDetails.formattedDescription?.text != null
                          ? RichText(
                              text: cardDetails.formattedDescription!.generateSpans(),
                              softWrap: false,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                // Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            )),
      ),
    );
  }
}
// The  HC6Card  class is a stateless widget that represents a card with a title and a trailing icon. It has one property:  title , which is the title of the card. The card displays the title in a  ListTile  widget with an arrow icon as the trailing widget. The  Icon(Icons.arrow_forward)  widget creates the arrow icon that appears on the right side of the card.
