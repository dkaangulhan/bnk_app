import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final Widget content;
  final bool selected;
  //if null, width will be defined by content in it
  final fixedWidth;
  final border;
  final backgroundColor;
  final activeBackgroundColor;
  final Function()? onTap;
  const MyChip({
    Key? key,
    required this.content,
    this.selected = false,
    this.fixedWidth,
    this.border,
    this.onTap,
    this.backgroundColor,
    this.activeBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fixedWidth,
        padding: const EdgeInsets.symmetric(),
        margin: const EdgeInsets.only(
          right: 15.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: border,
          color: selected ? activeBackgroundColor : backgroundColor,
        ),
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
