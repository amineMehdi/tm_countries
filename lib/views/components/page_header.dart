import 'package:flutter/material.dart';


class PageHeader extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Color? iconColor;
  const PageHeader(
      {super.key,
      required this.title,
      this.iconData = Icons.close,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          iconData,
          color: iconColor,
          size: 50,
        ),
      ),
      Text(title, style: Theme.of(context).textTheme.headline1)
    ]);
  }
}