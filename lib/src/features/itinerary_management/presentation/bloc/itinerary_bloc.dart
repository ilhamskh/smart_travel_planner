import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'itinerary_event.dart';
part 'itinerary_state.dart';
part 'itinerary_bloc.freezed.dart';

class ItineraryBloc extends Bloc<ItineraryEvent, ItineraryState> {
  ItineraryBloc() : super(_Initial()) {
    on<ItineraryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
