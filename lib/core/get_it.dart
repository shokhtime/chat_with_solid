import 'package:chat_with_solid/bloc/contact/contact_bloc.dart';
import 'package:chat_with_solid/bloc/message/message_bloc.dart';
import 'package:chat_with_solid/data/repositories/contact_repository.dart';
import 'package:chat_with_solid/data/repositories/message_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<ContactRepository>(ContactRepository());
  getIt.registerSingleton<MessageRepository>(MessageRepository());
  getIt.registerSingleton<ContactBloc>(ContactBloc(getIt<ContactRepository>()));
  getIt.registerSingleton<MessageBloc>(MessageBloc(getIt<MessageRepository>()));
}
