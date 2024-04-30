import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/Contributor/Contributor.dart';
import 'package:learningapplication/Pages/Course/Contributor/bloc/Contributor_Cubits.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lessonBlocs.dart';
import 'package:learningapplication/Pages/Course/Lesson/lesson_Detail.dart';
import 'package:learningapplication/Pages/Course/courseDetails/Course.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseBlocs.dart';
import 'package:learningapplication/Pages/Sign_in/sign_in.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatBlocs.dart';
import 'package:learningapplication/Pages/messages/chat/chat.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_blocs.dart';
import '../../../Pages/Home/bloc/home_page_blocs.dart';
import '../../../Pages/Home/home_page.dart';
import '../../../Pages/Register/bloc/register_bloc.dart';
import '../../../Pages/Register/register.dart';
import '../../../Pages/Sign_in/bloc/sign_in_blocs.dart';
import '../../../Pages/application/application_page.dart';
import '../../../Pages/application/bloc/app_blocs.dart';
import '../../../Pages/profile/setting/bloc/settings_blocs.dart';
import '../../../Pages/profile/setting/settings_page.dart';
import '../../../Pages/welcome/bloc/welcome_blocs.dart';
import '../../../Pages/welcome/welcome.dart';
import '../../../global.dart';
import '../../Pages/Course/courseDetails/bloc/course_detail_blocs.dart';
import '../../Pages/Course/my_course/my_course.dart';
import '../../Pages/Course/payWebView/Bloc/payview_blocs.dart';
import '../../Pages/Course/payWebView/payment_view.dart';
import '../../Pages/profile/profile_Page.dart';
import 'names.dart';

class AppPages {

  static List<PageEntity> routes() {
    return [
      PageEntity(
        page: const Welcome(),
        route: AppRoutes.INITIAL,
        bloc: BlocProvider(create: (_) => WelcomeBloc()),
      ),
      PageEntity(
        page: const SignIn(),
        route: AppRoutes.SignIn,
        bloc: BlocProvider(create: (_) => SignInBloc()),
      ),
      PageEntity(
        page: const Register(),
        route: AppRoutes.Register,
        bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        page: const ApplicationPage(),
        route: AppRoutes.APPLICATION,
        bloc: BlocProvider(create: (_) => AppBlocs()),
      ),
      PageEntity(
        page: const HomePage(),
        route: AppRoutes.Home_page,
        bloc: BlocProvider(create: (_) => HomePageBlocs()),
      ),
      PageEntity(
        page: const SettingsPage(),
        route: AppRoutes.Settings,
        bloc: BlocProvider(create: (_) => SettingsBlocs()),
      ),
      PageEntity(
        page: const ProfilePage(),
        route: AppRoutes.PROFILE,
        bloc: BlocProvider(create: (_) => ProfileBlocs()),
      ),
      PageEntity(
        page: const CourseDetail(),
        route: AppRoutes.Course_Detail,
        bloc: BlocProvider(create: (_) => CourseDetailBloc()),
      ),

      PageEntity(
        page: const PayWebView(),
        route: AppRoutes.Pay_Web_View,
        bloc: BlocProvider(create: (_) => PayWebViewBlocs()),
      ),

      PageEntity(
        page: const LessonDetail(),
        route: AppRoutes.LESSON_Detail,
        bloc: BlocProvider(create: (_) => LessonBlocs()),
      ),
      PageEntity(
        page: const MyCourse(),
        route: AppRoutes.MY_COURSES,
        bloc: BlocProvider(create: (_) => MyCoursesBlocs()),
      ),
      PageEntity(
        page: const Contributor(),
        route: AppRoutes.Contributor,
        bloc: BlocProvider(create: (_) => ContributorCubits()),
      ),
      PageEntity(
        page: const Chat(),
        route: AppRoutes.Chat,
        bloc: BlocProvider(create: (_) => ChatBlocs()),
      ),
    ];
  }


  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic>allBlocProviders = <dynamic>[];
    for (var bloc in routes()) {
      allBlocProviders.add(bloc.bloc);
    }
    return allBlocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
    print("result.first.route");

    if(settings.name!=null) {
      var result = routes().where((element) => element.route == settings.name);

      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageservice.getDeviceFirstOpen();
        print(deviceFirstOpen);

        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {

          bool isLoggedIn = Global.storageservice.getIsLoggedIn();
           if(isLoggedIn){
             return MaterialPageRoute(builder: (_) => const ApplicationPage(), settings: settings);
           }

          return MaterialPageRoute(builder: (_) => const SignIn(), settings: settings);
        }
        return MaterialPageRoute(builder: (_) =>result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const SignIn(), settings: settings);
  }
}


class PageEntity{
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.page,
    required this.route,
     this.bloc,

  });
}