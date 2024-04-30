import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_states.dart';
import 'package:video_player/video_player.dart';
import '../../../common/entities/lesson.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_Widget.dart';
import 'Bloc/lessonBlocs.dart';
import 'Bloc/lesson_events.dart';
import 'lesson_controller.dart';

Widget videoPlayer( LessonStates state , LessonController lessonController) {
  return  state.lessonVideoItem.isEmpty?CircularProgressIndicator():Container(
    width: 325,
    height: 225,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: NetworkImage(
              state.lessonVideoItem[state.videoIndex].thumbnail!
          ),
          fit: BoxFit.fitWidth
      ),
    ),
    child: FutureBuilder(
      future: state.initializeVideoPlayerFuture,
      builder: (context,snapshote){
        if(snapshote.connectionState==ConnectionState.done){
          return lessonController.videoPlayerController==null?Container():
          AspectRatio(aspectRatio: lessonController.videoPlayerController!.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(lessonController.videoPlayerController!),
                VideoProgressIndicator(lessonController.videoPlayerController!, allowScrubbing:true,
                  colors: VideoProgressColors(playedColor: AppColors.primaryElement),
                )
              ],
            ),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}

///////////////////////////////////////////////////////////////////////////////

Widget videoControls(LessonStates state , LessonController lessonController , BuildContext context){
  return  Container(
    margin: EdgeInsets.only(top: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap:(){
            var videoIndex  = context.read<LessonBlocs>().state.videoIndex;

            videoIndex=videoIndex-1;
            if(videoIndex<0)
            {  videoIndex=0;
            context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
            return;
            }
            else{
              var videoItem=state.lessonVideoItem.elementAt(videoIndex);
              lessonController.playVideo(videoItem.url!);
            }
            context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
          },
          child:Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 15.w),
              child: Image.asset("assets/icons/rewind-left.png")) ,
        ),

        ////////////////////////////////////////////////////////////////

        GestureDetector(
          onTap: (){
            if(state.isPlay){
              lessonController.videoPlayerController?.pause();
              context.read<LessonBlocs>().add(TriggerPlay(false));
            }
            else{
              lessonController.videoPlayerController?.play();
              context.read<LessonBlocs>().add(TriggerPlay(true));

            }
          },
          child:state.isPlay?Container(
            width: 24, height: 24,
            child: Image.asset("assets/icons/pause.png"),

          ):Container(
            width: 24, height: 24,
            child: Image.asset("assets/icons/play-circle.png"),
          )
          ,),
        /////////////////////////////////////////////////////////////////////
        GestureDetector(
          onTap:(){

            var videoIndex  = context.read<LessonBlocs>().state.videoIndex;

            videoIndex=videoIndex+1;
            if(videoIndex>=state.lessonVideoItem.length)

            {
              context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
              videoIndex=videoIndex-1;
              return;
            }
            else{
              context.read<LessonBlocs>().add(TriggerVideoIndex(videoIndex));
              var videoItem=state.lessonVideoItem.elementAt(videoIndex);
              lessonController.playVideo(videoItem.url!);
            }
          },
          child:Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(left: 15.w),
              child: Image.asset("assets/icons/rewind-right.png")) ,
        ),
        /////////////////////////////////////////////////////////////////
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////////////////

SliverPadding videoList(LessonStates state , LessonController lessonController){
  return SliverPadding(
    padding: EdgeInsets.symmetric(
        vertical:18,horizontal: 25 ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
              (context,index){
            return buildLessonItems(context,index,state.lessonVideoItem[index],lessonController);
          },
          childCount: state.lessonVideoItem.length
      ),
    ),
  );
}


/////////////////////////////////////////////////////////////////////////

Widget buildLessonItems(BuildContext context , int index , LessonVideoItem item , LessonController lessonController){
  return Container(
    height: 80,
    width: 300,
    margin: EdgeInsets.only(
      bottom: 20,
    ),
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0,1),

          )
        ]
    ),
    child: InkWell(
      onTap: (){
        context.read<LessonBlocs>().add(TriggerVideoIndex(index));
        lessonController.playVideo(item.url!);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage("${item.thumbnail}")
                    )
                ),
              ),
              Container(
                margin:EdgeInsets.only(left: 10) ,
                width: 210,height: 60,
                alignment: Alignment.centerLeft,
                child: reusableText("${item.name}" ),
              )
            ],),
          Row(
            children: [
              Container(

                child: GestureDetector(

                    onTap: (){
                      context.read<LessonBlocs>().add(TriggerVideoIndex(index));
                      lessonController.playVideo(item.url!);
                    },
                    child: Image.asset(
                      width: 24.w,
                      height: 24.h,
                      "assets/icons/play-circle.png"
                    ),
                )
              )
            ],
          )
        ],
      ),
    ),
  );
}
