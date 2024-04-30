import '../../../../common/entities/course.dart';

abstract class MyCoursesStates{
  const MyCoursesStates();
}
class InitialMyCoursestates extends MyCoursesStates {
  const InitialMyCoursestates() ;
}

class LoadingMyCourseStates extends MyCoursesStates{
  const LoadingMyCourseStates();
}

class DoneLoadingMyCourseStates extends MyCoursesStates{
  const DoneLoadingMyCourseStates();

}

class LoadedMyCourseStates extends MyCoursesStates{
  const LoadedMyCourseStates(this.courseItem);
  final List<CourseItem> courseItem;  

}
