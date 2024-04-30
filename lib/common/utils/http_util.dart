import 'package:dio/dio.dart';
import 'package:learningapplication/global.dart';

import '../values/constant.dart';

class HttpUtil{

  static HttpUtil instance = HttpUtil._internal();

  factory HttpUtil(){
    return instance;
  }

  late Dio dio;

  HttpUtil._internal(){
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {

      },
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  /////////////////////////////////////////////////////////////////////////

  Future post(
       String path,
      {Options?options,
      dynamic data,
      Map<String, dynamic>? queryParameters}
       )
  async{

    Options requestOptions =options?? Options();
    requestOptions.headers=requestOptions.headers??{};
    Map<String,dynamic>? authorizationHeader = getAuthorizationHeader();
    if(authorizationHeader!=null)
      {
        requestOptions.headers!.addAll(authorizationHeader);
      }

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions
    );
    print(response.data);
    return response.data;
  }

///////////////////////////////////////////////////////////////////////

  Map<String,dynamic>   getAuthorizationHeader(){

    var headers = <String,dynamic>{};
    var accessToken = Global.storageservice.getUserToken();
    if(accessToken.isNotEmpty){
        headers['Authorization']='Bearer $accessToken';
    }
      return headers;
  }
}