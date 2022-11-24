import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQueryData.size.width,
      height: 220.0,
      margin: const EdgeInsets.only(left: 18.0),
      padding: EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          bottomLeft: Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Color(0x66F66A78),
          ),
        ],
        color: Color(0xFFFFA7AE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.circle_outlined,
          ),
          SizedBox(
            width: 160.0,
            height: 60.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  //budget
                  '\$2,298.76',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  //obscured card number
                  '**** 1963',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
