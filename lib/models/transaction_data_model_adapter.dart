import 'package:banking_application/constants.dart';
import 'package:banking_application/models/transaction_data_model.dart';

//Transform method of this class will be edited according to needs depending
// data coming from server.
abstract class TransactionAdapter {
  //optional input parameter is used for sending inputs specific to
  // implementations
  TransactionAdapterResult? transform(Object data, {Map? input});
}

class BasicTransactionAdapter extends TransactionAdapter {
  @override
  TransactionAdapterResult? transform(Object data, {Map? input}) {
    data as Map;
    input as Map;

    List<TransactionDataModel> list = [];

    dynamic correspondingTransaction;

    data.forEach((key, value) {
      if (value['owner'] == input['user'] &&
          value['cardId'] == input['cardId']) {
        correspondingTransaction = value['transactions'];
      }
    });
    //if correspondingTransaction is not null it will be a map containing maps

    if (correspondingTransaction == null) {
      return null;
    }

    double totalIncome = 0.0;
    double totalCharges = 0.0;

    (correspondingTransaction as Map).forEach((key, value) {
      list.add(TransactionDataModel.fromObject(data: value));

      if (value['from'] == input['user']) {
        totalCharges += value['total'] + 0.0;
      } else {
        totalIncome += value['total'] + 0.0;
      }
    });

    return TransactionAdapterResult(
      list: list,
      totalIncome: totalIncome,
      totalCharges: totalCharges,
    );
  }
}

//When emitting state on DashboardBloc instances of this class is used as
// result of TransactionAdapters and the state that will be emitted by the
// bloc gets its parameters from the instances of this class
class TransactionAdapterResult {
  List<TransactionDataModel>? list;
  double? totalIncome;
  double? totalCharges;

  TransactionAdapterResult({
    this.list,
    this.totalIncome,
    this.totalCharges,
  });
}
