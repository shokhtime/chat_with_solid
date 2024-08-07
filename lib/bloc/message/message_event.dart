part of 'message_bloc.dart';

abstract class MessageEvent {}

class LoadMessages extends MessageEvent {
  final int contactId;

  LoadMessages(this.contactId);
}

class SendMessage extends MessageEvent {
  final String messageText;
  final int contactId;

  SendMessage({
    required this.messageText,
    required this.contactId,
  });
}
