import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseEvents.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseStates.dart';

class MyCoursesBlocs extends Bloc<MyCoursesEvents,MyCoursesStates>{
  MyCoursesBlocs():super(InitialMyCoursestates()){
    on<InitialMyCourseEvents>(triggerInitialMyCourses);
    on<LoadedMyCourseEvents>(triggerLoadedCourses);
    on<LoadingMyCourseEvents>(triggerLoadingCourses);
    on<DoneLoadingMyCourseEvents>(triggerDoneLoadingCourses);
  }

  triggerInitialMyCourses(InitialMyCourseEvents event , Emitter<MyCoursesStates>emit){
    emit(InitialMyCoursestates());
  }

  triggerLoadedCourses(LoadedMyCourseEvents event , Emitter<MyCoursesStates>emit){
    emit(LoadedMyCourseStates(event.courseItem));
  }
  triggerLoadingCourses(LoadingMyCourseEvents event , Emitter<MyCoursesStates>emit){
    emit(LoadingMyCourseStates());
  }
  triggerDoneLoadingCourses(DoneLoadingMyCourseEvents event , Emitter<MyCoursesStates>emit){
    emit(DoneLoadingMyCourseStates());
  }
}