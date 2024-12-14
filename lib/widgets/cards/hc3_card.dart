import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';
import '../../api/models/formatted_text_model.dart';

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
        decoration: BoxDecoration(
          color: cardDetails.getBackgroundColor,
          image: DecorationImage(
              image: cardDetails.backgroundImage!.getImage() as ImageProvider<Object>),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 91),
          child: Column(
            crossAxisAlignment:
                cardDetails.formattedTitle?.getCrossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(text: cardDetails.formattedTitle!.generateSpans()),
              const SizedBox(height: 50),
              ...?cardDetails.callToAction?.map((cta) {
                return ElevatedButton(
                  onPressed: () async {
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
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    shape: cta?.isCircular ?? false
                        ? WidgetStateProperty.all<OutlinedBorder>(CircleBorder(
                            side: BorderSide(width: cta?.strokeWidth!.toDouble() ?? 1),
                          ))
                        : WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )),
                    backgroundColor: WidgetStateProperty.all<Color>(cta?.getColor ?? Colors.white),
                  ),
                  child: Text(
                    cta!.text!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

}
// The  HC3Card  class is a stateless widget that represents a card with an image and a title. It has three properties:  title ,  imageUrl , and  onLongPress . The  title  property is the title of the card, the  imageUrl  property is the URL of the image to be displayed on the card, and the  onLongPress  property is a callback that is called when the card is long-pressed.
