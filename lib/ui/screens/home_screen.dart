import 'package:chat_with_solid/bloc/contact/contact_bloc.dart';
import 'package:chat_with_solid/data/models/contact_model.dart';
import 'package:chat_with_solid/ui/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(LoadContacts());
  }

  String _formatTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final formattedTime = DateFormat('HH:mm').format(dateTime);
      return formattedTime;
    } catch (e) {
      return 'Invalid time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Conversations",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
        List<ContactModel> filteredContacts = [];
        if (state is ContactLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ContactLoaded) {
          final contacts = state.contacts;
          final searchTerm = searchController.text.toLowerCase();
          filteredContacts = contacts.where((contact) {
            return contact.contactName.toLowerCase().contains(searchTerm) ||
                contact.contactLasName.toLowerCase().contains(searchTerm);
          }).toList();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey[100]!),
                  ),
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                itemExtent: 70,
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (ctx) {
                        return ChatScreen(contact: contact);
                      }));
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: NetworkImage(
                            contact.imageUrl.isEmpty
                                ? "https://www.footboom.net/img/upload/3/6be03-Foto-dnja.jpeg"
                                : contact.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      "${contact.contactName} ${contact.contactLasName}",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      overflow: TextOverflow.ellipsis,
                      contact.lastMessage.isNotEmpty
                          ? contact.lastMessage
                          : "No message",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          _formatTime(contact.lastMessageTime.toString()),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Gap(5),
                        const Icon(Icons.check),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
