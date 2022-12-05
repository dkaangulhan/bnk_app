abstract class CardsEvent {}

class CardAction extends CardsEvent {
  final user;
  final cardId;
  CardAction({this.user, this.cardId});
}
