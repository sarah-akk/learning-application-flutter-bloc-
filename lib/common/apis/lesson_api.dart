import 'package:learningapplication/common/entities/course.dart';
import 'package:learningapplication/common/entities/lesson.dart';
import 'package:learningapplication/common/utils/http_util.dart';

class LessonApi{

  static Future<LessonListResponseEntity>lessonList({LessonRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/lessonList',
      queryParameters: params?.toJson(),

    );
    return LessonListResponseEntity.fromJson(response);
  }

  ////////////////////////////////////////////////////////////////////////

  static Future<LessonDetailResponseEntity>lessonDetail({required LessonRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/lessonDetail',
      queryParameters: params?.toJson(),
    );
    print(response.toString());
    return LessonDetailResponseEntity.fromJson(response);
  }

///////////////////////////////////////////////////////////////////////


}