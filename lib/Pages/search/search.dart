import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Sign_in/widgets/sign_in_widget.dart' as res;
import 'package:learningapplication/Pages/search/bloc/search_blocs.dart';
import 'package:learningapplication/Pages/search/search_controller.dart';
import 'package:learningapplication/Pages/search/search_widgets.dart';
import '../../common/widgets/base_text_Widget.dart';
import 'bloc/search_states.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late MySearchController searchController;

  @override
  void didChangeDependencies(){
    searchController=MySearchController(context:context);
    searchController.init();
    super.didChangeDependencies();

  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SearchBlocs,SearchStates>(builder: (context,state){
      return Scaffold(
        appBar: res.buildAppBar("Search"),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 2,vertical: 20),
              sliver: SliverToBoxAdapter(
                child: searchView(context , "Courses you might like" , home: false),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              sliver: SliverToBoxAdapter(
                child: state.courseItem == null
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  child: listSearch(state),
                ),
              ),
            ),
          ],
        ),
      );
    },
    );
  }
}
