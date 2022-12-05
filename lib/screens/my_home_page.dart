import 'package:banking_application/blocs/cards/cards_bloc.dart';
import 'package:banking_application/blocs/cards/cards_bloc_events.dart';
import 'package:banking_application/constants.dart';
import 'package:banking_application/widgets/my_bottom_navigation_bar.dart';
import 'package:banking_application/widgets/duration_chip.dart';
import 'package:banking_application/widgets/my_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        extendBody: true,
        bottomNavigationBar:
            //MyBottomNavigationBar
            MyBottomNavigationBar(mediaQueryData: mediaQueryData),
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
            CardIdList(),
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
                          width: 45.0,
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
                          child: MyCard(
                            mediaQueryData: mediaQueryData,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardIdList extends StatefulWidget {
  const CardIdList({
    Key? key,
  }) : super(key: key);

  @override
  State<CardIdList> createState() => _CardIdListState();
}

class _CardIdListState extends State<CardIdList> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    CardsBloc cardsBloc = context.read<CardsBloc>();

    final activeTextStyle = TextStyle(
      color: Colors.black,
    );
    final inactiveTextStyle = TextStyle(
      color: kWhiteishBackgroundColor,
    );

    return Container(
      height: 30.0,
      margin: const EdgeInsets.only(
        left: 30.0,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (_, mIndex) {
          final isSelected = mIndex == index;
          return MyChip(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected
                    ? Container(
                        margin: EdgeInsets.only(
                          right: 5.0,
                        ),
                        child: Icon(
                          Icons.circle,
                          color: Colors.blueAccent,
                          size: 6.0,
                        ),
                      )
                    : SizedBox(),
                Text(
                  dummyCardList[mIndex].cardType.name,
                  style: isSelected ? activeTextStyle : inactiveTextStyle,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.0,
                  ),
                  child: Icon(
                    Icons.star,
                    size: 8.0,
                    color: isSelected ? Colors.black : kWhiteishBackgroundColor,
                  ),
                ),
                Text(
                  dummyCardList[mIndex].id,
                  style: isSelected ? activeTextStyle : inactiveTextStyle,
                )
              ],
            ),
            fixedWidth: 115.0,
            activeBackgroundColor: Color(
              0xFFD4E1FC,
            ),
            border: Border.all(
              width: 1.5,
              color: kWhiteishBackgroundColor,
            ),
            onTap: () {
              setState(() {
                index = mIndex;
                context.read<CardsBloc>().add(
                      CardAction(
                        user: dummyUser,
                        cardId: dummyCardList[index].id,
                      ),
                    );
              });
            },
            selected: index == mIndex,
          );
        },
        itemCount: dummyCardList.length,
      ),
    );
  }
}
