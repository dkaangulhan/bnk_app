import 'package:banking_application/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/card.dart';
import '../widgets/dashboard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF287CFA),
        body: Column(
          children: [
            //My Cards text
            const SizedBox(
              height: 80.0,
              child: Center(
                child: Text(
                  'My Cards',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //ListView of cards' ids
            Container(
              height: 40.0,
              color: Colors.white10,
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Stack where card information is displayed
            Expanded(
              child: Stack(
                children: [
                  //Dashboard
                  Positioned(
                    bottom: 0,
                    child: Dashboard(mediaQueryData: mediaQueryData),
                  ),
                  //Card display
                  SizedBox(
                    width: mediaQueryData.size.width,
                    height: 200.0,
                    child: Row(
                      children: [
                        //Add Card
                        Container(
                          width: 50.0,
                          height: 220.0,
                          margin: EdgeInsets.only(left: 30.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Color(0x81091638),
                              )
                            ],
                            color: Color(0xFFE7EEFC),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.redAccent,
                          ),
                        ),
                        //Card
                        Expanded(
                          child: MyCard(mediaQueryData: mediaQueryData),
                        )
                      ],
                    ),
                  ),
                  //MyBottomNavigationBar
                  MyBottomNavigationBar(mediaQueryData: mediaQueryData)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
