import 'package:equatable/equatable.dart';
import 'package:learningapplication/common/entities/msgcontent.dart';

abstract class ChatEvents extends Equatable {
  const ChatEvents();
  @override
  List<Object>get props =>[];
}

class TriggerMsgContentList extends ChatEvents{
  final Msgcontent msgcontentList;
  const TriggerMsgContentList(this.msgcontentList);

  @override
  List<Object>get props =>[msgcontentList];

}

class TriggerAddMsgContent extends ChatEvents{
final Msgcontent msgcontent;
const TriggerAddMsgContent(this.msgcontent);

@override
List<Object>get props =>[msgcontent];

}

class TriggerAddMoreStatus extends ChatEvents{
const TriggerAddMoreStatus(this.moreStatus);
final bool moreStatus;

@override
List<Object>get props =>[moreStatus];

}

class TriggerClearMsgList extends ChatEvents{
  const TriggerClearMsgList();

  @override
  List<Object>get props =>[];

}


class TriggerLoadMsgData extends ChatEvents{
  const TriggerLoadMsgData(this.is_loading);
  final bool is_loading;

  @override
  List<Object>get props =>[is_loading];

}