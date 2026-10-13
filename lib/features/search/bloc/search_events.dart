part of 'search_bloc.dart';

abstract class SearchEvents {}

class SearchEbook extends SearchEvents {
  final String searchText;
  SearchEbook({required this.searchText});
}
