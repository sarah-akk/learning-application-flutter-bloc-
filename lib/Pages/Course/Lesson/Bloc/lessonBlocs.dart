 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_events.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_states.dart';
import 'package:learningapplication/common/entities/lesson.dart';

class LessonBlocs extends Bloc<LessonEvents,LessonStates>
{
  LessonBlocs():super(const LessonStates()){
    on<TriggerLessonVideo>(triggerLessonVideo);
    on<TriggerUrlItem>(triggerUrlItem);
    on<TriggerPlay>(triggerPlay);
    on<TriggerVideoIndex>(triggerVideoIndex);
  }
  void triggerLessonVideo (TriggerLessonVideo event , Emitter<LessonStates> emit){
    emit(state.copyWith(lessonVideoItem:event.lessonVideoItem));
  }
  void triggerUrlItem (TriggerUrlItem event , Emitter<LessonStates> emit){
    emit(state.copyWith(initializeVideoPlayerFuture:event.initializeVideoPlayerFuture));
  }
  void triggerPlay (TriggerPlay event , Emitter<LessonStates> emit){
    emit(state.copyWith(isPlay:event.isPlay));
  }
  void triggerVideoIndex (TriggerVideoIndex event , Emitter<LessonStates> emit){
    emit(state.copyWith(videoIndex:event.videoIndex));
  }
}