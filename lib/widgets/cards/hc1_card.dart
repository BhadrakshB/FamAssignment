import 'package:flutter/material.dart';
import '../../api/models/card_model.dart';
import '../../utils/funtions.dart';

class HC1CardBuilder extends StatelessWidget {
  final double cardSpacing;
  final EdgeInsets cardPadding;
  final EdgeInsets cardMargin;
  final List<CardModel?> cardDetails;
  final double? height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC1CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
    this.cardSpacing = 8,
    this.cardPadding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
    this.cardMargin = const EdgeInsets.only(
      top: 8,
      bottom: 8,
      left: 10,
      right: 10,
    ),
  });

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return buildIfScrollable(context);
    } else {
      return buildIfNotScrollable();
    }
  }

  Widget buildIfScrollable(BuildContext context) {
    return Container(
      height: height,
      margin: cardMargin.copyWith(left: 0, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cardDetails
              .map((card) => card != null
                  ? SizedBox(
                      width: isFullWidth ? MediaQuery.of(context).size.width : null,
                    child: HC1Card(
                        height: height,
                        cardDetails: card,
                        padding: cardPadding,
                        isScrollable: true,
                      ),
                  )
                  : const SizedBox.shrink())
              .toList(),
        ),
      ),
    );
  }

  Widget buildIfNotScrollable() {
    return Container(
      height: height,
      margin: cardMargin,
      child: Row(
        spacing: cardSpacing,
        children: cardDetails
            .map((card) => card != null
                ? Expanded(
                    child: HC1Card(
                      height: height,
                      cardDetails: card,
                      padding: cardPadding,
                    ),
                  )
                : const SizedBox.shrink())
            .toList(),
      ),
    );
  }
}
// The  HC1Card  class is a stateless widget that represents a card with a title and description. It takes two required parameters:  title  and  description . The  build  method returns a  Card  widget with a  ListTile  child that displays the title and description.

class HC1Card extends StatelessWidget {
  final CardModel cardDetails;
  final double? height;
  final EdgeInsets padding;
  final bool isScrollable;

  const HC1Card({
    super.key,
    required this.cardDetails,
    required this.height,
    required this.padding,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: isScrollable ? const EdgeInsets.only(left: 10, right: 10) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: cardDetails.getBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
          onTap: () async {
            launchHyperlink(cardDetails.url, context);
          },
          child: Padding(
            padding: padding.copyWith(left: 10, right: 10),
            child: Row(
              spacing: 14,
              mainAxisSize: MainAxisSize.min,
              children: [
                cardDetails.icon != null
                    ? cardDetails.getIcon(isDecorationImage: false) as Widget
                    : const SizedBox.shrink(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: cardDetails.formattedTitle?.getCrossAxisAlignment ??
                        CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: cardDetails.formattedTitle!.generateSpans(),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      cardDetails.description != null
                          ? RichText(
                              text: cardDetails.formattedDescription!.generateSpans(),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
