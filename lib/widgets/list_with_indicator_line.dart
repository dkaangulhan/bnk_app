import 'package:banking_application/blocs/operations_dashboard/dashboard_bloc.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_states.dart';
import 'package:banking_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//This widget displays list where elements are indicated with indicator line which contains circle and line
class ListWithIndicatorLine extends StatelessWidget {
  const ListWithIndicatorLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardBloc dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    DashboardBlocState state = dashboardBloc.state;

    return dashboardBloc.state.dataLoaded
        ? ListView.builder(
            itemBuilder: (_, index) => Container(
              height: kTransactionHistoryListHeight,
              padding: const EdgeInsets.only(left: 55.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListIndicatorLine(
                    //If transaction made from user it is red, otherwise
                    // blueAccent
                    lineColor: state.data![index].from == dummyUser
                        ? Colors.redAccent
                        : Colors.blueAccent,
                    drawLine: index != state.data!.length - 1,
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  Container(
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${state.data![index].total}',
                          style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                              color: kPrimaryTextColor),
                        ),
                        Text(
                          '${state.data![index].from == dummyUser ? state.data![index].to : state.data![index].from}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            itemCount: state.data!.length,
          )
        : const Text('No Data!');
  }
}

/*This widget will be used for drawing lines in to list
of operations such as transactions*/
class ListIndicatorLine extends StatelessWidget {
  final Color lineColor;
  final bool drawLine;
  const ListIndicatorLine({
    Key? key,
    this.lineColor = Colors.redAccent,
    this.drawLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustomPainter(
        lineColor: lineColor,
        drawLine: drawLine,
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Color lineColor;
  final bool drawLine;
  MyCustomPainter({
    this.lineColor = Colors.redAccent,
    this.drawLine = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint();
    circlePaint.color = lineColor;
    circlePaint.strokeWidth = 1.0;

    canvas.drawCircle(
      const Offset(3.0, 16.0),
      4.0,
      circlePaint,
    );
    if (drawLine) {
      canvas.drawLine(
        const Offset(3.0, 16.0),
        //kTransactionHistoryListHeight is line's height
        const Offset(3.0, 16 + kTransactionHistoryListHeight),
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
