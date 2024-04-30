import 'package:learningapplication/common/entities/course.dart';
import 'package:learningapplication/common/entities/lesson.dart';

class CourseDetailStates {
  const CourseDetailStates({
    this.courseItem,
    this.lessonItem = const <LessonItem>[]
});
  final CourseItem?courseItem;
  final List<LessonItem> lessonItem;

  CourseDetailStates copywith({CourseItem?courseItem ,
  List <LessonItem>? lessonItem
  }){
    return CourseDetailStates(
      courseItem: courseItem??this.courseItem ,
      lessonItem : lessonItem??this.lessonItem
    );
  }
}

