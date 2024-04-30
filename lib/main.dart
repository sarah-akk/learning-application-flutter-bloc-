import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Sign_in/sign_in.dart';
import 'package:learningapplication/Pages/welcome/welcome.dart';
import 'Pages/Register/register.dart';
import 'Pages/application/application_page.dart';
import 'common/routes/pages.dart';
import 'global.dart';


Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool deviceFirstOpen = Global.storageservice.getDeviceFirstOpen();

    return
      MultiBlocProvider(
    providers: [...AppPages.allBlocProviders(context)],
    child: ScreenUtilInit(
     // designSize:const Size(375,812),
      builder: (context,child ) =>
    MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
        )
      ),
      onGenerateRoute:AppPages.GenerateRouteSettings,
      initialRoute:"/",
    ),
    ),
    );
  }
}






