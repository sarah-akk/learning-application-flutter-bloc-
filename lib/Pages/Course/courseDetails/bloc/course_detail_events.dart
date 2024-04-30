import 'package:learningapplication/common/entities/course.dart';

import '../../../../common/entities/lesson.dart';

abstract class CourseDetailEvents{
  const   CourseDetailEvents();
}

class TriggerCourseDetail extends CourseDetailEvents{
  const TriggerCourseDetail(this.courseItem):super();
  final CourseItem courseItem;
}

class TriggerLessonList extends CourseDetailEvents{
  const TriggerLessonList(this.lessonItem):super();
  final List<LessonItem> lessonItem;
}