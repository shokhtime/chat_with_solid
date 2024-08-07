import 'package:chat_with_solid/data/models/message_model.dart';

class MessageRepository {
  // Bu ro'yxat xabarlarni saqlash uchun ishlatiladi
  final List<MessageModel> _messages = [];

  // Kontakt bo'yicha xabarlarni olish uchun metod
  List<MessageModel> fetchMessagesForContact(int contactId) {
    return _messages
        .where((message) => message.contactId == contactId)
        .toList();
  }

  // Xabar yuborish metodini to'liq yozamiz
  void sendMessage(String messageText, int contactId) {
    // Yangi xabar uchun ID yaratamiz (ro'yxat uzunligi bo'yicha)
    final messageId = _messages.length + 1;

    final createdTime = DateTime.now().toIso8601String();

    // Yangi xabarni yaratamiz
    final newMessage = MessageModel(
      createdTime: createdTime,
      messageText: messageText,
      messageId: messageId,
      isFile: false, // Hozircha barcha xabarlar matnli deb olamiz
      contactId: contactId,
      status: false, // Xabar yuborilganligini belgilash uchun
    );

    // Yangi xabarni ro'yxatga qo'shamiz
    _messages.add(newMessage);

    // Xabar yuborilgani haqida xabarni konsolga chiqaramiz
    print('Xabar yuborildi kontakt $contactId: $messageText');
  }
}
