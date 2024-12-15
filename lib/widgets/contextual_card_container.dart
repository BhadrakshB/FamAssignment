import 'package:flutter/material.dart';
import '../api/models/card_group.dart';
import '../api/models/screen_card.dart';
import '../utils/storage_utils.dart';
import 'cards/hc1_card.dart';
import 'cards/hc3_card.dart';
import 'cards/hc5_card.dart';
import 'cards/hc6_card.dart';
import 'cards/hc9_card.dart';

class ContextualCardContainer extends StatefulWidget {
  final List cards;

  ContextualCardContainer({required this.cards});

  @override
  State<ContextualCardContainer> createState() => _ContextualCardContainerState();
}

class _ContextualCardContainerState extends State<ContextualCardContainer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.cards.length,
      itemBuilder: (context, index) {
        final CardGroup card = widget.cards[index];
        switch (card.designType) {
          case 'HC1':
            return HC1CardBuilder(
              cardDetails: card.cards,
              height: card.height?.toDouble(),
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
            );
          case 'HC3':
            return HC3CardBuilder(
              cardDetails: card.cards,
              height: card.height?.toDouble(),
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
              dismissCard: (localCardId) async {
                await StorageUtil.saveDismissCard(
                  card.id.toString(),
                  localCardId.toString(),
                );

                setState(() {
                  card.cards.removeWhere((element) {
                    return element?.id == localCardId;
                  });
                });
              },
              remindLater: (localCardId) async {
                await StorageUtil.saveRemindLater(
                  card.id.toString(),
                  localCardId.toString(),
                );

                setState(() {
                  card.cards.removeWhere((element) {
                    return element?.id == localCardId;
                  });
                });
              },
              cardGroupId: card.id,
            );
          case 'HC5':
            return HC5CardBuilder(
              cardDetails: card.cards,
              height: card.height?.toDouble(),
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
            );
          case 'HC6':
            return HC6CardBuilder(
              cardDetails: card.cards,
              height: card.height?.toDouble(),
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
            );
          case 'HC9':
            return HC9CardBuilder(
              cardDetails: card.cards,
              height: card.height!.toDouble(),
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
// The  CardGroupWidget  class is a stateless widget that displays a list of cards based on their type. It takes a list of cards as input and uses a  ListView.builder  to build the cards dynamically. The  cards  list contains objects with a  type  property that specifies the type of card to display. The  build  method switches on the card type and returns the corresponding card widget based on the type. If the card type is not recognized, it returns an empty  SizedBox .
