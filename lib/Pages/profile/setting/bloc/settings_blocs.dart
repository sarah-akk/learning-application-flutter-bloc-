import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/profile/setting/bloc/settings_events.dart';
import 'package:learningapplication/Pages/profile/setting/bloc/settings_states.dart';

class SettingsBlocs extends Bloc<SettingsEvents,SettingsStates>
{
  SettingsBlocs():super(SettingsStates()){
    on<TriggerSettings>(triggerSettings);
  }

  triggerSettings(SettingsEvents event ,Emitter<SettingsStates>emit){

    emit(SettingsStates());
  }
}