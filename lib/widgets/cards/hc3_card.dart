import 'package:fam_assignment/utils/funtions.dart';
import 'package:fam_assignment/utils/storage_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/models/card_model.dart';
import '../../api/models/formatted_text_model.dart';

class HC3CardBuilder extends StatefulWidget {
  final int cardGroupId;
  final List<CardModel?> cardDetails;
  final double cardSpacing;
  final EdgeInsets cardPadding;
  final EdgeInsets cardMargin;
  final double? height;
  final bool isScrollable;
  final bool isFullWidth;
  final Function(int) dismissCard;
  final Function(int) remindLater;

  const HC3CardBuilder({
    super.key,
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    this.isFullWidth = false,
    this.cardSpacing = 8,
    this.cardPadding = const EdgeInsets.symmetric(
      vertical: 10,
    ),
    this.cardMargin = const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 10,
    ),
    required this.dismissCard,
    required this.remindLater,
    required this.cardGroupId,
  });

  @override
  State<HC3CardBuilder> createState() => _HC3CardBuilderState();
}

class _HC3CardBuilderState extends State<HC3CardBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var card in widget.cardDetails) {
      print("Card ID: ${card?.id}");
      if (card != null) {
        StorageUtil.isDismissCardSaved(
          widget.cardGroupId.toString(),
          card.id.toString(),
        ).then((value) {
          print("Dismiss Card: $value");
          if (value) {
            setState(() {
              widget.cardDetails.remove(card);
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isScrollable) {
      return buildIfScrollable(context);
    } else {
      return buildIfNotScrollable();
    }
  }

  Widget buildIfScrollable(BuildContext context) {
    // cardDetails.insert(0, cardDetails.elementAt(0)); // : TO CHECK FOR SCROLLABILITY IF NEEDED
    if (widget.cardDetails.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: widget.cardMargin.copyWith(left: 0, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.cardDetails.map((card) {
            return card != null
                ? SizedBox(
                    width: widget.isFullWidth ? MediaQuery.of(context).size.width : null,
                    child: HC3Card(
                      isScrollable: true,
                      dismissCard: () {
                        setState(() {
                          widget.dismissCard(card.id!);
                        });
                      },
                      remindLater: () {
                        setState(() {
                          widget.remindLater(card.id!);
                        });
                      },
                      height: widget.height,
                      cardDetails: card,
                      padding: widget.cardPadding.copyWith(left: 10, right: 10),
                    ),
                  )
                : const SizedBox.shrink();
          }).toList(),
        ),
      ),
    );
  }

  Widget buildIfNotScrollable() {
    // widget.cardDetails.insert(0, widget.cardDetails.elementAt(0)); // : TO CHECK FOR SCROLLABILITY IF NEEDED
    if (widget.cardDetails.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: widget.cardMargin.copyWith(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: widget.cardSpacing,
        children: widget.cardDetails
            .map((card) => card != null
                ? Expanded(
                    child: HC3Card(
                      dismissCard: () {
                        setState(() {
                          widget.dismissCard(card.id);
                        });
                      },
                      remindLater: () {
                        setState(() {
                          widget.remindLater(card.id);
                        });
                      },
                      isScrollable: false,
                      height: widget.height,
                      padding: widget.cardPadding,
                      cardDetails: card,
                    ),
                  )
                : const SizedBox.shrink())
            .toList(),
      ),
    );
  }
}

class HC3Card extends StatefulWidget {
  final CardModel cardDetails;
  final double? height;
  final bool isScrollable;
  final EdgeInsets padding;
  final Function() dismissCard;
  final Function() remindLater;

  HC3Card({
    required this.cardDetails,
    required this.height,
    this.isScrollable = false,
    required this.padding,
    required this.dismissCard,
    required this.remindLater,
  });

  @override
  State<HC3Card> createState() => _HC3CardState();
}

class _HC3CardState extends State<HC3Card> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isSliding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.3, 0), // Adjust slide distance here
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLongPress() {
    setState(() {
      _isSliding = !_isSliding;
    });
    if (_isSliding) {
      _controller.reverse();
    } else
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        launchHyperlink(widget.cardDetails.url, context);
      },
      onLongPress: _onLongPress,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              margin: widget.isScrollable ? widget.padding : null,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.remindLater();
                            });
                          },
                          child: Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.notifications, color: Colors.orange, size: 28),
                                SizedBox(height: 4),
                                Text(
                                  'Remind Later',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50), // Spacing between buttons
                        // "Dismiss Now" Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.dismissCard();
                            });
                          },
                          child: Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.cancel, color: Colors.red, size: 28),
                                SizedBox(height: 4),
                                Text(
                                  'Dismiss Now',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: widget.isScrollable
                        ? MediaQuery.of(context).size.width * 0.9
                        : MediaQuery.of(context).size.width * 0.65,
                  ),
                ],
              ),
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              height: widget.height,
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              margin: widget.isScrollable ? widget.padding : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.cardDetails.getBackgroundColor,
                image: DecorationImage(
                  image: widget.cardDetails.backgroundImage!.getImage() as ImageProvider<Object>,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              child: Column(
                crossAxisAlignment: widget.cardDetails.formattedTitle?.getCrossAxisAlignment ??
                    CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: RichText(
                      text: widget.cardDetails.formattedTitle!.generateSpans(),
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ...?widget.cardDetails.callToAction?.map((cta) {
                    return ElevatedButton(
                      onPressed: () async {
                        launchHyperlink(widget.cardDetails.url, context);
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
                        backgroundColor:
                            WidgetStateProperty.all<Color>(cta?.getColor ?? Colors.white),
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
        ],
      ),
    );
  }
}
// The  HC3Card  class is a stateless widget that represents a card with an image and a title. It has three properties:  title ,  imageUrl , and  onLongPress . The  title  property is the title of the card, the  imageUrl  property is the URL of the image to be displayed on the card, and the  onLongPress  property is a callback that is called when the card is long-pressed.
