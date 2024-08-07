import 'package:chat_with_solid/data/models/contact_model.dart';
import 'package:chat_with_solid/data/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
  }

  void _onLoadContacts(LoadContacts event, Emitter<ContactState> emit) {
    emit(ContactLoading());
    try {
      List<ContactModel> contacts = contactRepository.fetchContacts();
      emit(ContactLoaded(contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
