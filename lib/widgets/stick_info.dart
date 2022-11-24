import 'package:flutter/material.dart';

class StickInfo extends StatelessWidget {
  final value;
  final width;
  final height;
  final upward; //if this is true, info will look to up meaning
  const StickInfo({
    Key? key,
    this.value = 20.0,
    this.width = 10.0,
    this.height = 100.0,
    this.upward = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadiusUpward = upward
        ? const BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
        : const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: borderRadiusUpward,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: upward ? 0.0 : null,
            child: Container(
              width: width,
              //income or charge rate
              height: value + 0.0,
              decoration: BoxDecoration(
                color: upward ? Colors.blueAccent : Colors.redAccent,
                borderRadius: borderRadiusUpward,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
