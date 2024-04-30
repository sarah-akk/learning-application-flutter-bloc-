import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/Contributor/bloc/Contributor_Cubits.dart';
import 'package:learningapplication/common/apis/course_api.dart';
import 'package:learningapplication/common/entities/User.dart';
import 'package:learningapplication/common/entities/course.dart';
import 'package:learningapplication/common/routes/names.dart';
import 'package:learningapplication/common/values/constant.dart';
import '../../../common/entities/msg.dart';
import '../../../global.dart';

class ContributorController{
  late BuildContext context;
  ContributorController({required this.context});

  User? userProfile = Global.storageservice.getUserProfile();
  var db = FirebaseFirestore.instance;

  void init() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAuthorData(args['token']);
    asyncLoadAuthorCoursesData(args['token']);
  }

  //////////////////////////////////////////////////////////////////////

  Future<void> asyncLoadAuthorData(String token ) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseApi.courseAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<ContributorCubits>().TriggerContributorChange(
            result.data!);
        var res = context
            .read<ContributorCubits>()
            .state
            .authorItem;
        print(res);
      }
    }
  }

  //////////////////////////////////////////////////////////////////////

   Future<void> asyncLoadAuthorCoursesData(String token ) async {
     AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
     authorRequestEntity.token = token;
     var result = await CourseApi.courseListAuthor(authorRequestEntity);
     if(result.code==200){
       if(context.mounted){
         context.read<ContributorCubits>().TriggerCourseItemChange(result.data!);
       }
     }
  }

  ////////////////////////////////////////////////////////////////////

Future<void> GoChat(AuthorItem author) async {

    var fromMessages = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg , options) =>msg.toFirestore()
    ).where('from_token' , isEqualTo : Global.storageservice.getUserToken())
        .where("to_token",isEqualTo: author.token)
        .get();

    var toMessages = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg , options) =>msg.toFirestore()
    ).where('to_token' , isEqualTo : author.token)
        .where("from_token",isEqualTo: Global.storageservice.getUserToken())
        .get();

    if(fromMessages.docs.isEmpty && toMessages.docs.isEmpty){
      var msgData = Msg(
        from_token: Global.storageservice.getUserToken(),
        to_token: author.token,
        from_name:  userProfile!.name,
        to_name: author.name,
        from_avatar: userProfile!.photoURL,
        to_avatar: author.avatar,
        to_online: author.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      var docId = await db.collection("message").withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg , options) =>msg.toFirestore()
      ).add(msgData);

      Navigator.of(context).pushNamed(AppRoutes.Chat,
          arguments: {
            "doc-id" :docId.id,
            "to-token":author.token??"",
            "to-name":author.name??"",
            "to-avatar":author.avatar??"",
            "to-online":author.online.toString()
          });


    }
    else{
      if(fromMessages.docs.isNotEmpty){
        Navigator.of(context).pushNamed(AppRoutes.Chat,
        arguments: {
          "doc-id" :toMessages.docs.first.id,
          "to-token":author.token??"",
          "to-name":author.name??"",
          "to-avatar":author.avatar??"",
          "to-online":author.online.toString()
        });
      }
    }
}

}