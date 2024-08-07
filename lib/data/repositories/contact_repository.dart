import 'package:chat_with_solid/data/models/contact_model.dart';

class ContactRepository {
  List<ContactModel> fetchContacts() {
    return [
      ContactModel(
        contactId: 3,
        contactLasName: "Alisher",
        contactName: "Mirzayev",
        isOnline: true,
        imageUrl:
            "https://www.intervalloconsulting.com/wp-content/uploads/2017/02/pic7-1.jpg",
        lastOnlineTime: DateTime.now(),
        lastMessage: "Salom, qanday yordam bera olishim mumkin?",
        lastMessageTime: DateTime.now().subtract(
          const Duration(minutes: 5),
        ),
      ),
      ContactModel(
        contactId: 1,
        contactLasName: "Abror",
        contactName: "Isayev",
        isOnline: false,
        imageUrl:
            "https://i.pinimg.com/736x/1a/ce/6d/1ace6d72f6ca6018bcc7028527477ff0.jpg",
        lastOnlineTime: DateTime.now(),
        lastMessage: "Hali ham javob kutyapman.",
        lastMessageTime: DateTime.now().subtract(
          const Duration(hours: 1),
        ),
      ),
    ];
  }
}
