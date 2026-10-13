part of 'home_bloc.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeLoaded extends HomeStates {
  final List<EbookModel> ebookModelList;
  final bool isLoadMore;
  final bool noMoreBooks;
  HomeLoaded({
    required this.ebookModelList,
    required this.isLoadMore,
    required this.noMoreBooks,
  });
}

class HomeError extends HomeStates {
  final String error;
  HomeError(this.error);
}
