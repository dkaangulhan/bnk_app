import 'package:banking_application/widgets/dashboard.dart';
import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final DurationEnum durationId;
  final isSelected;
  final Function() tap;
  const MyChip({
    Key? key,
    required this.durationId,
    required this.isSelected,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 14.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: isSelected
              ? Border.all(
                  color: Color(0xFF201D2E),
                  width: 1.5,
                )
              : null,
        ),
        child: Text(
          durationId.name.replaceRange(
            0,
            1,
            durationId.name[0].toUpperCase(),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
