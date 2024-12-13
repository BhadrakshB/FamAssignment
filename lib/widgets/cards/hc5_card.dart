import 'package:flutter/material.dart';

class HC5Card extends StatelessWidget {
  final String? imageUrl;

  HC5Card({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image.network(imageUrl ?? '', fit: BoxFit.cover),
    );
  }
}
// The  HC5Card  class is a stateless widget that represents a card with an image. It has one property:  imageUrl , which is the URL of the image to be displayed on the card. The card displays the image in a  Card  widget with the  Image.network  widget as its child. The  fit: BoxFit.cover  parameter ensures that the image covers the entire card.