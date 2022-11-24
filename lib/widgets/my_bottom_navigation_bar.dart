import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Container(
        width: widget.mediaQueryData.size.width,
        height: 75.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          boxShadow: kElevationToShadow[4],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.event_note,
              size: 35.0,
              color: selectedItem == 0 ? Colors.blueAccent : Colors.black,
            ),
            Icon(
              Icons.wallet,
              size: 35.0,
              color: selectedItem == 1 ? Colors.blueAccent : Colors.black,
            ),
            Icon(
              Icons.person,
              size: 35.0,
              color: selectedItem == 2 ? Colors.blueAccent : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
