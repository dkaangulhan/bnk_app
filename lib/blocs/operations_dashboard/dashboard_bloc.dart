import 'package:banking_application/constants.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_action.dart';
import 'package:banking_application/blocs/operations_dashboard/dashboard_states.dart';
import 'package:banking_application/models/transaction_data_model_adapter.dart';
import 'package:bloc/bloc.dart';

class DashboardBloc<adapter extends TransactionAdapter>
    extends Bloc<OperationsAction, DashboardBlocState> {
  adapter transactionDataModelAdapter;

  DashboardBloc(this.transactionDataModelAdapter)
      : super(OperationState(dataLoaded: false)) {
    on<LoadOperationsAction>((event, emit) async {
      print('LoadOperationsAction was emitted..');
      //emit loading state
      emit(OperationState());

      /*
      //request data from DB. This will be sent to data layer.
      //response is expected to be JSON
      final operations = await HttpClient()
          .getUrl(Uri.parse(event.url))
          .then((req) => req.close())
          .then((res) => res.transform(utf8.decoder).join())
          .then((json) => jsonDecode(json) as Map);
*/
      final operations = dummyOperations;

      TransactionAdapterResult? transactionAdapterResult =
          transactionDataModelAdapter.transform(
        operations,
        input: {
          'cardId': event.cardId,
          'user': dummyUser,
        },
      );

      //Error state
      if (transactionAdapterResult == null) {
        emit(OperationState());
        return;
      }

      //emit new state
      emit(
        OperationState(
          data: transactionAdapterResult.list,
          dataLoaded: true,
          displayMethod: DashboardDisplayMethods.stick,
          income: transactionAdapterResult.totalIncome,
          charges: transactionAdapterResult.totalCharges,
        ),
      );
    });
  }
}
