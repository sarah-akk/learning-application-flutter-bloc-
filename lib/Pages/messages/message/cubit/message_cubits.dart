import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/messages/message/cubit/message_states.dart';
import 'package:learningapplication/common/entities/message.dart';

class MessageCubits extends Cubit<MessageState>{
  MessageCubits():super(const MessageState());

  void loadStatusChanged (bool loadStatus){
    emit(state.copyWith(loadStatus: loadStatus));
  }
  void messageChanged (List<Message> message ){
    emit(state.copyWith(message: message));
  }

}