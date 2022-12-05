import 'package:banking_application/blocs/cards/cards_bloc.dart';
import 'package:banking_application/blocs/cards/cards_bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    Key? key,
    required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  late final cardsBloc;
  double animatedMargin = 150.0;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    cardsBloc = context.read<CardsBloc>();
    animationController.addListener(() {
      setState(() {
        animatedMargin = 18.0 + (150 * (1 - animationController.value));
      });
    });
    (cardsBloc as CardsBloc).stream.listen((event) {
      animatedMargin = 150.0;
      animationController.reset();
      animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    cardsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mediaQueryData.size.width,
      height: 220.0,
      margin: EdgeInsets.only(left: animatedMargin),
      padding: EdgeInsets.all(18.0),
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
            child: StreamBuilder(
              stream: context.read<CardsBloc>().stream,
              builder: (_, snapshot) {
                final state =
                    snapshot.data != null ? snapshot.data as CardsState : null;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (state != null && state.loaded)
                          ? '\$${state.assets}'
                          : '?'
                      //budget
                      ,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      //obscured card number
                      '*** ${(state != null && state.loaded) ? state.cardId : '?'}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
