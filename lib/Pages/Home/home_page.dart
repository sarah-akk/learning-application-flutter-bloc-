
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Home/home_controller.dart';
import 'package:learningapplication/Pages/Home/home_page_widgets.dart';
import 'package:learningapplication/common/routes/names.dart';

import '../../common/entities/User.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/base_text_Widget.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_states.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  
  late User userprofile;

  
  @override
  void initState(){
    super.initState();
  }


  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    userprofile = HomeController(context: context).userprofile!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        appBar:buildAppBar(userprofile!.photoURL.toString()),
        body:RefreshIndicator(
            onRefresh: () {
              return HomeController(context: context).init();
            },
            child :BlocBuilder<HomePageBlocs,HomePageStates>(
            builder:(context,state){
              if(state.courseItem.isEmpty)
              {
                HomeController(context: context).init();
              }
              return Container(
                  child:CustomScrollView
                    (
                      slivers:[
                        SliverToBoxAdapter(
                          child: homePageText("Hello",color:AppColors.primaryThreeElementText,top:20),
                        ),
                        SliverToBoxAdapter(
                          child:homePageText("${userprofile!.name}"),
                        ),
                        SliverPadding(
                          padding :EdgeInsets.only(top:20.h),
                        ),
                        SliverToBoxAdapter(
                           child:searchView(context,"search youre Course"),
                        ),
                        SliverToBoxAdapter(
                          child:SlideView(context,state),
                        ),
                        SliverToBoxAdapter(
                          child:menuView(),
                        ),
                        SliverPadding(
                            padding :EdgeInsets.symmetric(
                                vertical:18.h,
                                horizontal:0.w
                            ),
                            sliver:SliverGrid(
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 2,
                                mainAxisSpacing:15,
                                crossAxisSpacing:15,
                                childAspectRatio:1.6,

                              ), delegate: SliverChildBuilderDelegate(
                                childCount:state.courseItem.length,
                                    (BuildContext context,int index){
                                  return GestureDetector(
                                    onTap : (){
                                      Navigator.of(context).pushNamed(AppRoutes.Course_Detail,
                                          arguments:{
                                            "id":state.courseItem.elementAt(index).id,

                                          });
                                    },
                                    child: courseGrid(state.courseItem[index]),
                                  );
                                }
                            ),
                            )
                        ),
                      ]
                  )
              );
            }))
    );Container();
  }
}