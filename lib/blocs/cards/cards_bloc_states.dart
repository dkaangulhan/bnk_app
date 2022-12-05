import 'package:banking_application/models/card_data_model.dart';

abstract class CardsState {
  final String? cardId;
  final double? assets;
  final bool loaded;

  CardsState({
    this.cardId,
    this.assets,
    required this.loaded,
  });
}

class CardState extends CardsState {
  CardState({cardId, assets, required bool loaded})
      : super(
          cardId: cardId,
          assets: assets,
          loaded: loaded,
        );
}
