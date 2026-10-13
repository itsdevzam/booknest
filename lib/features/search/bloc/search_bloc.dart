import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/repo/ebook_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
part 'search_events.dart';
part 'search_states.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  final EbookRepo ebookRepo;
  SearchBloc({required this.ebookRepo}) : super(SearchInitial()) {
    on<SearchEbook>(
      (event, emit) async {
        try {
          emit(SearchLoading());
          List<EbookModel> ebookModelList = await ebookRepo.searchEbook(
            ebookName: event.searchText,
          );
          if (ebookModelList.isEmpty) {
            return emit(SearchEmpty());
          }
          emit(SearchLoaded(ebookModelList));
        } catch (e) {
          emit(SearchError(e.toString()));
        }
      },
      transformer: (events, mapper) {
        return restartable<SearchEbook>().call(
          events.debounceTime(const Duration(milliseconds: 400)),
          mapper,
        );
      },
    );
  }
}
