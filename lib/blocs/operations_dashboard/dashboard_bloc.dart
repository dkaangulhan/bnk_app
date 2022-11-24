import 'dart:convert';

import 'package:banking_application/blocs/operations_dashboard/dashboard_action.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_states.dart';
import 'package:banking_application/models/transaction_data_model.dart';
import 'package:bloc/bloc.dart';
import 'dart:io' show HttpClient;

const dummyOperationsUrl = 'http://10.0.2.2:3000/users/operations';

class DashboardBloc extends Bloc<OperationsAction, DashboardBlocState> {
  DashboardBloc() : super(OperationState(dataLoaded: false)) {
    on<LoadOperationsAction>((event, emit) async {
      print('LoadOperationsAction was emitted..');
      //emit loading state
      emit(OperationState());

      //request data from DB. This will be sent to data layer.
      //response is expected to be JSON
      final operations = await HttpClient()
          .getUrl(Uri.parse(event.url))
          .then((req) => req.close())
          .then((res) => res.transform(utf8.decoder).join())
          .then((json) => jsonDecode(json) as Map);

      List<TransactionDataModel> list = [];
      operations.forEach((key, value) {
        list.add(TransactionDataModel.fromObject(data: value));
      });

      //emit new state
      emit(
        OperationState(
          data: list,
          dataLoaded: true,
          displayMethod: DashboardDisplayMethods.stick,
        ),
      );
    });
  }
}
