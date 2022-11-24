//According to this event, load corresponding data
abstract class OperationsAction {
  final url;
  final action;

  OperationsAction({required this.url, this.action = Action.day});
}

class LoadOperationsAction extends OperationsAction {
  LoadOperationsAction({required String url}) : super(url: url);
}

enum Action {
  day,
  week,
  month,
  year,
}
