import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/Contributor/bloc/Contributor_states.dart';
import 'package:learningapplication/common/entities/course.dart';

class ContributorCubits extends Cubit<ContributorStates>{
  ContributorCubits(): super( const ContributorStates()) ;
  TriggerContributorChange(AuthorItem event){
    emit(state.copyWith(authorItem: event));
  }
  TriggerCourseItemChange(List<CourseItem> event){
    emit(state.copyWith(courseItem: event));
  }
}