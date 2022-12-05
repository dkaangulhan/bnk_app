//According to this event, load corresponding data
abstract class OperationsAction {
  final url;
  final action;
  final cardId;

  OperationsAction(
      {required this.url, this.action = Action.day, required this.cardId});
}

class LoadOperationsAction extends OperationsAction {
  LoadOperationsAction({required String url, required cardId})
      : super(
          url: url,
          cardId: cardId,
        );
}

enum Action {
  day,
  week,
  month,
  year,
}
