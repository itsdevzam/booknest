part of 'single_cat_bloc.dart';

abstract class SingleCatStates {}

class SingleCatInitial extends SingleCatStates {}

class SingleCatLoading extends SingleCatStates {}

class SingleCatError extends SingleCatStates {
  final String errorMessage;
  SingleCatError(this.errorMessage);
}

class SingleCatLoaded extends SingleCatStates {
  final List<EbookModel> ebookModelList;
  final bool isLoadMore;
  final int catId;
  final bool noMoreBooks;
  SingleCatLoaded({
    required this.ebookModelList,
    required this.isLoadMore,
    required this.catId,
    required this.noMoreBooks,
  });
}
