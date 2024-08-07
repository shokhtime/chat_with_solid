import 'package:chat_with_solid/data/models/message_model.dart';
import 'package:chat_with_solid/data/repositories/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc(this.messageRepository) : super(MessageInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  void _onLoadMessages(LoadMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      List<MessageModel> messages =
          messageRepository.fetchMessagesForContact(event.contactId);
      emit(MessageLoaded(messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<MessageState> emit) async {
    try {
      messageRepository.sendMessage(event.messageText, event.contactId);
      add(LoadMessages(event.contactId));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
