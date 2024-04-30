import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/payWebView/Bloc/payview_events.dart';
import 'package:learningapplication/Pages/Course/payWebView/Bloc/payview_states.dart';

class PayWebViewBlocs extends Bloc<PayWebViewEvent,PayWebViewStates>{
  PayWebViewBlocs():super(const PayWebViewStates()){
    on<TriggerWebView>(_triggerWebView);
  }

  void _triggerWebView(TriggerWebView event ,Emitter<PayWebViewStates> emit){
    emit(state.copyWith(url: event.url));
  }
}