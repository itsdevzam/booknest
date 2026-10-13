import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/repo/ebook_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_events.dart';
part 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final EbookRepo ebookRepo;
  HomeBloc({required this.ebookRepo}) : super(HomeInitial()) {
    int currentPage = 0;
    List<EbookModel> ebooks = [];
    on<LoadHome>((event, emit) async {
      try {
        if (currentPage == 0) {
          emit(HomeLoading());
        } else {
          emit(
            HomeLoaded(
              ebookModelList: List.from(ebooks),
              isLoadMore: true,
              noMoreBooks: false,
            ),
          );
        }
        currentPage++;
        List<EbookModel> ebookModelList = await ebookRepo.fetchEbook(
          page: currentPage,
        );
        ebooks.addAll(ebookModelList);
        emit(
          HomeLoaded(
            ebookModelList: List.from(ebooks),
            isLoadMore: false,
            noMoreBooks: true,
          ),
        );
      } catch (e) {
        if (e.toString().contains('No more Ebooks Available')) {
          emit(
            HomeLoaded(
              ebookModelList: List.from(ebooks),
              isLoadMore: true,
              noMoreBooks: true,
            ),
          );
        } else {
          emit(HomeError(e.toString()));
        }
      }
    }, transformer: droppable());
  }
}
