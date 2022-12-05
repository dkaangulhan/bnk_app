import 'dart:async';

import 'package:banking_application/blocs/cards/cards_bloc.dart';
import 'package:banking_application/blocs/cards/cards_bloc_states.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_action.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_bloc.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_states.dart';
import 'package:banking_application/models/transaction_data_model.dart';
import 'package:banking_application/models/transaction_data_model_adapter.dart';
import 'package:banking_application/widgets/duration_chip.dart';
import 'package:banking_application/widgets/list_with_indicator_line.dart';
import 'package:banking_application/widgets/my_bottom_navigation_bar.dart';
import 'package:banking_application/widgets/stick_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashboardBloc = DashboardBloc(BasicTransactionAdapter());

  @override
  void dispose() {
    dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const seperator30 = SizedBox(
      height: 30.0,
    );

    return BlocBuilder(
      bloc: context.read<CardsBloc>(),
      buildWhen: (previous, current) {
        if (previous == null) {
          dashboardBloc.add(
            LoadOperationsAction(
              url: kDummyOperationsUrl,
              cardId: (current as CardsState).cardId,
            ),
          );
          return false;
        }

        //if card information changed, then DashboardBloc need to get an event;
        previous as CardsState;
        current as CardsState;

        //This will load operations belonging to current cardData
        if (previous.cardId != current.cardId) {
          dashboardBloc.add(
            LoadOperationsAction(
              url: kDummyOperationsUrl,
              cardId: current.cardId,
            ),
          );
        }

        return false;
      },
      builder: (_, __) {
        return BlocProvider(
          create: (_) => dashboardBloc,
          child: Container(
            width: widget.mediaQueryData.size.width,
            height: 470.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
            ),
            //Dashboard data
            child: Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 40.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //operations
                            const Text(
                              'Operations',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF201D2E),
                              ),
                            ),
                            //See details
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor:
                                          Colors.white.withAlpha(0),
                                      isScrollControlled: true,
                                      builder: (_) => Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.92,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: BlocProvider.value(
                                          value: BlocProvider.of<CardsBloc>(
                                              context),
                                          child: BlocProvider.value(
                                            value: dashboardBloc,
                                            child: const MyBottomSheet(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'See Details',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14.0,
                                  color: Colors.lightBlue,
                                ),
                              ],
                            ),
                          ],
                        ),
                        seperator30,
                        DurationSelectWidget(),
                      ],
                    ),
                  ),
                  seperator30,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.0,
                    ),
                    child: StreamBuilder(
                      stream: dashboardBloc.stream,
                      builder: (_, __) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //income-charge in texts
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Income
                              SizedBox(
                                height: 75.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dashboardBloc.state.income != null
                                          ? '\$${dashboardBloc.state.income!.round()}'
                                          : '?',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      'Income',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Charge
                              SizedBox(
                                height: 75.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dashboardBloc.state.charges != null
                                          ? '\$${dashboardBloc.state.charges!.round()}'
                                          : '?',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      'Charges',
                                      style: TextStyle(
                                        color: Colors.red.shade300,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 64.0,
                          ),
                          //Income-Charge graphic
                          StickInfoChart(dashboardBloc: dashboardBloc),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardsBloc cardsBloc = context.read<CardsBloc>();
    CardsState? state = cardsBloc.state;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //pull indicator
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 25.0,
              child: Center(
                child: Container(
                  width: 56.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 11.0),
            //Operations text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Operations',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text('*** ${state != null ? state.cardId : '?'}'),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(Icons.circle_outlined),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                width: 500.0,
                color: Color(0xFFF6F8FE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 42.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        'Recent',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //Purchase category list
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                      padding: EdgeInsets.only(left: 24.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => Text('1'),
                        itemCount: 1,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //History Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120.0,
                          child: Center(
                            child: const Text(
                              'History',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: const Icon(
                            Icons.search,
                            size: 32.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    //History
                    Expanded(
                      child: ListWithIndicatorLine(),
                    ),
                  ],
                ),
              ),
            ),
            MyBottomNavigationBar(
              mediaQueryData: MediaQuery.of(context),
            ),
          ],
        ),
      ],
    );
  }
}

class DurationSelectWidget extends StatefulWidget {
  const DurationSelectWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DurationSelectWidget> createState() => _DurationSelectWidgetState();
}

class _DurationSelectWidgetState extends State<DurationSelectWidget> {
  int selectedItem = 0;
  List<DurationEnum> durationList = DurationEnum.values;
  List<Widget> durationWidgetList = [];
  @override
  Widget build(BuildContext context) {
    durationWidgetList = [];
    for (int i = 0; i < durationList.length; i++) {
      durationWidgetList.add(
        DurationChip(
          durationId: durationList[i],
          isSelected: selectedItem == i,
          tap: () {
            setState(() {
              selectedItem = i;
            });
            context.read<DashboardBloc>().add(
                  LoadOperationsAction(
                    url: kDummyOperationsUrl,
                    cardId: context.read<CardsBloc>().state!.cardId,
                  ),
                );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: durationWidgetList,
          ),
        ),
        const Icon(
          Icons.date_range,
        ),
      ],
    );
  }
}

enum DurationEnum {
  day,
  week,
  month,
  year,
}

/*
This class will be used for creating weekly, monthly income-charge graphics
 */
class StickInfoChart extends StatefulWidget {
  final dashboardBloc;
  const StickInfoChart({
    Key? key,
    required this.dashboardBloc,
  }) : super(key: key);

  @override
  State<StickInfoChart> createState() => _StickInfoChartState();
}

class _StickInfoChartState extends State<StickInfoChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final StreamSubscription cardsBlocStreamSubscription;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();

    //Ensures that when state comes from CardsBloc, it resets animation's
    // value and runs it again

    cardsBlocStreamSubscription =
        context.read<CardsBloc>().stream.listen((event) {
      animationController.reset();
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    cardsBlocStreamSubscription.cancel();
    super.dispose();
  }

  //This creates stickInfo widget using transaction data model
  List<Widget> listToWidgetList<T>(
      List<dynamic> list, Widget Function(dynamic obj) transform) {
    List<Widget> widgetList = [];

    for (int i = 0; i < list.length; i++) {
      widgetList.add(transform(list[i]));
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.dashboardBloc.state.dataLoaded
          ? SizedBox(
              height: 200.0,
              child: Column(
                children: [
                  //Income list
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: listToWidgetList(
                        widget.dashboardBloc.state.data!,
                        (obj) {
                          obj as TransactionDataModel;
                          return obj.to == dummyUser
                              ? Container(
                                  margin: kStickInfoMargin,
                                  child: StickInfo(
                                    value:
                                        obj.total * animationController.value,
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //Charge list
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: listToWidgetList(
                        widget.dashboardBloc.state.data!,
                        (obj) {
                          obj as TransactionDataModel;
                          return obj.from == dummyUser
                              ? Container(
                                  margin: kStickInfoMargin,
                                  child: StickInfo(
                                    value:
                                        obj.total * animationController.value,
                                    upward: false,
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Text(
              'No Data!',
            ),
    );
  }
}
