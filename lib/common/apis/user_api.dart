
import 'package:learningapplication/common/entities/User.dart';
import 'package:learningapplication/common/utils/http_util.dart';


class UserLogInApi{
  login({User? params}) async {
    var response = await HttpUtil().post(
      'api/login',
      // 'teacher/login',
        queryParameters:params?.toJson(),

    );
    print(response);
    return response;

  }
}

class UserRegisterApi{
  register({User? params}) async {
    var response = await HttpUtil().post(
      'api/register',
      queryParameters:params?.toJson(),
    );
    print(response);
    return response;
  }
}