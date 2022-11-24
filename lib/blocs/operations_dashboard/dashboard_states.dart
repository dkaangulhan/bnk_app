import 'package:banking_application/models/transaction_data_model.dart';

abstract class DashboardBlocState {
  final List<TransactionDataModel>? data;
  final displayMethod;
  final dataLoaded;

  DashboardBlocState({
    this.data,
    this.displayMethod,
    this.dataLoaded,
  });
}

class OperationState extends DashboardBlocState {
  OperationState({
    data,
    displayMethod,
    dataLoaded,
  }) : super(
          data: data,
          displayMethod: displayMethod ?? DashboardDisplayMethods.stick,
          dataLoaded: dataLoaded ?? false,
        );
}

//This defines how UI will render the data. ie, it might be stick infographic
// or might be line chart
enum DashboardDisplayMethods {
  stick,
  line,
  pie,
}
