import 'package:fam_assignment/utils/funtions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';

class HC9CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;
  final double cardSpacing;
  final EdgeInsets cardPadding;
  final EdgeInsets cardMargin;

  const HC9CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
    this.cardSpacing = 15,
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
    return buildScrollable(context);
  }

  Widget buildScrollable(BuildContext context) {
    return Container(
      height: height,

      margin: cardMargin.copyWith(left: 0, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: cardSpacing,
          children: cardDetails
              .map((card) => card != null
                  ? SizedBox(
                      width: isFullWidth ? MediaQuery.of(context).size.width : null,
                      child: HC9Card(
                        height: height,
                        cardDetails: card,
                      ),
                    )
                  : const SizedBox.shrink())
              .toList()
            ..insert(0, const SizedBox(width: 0))
            ..insert(cardDetails.length + 1, const SizedBox(width: 10)),
        ),
      ),
    );
  }
}
// The  HC9Card  class is a stateless widget that represents a card with a title and description. It takes two required parameters:  title  and  description . The  build  method returns a  Card  widget with a  ListTile  child that displays the title and description.

class HC9Card extends StatelessWidget {
  final CardModel cardDetails;
  final double height;

  const HC9Card({super.key, required this.cardDetails, required this.height});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: cardDetails.backgroundImage?.aspectRatio?.toDouble() ?? 1.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(8),
          gradient: cardDetails.backgroundGradient?.getGradient,
          image: DecorationImage(
              image: cardDetails.backgroundImage?.getImage(isDecorationImage: true)
                  as ImageProvider<Object>),
        ),
        height: height,
        child: InkWell(
            onTap: () async {
              launchHyperlink(cardDetails.url, context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                spacing: 14,
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
                  )
                ],
              ),
            )),
      ),
    );
  }
}
