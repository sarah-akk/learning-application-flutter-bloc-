import 'package:learningapplication/common/entities/course.dart';

class CourseStates {
  const CourseStates({
    this.courseItem
});
  final CourseItem?courseItem;

  CourseStates copywith({CourseItem?courseItem}){
    return CourseStates(
      courseItem: courseItem??this.courseItem
    );
  }
}

