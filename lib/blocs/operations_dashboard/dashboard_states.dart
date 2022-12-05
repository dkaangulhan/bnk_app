import 'package:banking_application/models/transaction_data_model.dart';

abstract class DashboardBlocState {
  final List<TransactionDataModel>? data;
  final displayMethod;
  final dataLoaded;
  final double? income;
  final double? charges;

  DashboardBlocState({
    this.data,
    this.displayMethod,
    this.dataLoaded,
    this.income,
    this.charges,
  });
}

class OperationState extends DashboardBlocState {
  OperationState({
    List<TransactionDataModel>? data,
    displayMethod,
    dataLoaded,
    income,
    charges,
  }) : super(
          data: data,
          displayMethod: displayMethod ?? DashboardDisplayMethods.stick,
          dataLoaded: dataLoaded ?? false,
          income: income,
          charges: charges,
        );
}

//This defines how UI will render the data. ie, it might be stick infographic
// or might be line chart
enum DashboardDisplayMethods {
  stick,
  line,
  pie,
}
