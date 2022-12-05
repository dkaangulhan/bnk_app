import 'package:banking_application/models/card_data_model.dart';

//abstract adapter class which is responsible for being interface between incoming card data and CardDataModel
abstract class CardDataModelAdapter {
  //this transforms incoming card data to CardDataModel
  CardDataModel transform(Object data);
}

class BasicCardDataModelAdapter extends CardDataModelAdapter {
  @override
  CardDataModel transform(Object data) {
    return CardDataModel(
      id: 'xxxx',
      cardType: CardType.credit,
      provider: 'mastercard',
      owner: 'user1',
      assets: 1234.43,
    );
  }
}
