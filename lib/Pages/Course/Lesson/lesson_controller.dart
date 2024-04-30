import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lessonBlocs.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_events.dart';
import 'package:learningapplication/common/apis/lesson_api.dart';
import 'package:learningapplication/common/entities/lesson.dart';
import 'package:video_player/video_player.dart';

class LessonController {

  final BuildContext context;
  VideoPlayerController? videoPlayerController;

  LessonController({
    required this.context
});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    context.read<LessonBlocs>().add(TriggerPlay(false));
    asyncLoadLessonData(args['id']);
    }


    ////////////////////////////////////////////////////////////////////////////////

    Future<void> asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity =LessonRequestEntity();
    lessonRequestEntity.id=id;
    var result = await LessonApi.lessonDetail(params: lessonRequestEntity);
    if(result.code==200){
      if(context.mounted) {
        context.read<LessonBlocs>().add(TriggerLessonVideo(result.data!));
        print("ffffffffffffffffffffffffffffffff${result.data!.length}");
        if (result.data!.isNotEmpty) {
          var url = result.data!.elementAt(0).url;
          videoPlayerController = VideoPlayerController.network(url!);
          var initPlayer = videoPlayerController?.initialize();
          context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
        }
      }
    }
  }

  void playVideo(String url){
    if(videoPlayerController!=null)
      {
        videoPlayerController?.pause();
        videoPlayerController?.dispose();
      }
    videoPlayerController=VideoPlayerController.network(url);
    context.read<LessonBlocs>().add(TriggerPlay(false));
    context.read<LessonBlocs>().add(TriggerUrlItem(null));
    var initPlayer = videoPlayerController?.initialize().then((value) => {
      videoPlayerController?.seekTo(const Duration(microseconds: 0))
    });

    context.read<LessonBlocs>().add(TriggerUrlItem(initPlayer));
    context.read<LessonBlocs>().add(TriggerPlay(true));
    videoPlayerController?.play();

  }
}