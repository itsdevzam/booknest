import 'package:booknest/core/model/category_model.dart';
import 'package:booknest/repo/ebook_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cat_events.dart';
part 'cat_states.dart';

class CatBloc extends Bloc<CatEvents, CatStates> {
  final EbookRepo ebookRepo;
  CatBloc({required this.ebookRepo}) : super(CatInitial()) {
    on<LoadCatEvent>((event, emit) async {
      try {
        emit(CatLoading());
        List<CategoryModel> catModelList = await ebookRepo.allCatIdwithName();
        emit(CatLoaded(catModelList));
      } catch (e) {
        emit(CatError(e.toString()));
      }
    });
  }
}
