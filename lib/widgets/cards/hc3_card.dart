import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';
import '../../api/models/formatted_title_model.dart';

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
              RichText(text: buildTextSpan(cardDetails.formattedTitle!)),
              SizedBox(height: 50),
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

  TextSpan buildTextSpan(FormattedTitleModel formattedTitle) {
    final template = formattedTitle.text ?? '';
    final replacements = formattedTitle.entities?.map((entity) {
          final style = TextStyle(
            fontSize: entity?.getFontSize,
            color: entity?.getColor,
            fontWeight: entity?.getFontWeight,
            fontStyle: entity?.getStyling.runtimeType == FontStyle ? entity?.getStyling : null,
            decoration:
                entity?.getStyling.runtimeType == TextDecoration ? entity?.getStyling : null,
          );
          return {entity?.text ?? '': style};
        }).toList() ??
        [];
    final placeholderPattern = RegExp(r"\{\}");
    int index = 0;

    // Split the template into parts with matches and non-matches
    List<InlineSpan> spans = [];
    var splitList = template.split(placeholderPattern);
    print(splitList);

    template.splitMapJoin(
      placeholderPattern,
      onMatch: (match) {
        // Add replacement with style
        if (index < replacements.length) {
          final replacement = replacements[index].keys.first;
          final style = replacements[index].values.first;

          if (replacement == "") {
            return '';
          }

          spans.add(const WidgetSpan(
              child: SizedBox(
            height: 70,
          )));

          spans.add(TextSpan(
            text: replacement,
            style: style,
          ));

          index++;
        }

        return ''; // No actual text is added here
      },
      onNonMatch: (nonMatch) {
        // Add plain text (non-placeholder text)
        spans.add(TextSpan(
            text: nonMatch, style: replacements.first.values.first.copyWith(color: Colors.white)));
        return ''; // No actual text is added here
      },
    );

    spans.removeAt(0);
    spans.removeLast();
    spans.insert(
        0,
        WidgetSpan(
            child: SizedBox(
          height: 100,
        )));
    print(spans.length);
    print(spans);

    return TextSpan(children: spans);
  }
}
// The  HC3Card  class is a stateless widget that represents a card with an image and a title. It has three properties:  title ,  imageUrl , and  onLongPress . The  title  property is the title of the card, the  imageUrl  property is the URL of the image to be displayed on the card, and the  onLongPress  property is a callback that is called when the card is long-pressed.
