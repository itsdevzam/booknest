import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/repo/ebook_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'single_cat_events.dart';
part 'single_cat_states.dart';

class SingleCatBloc extends Bloc<SingleCatEvents, SingleCatStates> {
  final EbookRepo ebookRepo;
  SingleCatBloc({required this.ebookRepo}) : super(SingleCatInitial()) {
    int currentPage = 0;
    List<EbookModel> ebooks = [];
    int catId = 0;
    on<LoadCatPost>((event, emit) async {
      try {
        if (event.catId != catId) {
          ebooks.clear();
          catId = event.catId;
          currentPage = 0;
        }

        if (currentPage == 0) {
          emit(SingleCatLoading());
        } else {
          emit(
            SingleCatLoaded(
              ebookModelList: List.from(ebooks),
              isLoadMore: true,
              noMoreBooks: false,
              catId: catId,
            ),
          );
        }
        currentPage++;
        List<EbookModel> ebookModelList = await ebookRepo.singleCatAllPosts(
          catId: event.catId,
          page: currentPage,
        );
        ebooks.addAll(ebookModelList);
        emit(
          SingleCatLoaded(
            ebookModelList: List.from(ebooks),
            isLoadMore: false,
            catId: catId,
            noMoreBooks: false,
          ),
        );
      } catch (e) {
        if (e.toString().contains('No more Ebooks Available')) {
          emit(
            SingleCatLoaded(
              ebookModelList: List.from(ebooks),
              isLoadMore: false,
              noMoreBooks: true,
              catId: catId,
            ),
          );
        } else {
          emit(SingleCatError(e.toString()));
        }
      }
    }, transformer: droppable());
  }
}
