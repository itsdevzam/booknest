part of 'cat_bloc.dart';

abstract class CatStates {}

class CatInitial extends CatStates {}

class CatLoading extends CatStates {}

class CatError extends CatStates {
  final String errorMessage;
  CatError(this.errorMessage);
}

class CatLoaded extends CatStates {
  final List<CategoryModel> catModelList;
  CatLoaded(this.catModelList);
}
