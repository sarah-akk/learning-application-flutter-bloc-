import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/bloc/course_events.dart';
import 'package:learningapplication/Pages/Course/bloc/course_states.dart';

class CourseBloc extends Bloc<CourseEvents,CourseStates> {
  CourseBloc() :super(const CourseStates()) {
  on<TriggerCourse>(triggerCourse);
}

void triggerCourse(TriggerCourse event,Emitter<CourseStates>emit){
    emit(state.copywith(courseItem: event.courseItem));
}
}