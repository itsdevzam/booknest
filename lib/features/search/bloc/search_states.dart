part of 'search_bloc.dart';

abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchEmpty extends SearchStates {}

class SearchLoaded extends SearchStates {
  final List<EbookModel> ebookModelList;
  SearchLoaded(this.ebookModelList);
}

class SearchError extends SearchStates {
  final String errorMessage;
  SearchError(this.errorMessage);
}
