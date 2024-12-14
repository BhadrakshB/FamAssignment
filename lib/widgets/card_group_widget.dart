import 'package:flutter/material.dart';
import '../api/models/card_group.dart';
import '../api/models/screen_card.dart';
import 'cards/hc1_card.dart';
import 'cards/hc3_card.dart';
import 'cards/hc5_card.dart';
import 'cards/hc6_card.dart';
import 'cards/hc9_card.dart';

class CardGroupWidget extends StatelessWidget {
  final List cards;

  CardGroupWidget({required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final CardGroup card = cards[index];
        switch (card.designType) {
          // case 'HC1':
          //   return HC1Card(
          //     title: card.cards[0]?.title,
          //   );
          // case 'HC3':
          //   return HC3Card(
          //     cardDetails: card.cards[0]!,
          //     height: card.height!.toDouble(),
          //     isFullWidth: card.isFullWidth!,
          //     isScrollable: card.isScrollable!,
          //   );
          case 'HC5':
            return HC5Card(
              cardDetails: card.cards[0]!,
              isFullWidth: card.isFullWidth!,
              isScrollable: card.isScrollable!,
            );
          // case 'HC6':
          //   return HC6Card(
          //     cardDetails: card.cards[0]!,
          //     height: card.height!.toDouble(),
          //     isFullWidth: card.isFullWidth!,
          //     isScrollable: card.isScrollable!,
          //   );
          // case 'HC9':
          //   return HC9Card(
          //     imageUrl: card.cards[0]?.backgroundImage?.imageUrl,
          //     width: 150.0, // Dynamically calculate if required
          //   );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
// The  CardGroupWidget  class is a stateless widget that displays a list of cards based on their type. It takes a list of cards as input and uses a  ListView.builder  to build the cards dynamically. The  cards  list contains objects with a  type  property that specifies the type of card to display. The  build  method switches on the card type and returns the corresponding card widget based on the type. If the card type is not recognized, it returns an empty  SizedBox .