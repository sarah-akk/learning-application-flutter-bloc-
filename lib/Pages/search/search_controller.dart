import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/search/bloc/search_blocs.dart';
import 'package:learningapplication/Pages/search/bloc/search_events.dart';
import 'package:learningapplication/Pages/search/search.dart';
import 'package:learningapplication/common/apis/course_api.dart';
import 'package:learningapplication/common/entities/course.dart';

class MySearchController {
  late BuildContext context;

  MySearchController({required this.context});

  void init() {
    asyncLoadRecommendedData();
  }

  Future<void> asyncLoadRecommendedData() async {
    var result = await CourseApi.RecommendedCourseList();
    if (result.code == 200) {
      context.read<SearchBlocs>().add(TriggerSearchEvents(result.data!));
    }

  }

  Future<void> searchData(String item) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = item;
    var result = await CourseApi.search(params: searchRequestEntity);
    if (result.code == 200) {
      context.read<SearchBlocs>().add(TriggerSearchEvents(result.data!));
    }
  }

}