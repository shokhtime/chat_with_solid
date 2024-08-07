import 'package:chat_with_solid/bloc/contact/contact_bloc.dart';
import 'package:chat_with_solid/bloc/message/message_bloc.dart';
import 'package:chat_with_solid/core/get_it.dart';
import 'package:chat_with_solid/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  setUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ContactBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<MessageBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
