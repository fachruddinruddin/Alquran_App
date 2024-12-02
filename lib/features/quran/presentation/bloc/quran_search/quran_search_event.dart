abstract class QuranSearchEvent {}

class QuranSearchQueryChanged extends QuranSearchEvent {
  final String query;

  QuranSearchQueryChanged(this.query);
}
