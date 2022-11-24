import 'dart:convert';
import 'dart:io';

import 'package:banking_application/blocs/operations_dashboard/dashboard_action.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_bloc.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_states.dart';
import 'package:banking_application/models/transaction_data_model.dart';
import 'package:banking_application/widgets/my_chip.dart';
import 'package:banking_application/widgets/stick_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final bloc = DashboardBloc();

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
    const seperator30 = SizedBox(
      height: 30.0,
    );

    return BlocProvider(
      create: (_) => bloc,
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
                          children: const [
                            Text(
                              'See Details',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
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
                  stream: bloc.stream,
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
                                  '\$1,298',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
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
                                  '\$826',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).primaryColor),
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
                        width: 20.0,
                      ),
                      //Income-charge graphic
                      Expanded(
                        child: bloc.state.dataLoaded
                            ? SizedBox(
                                height: 200.0,
                                child: Column(
                                  children: [
                                    //Income list
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: listToWidgetList(
                                          bloc.state.data!,
                                          (obj) {
                                            obj as TransactionDataModel;
                                            return StickInfo(
                                              value: obj.total,
                                            );
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          StickInfo(
                                            value: 15.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 85.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 35.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 55.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 75.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 65.0,
                                            upward: false,
                                          ),
                                          StickInfo(
                                            value: 85.0,
                                            upward: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                'No Data!',
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
        MyChip(
          durationId: durationList[i],
          isSelected: selectedItem == i,
          tap: () {
            setState(() {
              selectedItem = i;
            });
            context
                .read<DashboardBloc>()
                .add(LoadOperationsAction(url: dummyOperationsUrl));
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
