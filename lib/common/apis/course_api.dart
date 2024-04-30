import 'package:http/http.dart';
import 'package:learningapplication/common/entities/Base.dart';
import 'package:learningapplication/common/entities/course.dart';
import 'package:learningapplication/common/utils/http_util.dart';

class CourseApi{

  static Future<CourseListResponseEntity>courseList() async {
    var response = await HttpUtil().post(
        'api/courseList',
    );
    return CourseListResponseEntity.fromJson(response);
  }
  ////////////////////////////////////////////////////////////////////////
  static Future<CourseListResponseEntity>RecommendedCourseList() async {
    var response = await HttpUtil().post(
      'api/RecommendedCourseList',
    );
    return CourseListResponseEntity.fromJson(response);
  }
  ////////////////////////////////////////////////////////////////////////
  static Future<CourseListResponseEntity>search({SearchRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/searchCourseList',
      queryParameters: params?.toJson()
    );
    return CourseListResponseEntity.fromJson(response);
  }

  ////////////////////////////////////////////////////////////////////////

  static Future<CourseDetailResponseEntity>courseDetail({required CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/courseDetail',
      queryParameters: params?.toJson(),
    );
    print(response.toString());
    return CourseDetailResponseEntity.fromJson(response);
  }

///////////////////////////////////////////////////////////////////////

  static Future<BaseResponseEntity>coursePay({required CourseRequestEntity? params}) async {
   var response = await HttpUtil().post(
     'api/checkout',
    queryParameters: params?.toJson(),
    );
   return BaseResponseEntity.fromJson(response);
  }
  ////////////////////////////////////////////////////////////////////
  static Future<AuthorResponseEntity>courseAuthor(AuthorRequestEntity? params) async {
    var response = await HttpUtil().post(
      'api/courseAuthor',
      queryParameters: params?.toJson(),
    );
    return AuthorResponseEntity.fromJson(response);
  }
  //////////////////////////////////////////////////////////////////////////////////
  static Future<CourseListResponseEntity>courseListAuthor(AuthorRequestEntity? params) async {
    var response = await HttpUtil().post(
      'api/courseListAuthor',
      queryParameters: params?.toJson(),
    );
    return CourseListResponseEntity.fromJson(response);
  }
}