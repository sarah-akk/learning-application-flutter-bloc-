import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_events.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_states.dart';

class ProfileBlocs extends Bloc<ProfileEvents,ProfileStates>{
   ProfileBlocs():super( ProfileStates()){
    on<TriggerProfileName>(triggerProfileName);
  }

  triggerProfileName(TriggerProfileName event , Emitter<ProfileStates>emit){
     emit(state.copyWith(userProfile: event.userProfile));
  }
}