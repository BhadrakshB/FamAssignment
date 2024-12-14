import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';

class HC1CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC1CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
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
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cardDetails
              .map((card) => card != null
                  ? SizedBox(
                      width: 300,
                      child: HC1Card(
                        height: height,
                        cardDetails: card,
                      ),
                    )
                  : const SizedBox.shrink())
              .toList(),
        ),
      ),
    );
  }

  Widget buildIfNotScrollable() {
    return Row(
      children: cardDetails
          .map((card) => card != null
              ? Expanded(
                  child: HC1Card(
                    height: height,
                    cardDetails: card,
                  ),
                )
              : const SizedBox.shrink())
          .toList(),
    );
  }
}
// The  HC1Card  class is a stateless widget that represents a card with a title and description. It takes two required parameters:  title  and  description . The  build  method returns a  Card  widget with a  ListTile  child that displays the title and description.

class HC1Card extends StatelessWidget {
  final CardModel cardDetails;
  final double height;

  const HC1Card({super.key, required this.cardDetails, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Card(
        color: cardDetails.getBackgroundColor,
        child: InkWell(
            onTap: () async {
              try {
                Uri uri = Uri.parse(cardDetails.url ?? "");
                if (await canLaunchUrl(uri)) {
                  launchUrl(uri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch ${uri.toString()}'),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch ${cardDetails.url}'),
                  ),
                );
              }
            },
            child: Padding(

              padding: const EdgeInsets.only(right: 8),
              child: Row(
                spacing: 14,
                children: [

                  cardDetails.icon != null
                      ? cardDetails.icon!.getImage(isDecorationImage: false) as Widget
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
