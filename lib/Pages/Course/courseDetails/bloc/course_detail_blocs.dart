import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_detail_events.dart';
import 'course_detail_states.dart';


class CourseDetailBloc extends Bloc<CourseDetailEvents,CourseDetailStates> {
  CourseDetailBloc() :super(const CourseDetailStates()) {
  on<TriggerCourseDetail>(triggerCourseDetail);
  on<TriggerLessonList>(triggerLessonList);
}

void triggerCourseDetail(TriggerCourseDetail event,Emitter<CourseDetailStates>emit){
    emit(state.copywith(courseItem: event.courseItem));
}

  void triggerLessonList(TriggerLessonList event,Emitter<CourseDetailStates>emit){
    emit(state.copywith(lessonItem: event.lessonItem));
  }
}