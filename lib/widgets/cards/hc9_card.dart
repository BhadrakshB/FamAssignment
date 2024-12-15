import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';

class HC9CardBuilder extends StatelessWidget {
  final List<CardModel?> cardDetails;
  final double height;
  final bool isScrollable;
  final bool isFullWidth;

  const HC9CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return buildScrollable(context);
  }

  Widget buildScrollable(BuildContext context) {
    double spacing = 15;
    return Container(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: spacing,
          children: cardDetails
              .map((card) => card != null
              ? SizedBox(
            child: HC9Card(
              height: height,
              cardDetails: card,
            ),
          )
              : const SizedBox.shrink())
              .toList()..insert(0, SizedBox(width: 0))..insert(cardDetails.length + 1 , SizedBox(width: 21)),
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
    print("CARD DETAILS: ${cardDetails.backgroundImage?.aspectRatio?.toDouble() ?? 1.0}");
    return AspectRatio(
      aspectRatio: cardDetails.backgroundImage?.aspectRatio?.toDouble() ?? 1.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(8),
          gradient: cardDetails.backgroundGradient?.getGradient,
          image: DecorationImage(image: cardDetails.backgroundImage?.getImage(isDecorationImage: true) as ImageProvider<Object>),
        ),
        height: height,
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
