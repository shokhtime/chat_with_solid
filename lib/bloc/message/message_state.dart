part of 'message_bloc.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageModel> messages;

  MessageLoaded(this.messages);
}

class MessageError extends MessageState {
  final String message;

  MessageError(this.message);
}
