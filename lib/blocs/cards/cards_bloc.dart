import 'package:banking_application/blocs/cards/cards_bloc_events.dart';
import 'package:banking_application/blocs/cards/cards_bloc_states.dart';
import 'package:banking_application/models/card_data_model.dart';
import 'package:bloc/bloc.dart';

//This is dummy cards list which in real app will be fetched from server and
// transformed into CardDataModel using CardDataModelAdapter
final dummyCardList = [
  CardDataModel(
    id: '1234',
    cardType: CardType.credit,
    provider: 'MasterCard',
    owner: 'user1',
    assets: 1234.34,
  ),
  CardDataModel(
    id: '2345',
    cardType: CardType.credit,
    provider: 'Visa',
    owner: 'user1',
    assets: 14.34,
  ),
];

class CardsBloc extends Bloc<CardsEvent, CardsState?> {
  CardsBloc() : super(null) {
    on<CardAction>((event, emit) async {
      //Loading state
      emit(CardState(loaded: false));

      //extract account info
      CardDataModel? cardInfo;

      //When card list fetched from server, they will be transformed into
      // CardDataModels using CardDataModelAdapter and be pushed into
      // dummyCardList which will noy be dummy-list in the real app

      for (CardDataModel data in dummyCardList) {
        if (data.owner == event.user && data.id == event.cardId) {
          cardInfo = data;
        }
      }
      if (cardInfo == null) {
        emit(CardState(loaded: false));
        return;
      }

      emit(
        CardState(
          cardId: cardInfo.id,
          assets: cardInfo.assets,
          loaded: true,
        ),
      );
    });
  }
}
