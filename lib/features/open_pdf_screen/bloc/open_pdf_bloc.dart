import 'package:flutter_bloc/flutter_bloc.dart';

part './open_pdf_events.dart';
part './open_pdf_states.dart';

class OpenPdfBloc extends Bloc<OpenPdfEvents, OpenPdfStates> {
  bool pageSnipping = true;
  bool isHorizontal = false;

  OpenPdfBloc() : super(OpenPdfInitialStates()) {
    on<OpenPdfPageSnipping>((event, emit) {
      pageSnipping = event.isSnipping;
      emit(OpenPdfPageSnippingState(pageSnipping));
    });
    on<OpenPdfPageHorizontal>((event, emit) {
      isHorizontal = event.isHorizontal;
      emit(OpenPdfPageHorizontalState(isHorizontal));
    });
  }
}
