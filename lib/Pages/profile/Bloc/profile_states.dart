import 'package:learningapplication/common/entities/User.dart';

class ProfileStates{
   final User? userProfile;
   const ProfileStates({this.userProfile});


   ProfileStates copyWith({User? userProfile}){
     return ProfileStates(userProfile: userProfile??this.userProfile);
   }
}