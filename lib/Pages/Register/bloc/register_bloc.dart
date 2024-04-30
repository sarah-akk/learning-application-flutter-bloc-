import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Register/bloc/register_events.dart';
import 'package:learningapplication/Pages/Register/bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterStates>{
  RegisterBloc():super( RegisterStates()){

    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_repasswordEvent);

  }

  //handlers
  void _userNameEvent(UserNameEvent event , Emitter<RegisterStates> emit){
    emit(state.copywith(userName: event.username));
  }

  void _emailEvent(EmailEvent event , Emitter<RegisterStates> emit){
    emit(state.copywith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event , Emitter<RegisterStates  > emit){
    emit(state.copywith(password: event.password));
  }

  void _repasswordEvent(RePasswordEvent event , Emitter<RegisterStates  > emit){
    emit(state.copywith(repassword: event.repassword));
  }
}