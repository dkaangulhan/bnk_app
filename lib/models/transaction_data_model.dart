//This class will be used on operations panel of dashboard
class TransactionDataModel {
  final from;
  final to;
  final total; //money sent, either to or from

  TransactionDataModel(
      {required this.from, required this.to, required this.total});

  //This factory takes object from decoded JSON
  factory TransactionDataModel.fromObject({required Map data}) {
    return TransactionDataModel(
      from: data['from'],
      to: data['to'],
      total: data['total'],
    );
  }
}
