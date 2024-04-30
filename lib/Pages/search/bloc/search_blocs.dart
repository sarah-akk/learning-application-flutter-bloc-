import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/search/bloc/search_events.dart';
import 'package:learningapplication/Pages/search/bloc/search_states.dart';

class SearchBlocs extends Bloc<SearchEvents,SearchStates>{
  SearchBlocs():super(SearchStates()){
    on<TriggerSearchEvents>(triggerSearchEvents);
  }
  triggerSearchEvents(TriggerSearchEvents event , Emitter<SearchStates> emit){
    emit(state.copyWith(courseItem: event.courseItem));
  }
}