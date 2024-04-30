import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatEvents.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatStates.dart';

class ChatBlocs extends Bloc<ChatEvents,ChatStates>{
  ChatBlocs():super(ChatStates()){
    on<TriggerMsgContentList>(triggerMsgContentList);
    on<TriggerAddMsgContent>(triggerAddMsgContent);
    on<TriggerClearMsgList>(triggerClearMsgList);
    on<TriggerAddMoreStatus>(triggerAddMoreStatus);
    on<TriggerLoadMsgData>(triggerLoadMsgData);
  }

  void triggerMsgContentList(TriggerMsgContentList event , Emitter<ChatStates>emit){
    var res = state.msgcontentList.toList();
    res.insert(0, event.msgcontentList);
    emit(state.copyWith(msgcontentList: res));
  }

  void triggerAddMsgContent(TriggerAddMsgContent event , Emitter<ChatStates>emit){
    var res = state.msgcontentList.toList();
    res.add(event.msgcontent);
    emit(state.copyWith(msgcontentList: res));
  }
  void triggerClearMsgList(TriggerClearMsgList event , Emitter<ChatStates>emit){
   emit(state.copyWith(msgcontentList: []));
  }
  void triggerAddMoreStatus(TriggerAddMoreStatus event , Emitter<ChatStates>emit){
    emit(state.copyWith(msgcontentList: []));
  }

  void triggerLoadMsgData(TriggerLoadMsgData event , Emitter<ChatStates>emit){
    emit(state.copyWith(is_loading: event.is_loading));
  }
}