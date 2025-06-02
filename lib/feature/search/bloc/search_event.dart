part of 'search_bloc.dart';

abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;
  PerformSearch(this.query);
}
