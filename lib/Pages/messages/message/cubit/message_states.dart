import '../../../../common/entities/message.dart';

class MessageState {
  const MessageState({ this.message = const<Message>[] , this.loadStatus = true});
  final List<Message> message;
  final bool loadStatus;

  MessageState copyWith({List<Message>?message , bool?loadStatus}){
    return MessageState(
        message: message??this.message,
      loadStatus: loadStatus??this.loadStatus
    );
  }

}