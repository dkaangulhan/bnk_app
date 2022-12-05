class CardDataModel {
  final String id;
  final CardType cardType;
  final String provider; //visa, mastercard..
  final String owner;
  final double assets;

  CardDataModel({
    required this.id,
    required this.cardType,
    required this.provider,
    required this.owner,
    required this.assets,
  });
}

enum CardType {
  debit,
  credit,
}
