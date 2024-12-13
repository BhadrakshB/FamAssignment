import 'package:flutter/material.dart';

class HC9Card extends StatelessWidget {
  final String? imageUrl;
  final double width;

  const HC9Card({required this.imageUrl, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Image.network(imageUrl ?? '', fit: BoxFit.cover),
    );
  }
}
// The  HC9Card  class is a stateless widget that represents a card with an image. It has two properties:  imageUrl  and  width . The  imageUrl  property is the URL of the image to be displayed on the card, and the  width  property is the width of the card. The card displays the image in a  Container  widget with the specified width and the  Image.network  widget as its child. The  fit: BoxFit.cover  parameter ensures that the image covers the entire card.