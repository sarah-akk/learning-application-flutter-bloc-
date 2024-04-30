import '../../../../common/entities/course.dart';

abstract class MyCoursesEvents{
  const MyCoursesEvents();
}

class InitialMyCourseEvents extends MyCoursesEvents{
  const InitialMyCourseEvents();

}

class LoadingMyCourseEvents extends MyCoursesEvents{
  const LoadingMyCourseEvents();

}

class DoneLoadingMyCourseEvents extends MyCoursesEvents{
  const DoneLoadingMyCourseEvents();

}

class LoadedMyCourseEvents extends MyCoursesEvents{
  const LoadedMyCourseEvents(this.courseItem);
  final List<CourseItem> courseItem;

}
