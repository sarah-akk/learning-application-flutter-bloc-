import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/common/routes/bloc_observer.dart';
import 'common/services/storage_service.dart';

class Global{
  static late StorageService storageservice;

   static Future init() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer =MyGlobalObserver();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: "AIzaSyA9OawlWtP4hbil9NmsbCfuZOEmDxd4Fsk",
    appId: "1:29548193195:android:5ebe06b2ed7b1a9bd25eee",
    messagingSenderId: "29548193195",
    projectId: "learningapp-84580",
  ),);
  storageservice= await StorageService().init();
}
}