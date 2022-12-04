import 'package:flutter/material.dart';
import 'package:tm_countries/utils/utils.dart' as utils;

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
        future: utils.getImagePalette(NetworkImage(imageUrl)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _backButton(context, snapshot.data!, Colors.black);
          } else {
            return _backButton(context, Colors.blue, Colors.white);
          }
        });
  }

  Ink _backButton(
      BuildContext context, Color backgroundColor, Color? iconColor) {
    return Ink(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: iconColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
