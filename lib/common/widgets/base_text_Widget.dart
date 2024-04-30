import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Pages/search/search_controller.dart';
import '../values/colors.dart';

Widget reusableText(String text,{Color color =AppColors.primaryText,int fontSize=16,FontWeight fontWeight = FontWeight.bold}){
  return  Container(
    child: Text(
      text,
      style:TextStyle(
        color : color,
        fontWeight:fontWeight,
        fontSize:fontSize.sp,
      ),
    ),
  );
}

Widget searchView(BuildContext context, String hintText , {bool home = true}) {
  TextEditingController searchController = TextEditingController();

  void submitSearch(String value) {
    if (value.isNotEmpty) {
      if(home==false)
         MySearchController(context:context).searchData(value);
    } else {
      print('Search text is empty');
    }
  }

  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 5.0, left: 20.0),
          width: 170.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Change color as needed
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.grey), // Change color as needed
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.0),
                width: 16.0,
                height: 16.0,
                child: Image.asset("assets/icons/search.png"),
              ),
              SizedBox(width: 10.0), // Adjust spacing as needed
              Expanded(
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                    hintText: hintText,
                    border: InputBorder.none, // Remove border
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: submitSearch,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 10.0), // Adjust spacing as needed
      GestureDetector(
        onTap: () {
          submitSearch(searchController.text);
        },
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent, // Change color as needed
            borderRadius: BorderRadius.circular(13.0),
            border: Border.all(color: Colors.deepPurpleAccent), // Change color as needed
          ),
          child: Icon(Icons.search, color: Colors.white), // Change icon as needed
        ),
      ),
    ],
  );
}


Widget appPrimaryButton(String name){
  return Container(
    padding: EdgeInsets.only(top: 13.h),
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      borderRadius: BorderRadius.circular(10.w),
      border: Border.all(color: AppColors.primaryElement),
    ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.primaryElementText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal
      ),
    ),
  );
}


