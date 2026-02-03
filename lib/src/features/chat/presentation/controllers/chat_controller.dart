import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/features/chat/domain/chat_message_model.dart';
import 'package:uuid/uuid.dart';

class ChatState {
  final List<ChatMessageModel> messages;
  final bool isTyping;

  ChatState({
    required this.messages,
    this.isTyping = false,
  });

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isTyping,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  ChatController() : super(ChatState(messages: [])) {
    // Initial welcome message
    _addMessage(
       ChatMessageModel(
        id: 'welcome',
        text: 'Selamunaleyküm! Ben Şahsiyet rehberin. Bugün senin için ne yapabilirim? Dertleşmek, bir soru sormak veya sadece sohbet etmek istersen buradayım.',
        isUser: false,
        timestamp: DateTime.now(), // const constructor sorunu olmaması için
      ),
    );
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    final userMsg = ChatMessageModel(
      id: const Uuid().v4(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _addMessage(userMsg);

    // 2. Simulate AI Typing
    state = state.copyWith(isTyping: true);

    // 3. Simulated Delay & Response
    Future.delayed(const Duration(milliseconds: 1500), () {
      state = state.copyWith(isTyping: false);
      
      final aiMsg = ChatMessageModel(
        id: const Uuid().v4(),
        text: _getMockResponse(text),
        isUser: false,
        timestamp: DateTime.now(),
      );
      _addMessage(aiMsg);
    });
  }

  void _addMessage(ChatMessageModel message) {
    state = state.copyWith(messages: [...state.messages, message]);
  }

  // Basit anahtar kelime tabanlı cevaplar
  String _getMockResponse(String input) {
    final lowerInput = input.toLowerCase();
    
    if (lowerInput.contains('selam') || lowerInput.contains('merhaba')) {
      return 'Aleykümselam güzel kardeşim. Günün hayr olsun.';
    }
    if (lowerInput.contains('nasılsın')) {
      return 'Elhamdülillah, seninle sohbet etmek beni her zaman mutlu eder. Sen nasılsın?';
    }
    if (lowerInput.contains('namaz')) {
      return 'Namaz, dinin direği ve müminin miracıdır. Namazla ilgili aklına takılan özel bir şey var mı?';
    }
    if (lowerInput.contains('üzgünüm') || lowerInput.contains('sıkıntı')) {
      return 'Allah sabredenlerle beraberdir (Bakara, 153). Her zorlukla beraber bir kolaylık vardır. Kalbini ferah tut, bu günler de geçer inşallah.';
    }
    if (lowerInput.contains('dua')) {
      return 'Senin için dua edeceğim. "Rabbimiz! Bize dünyada da iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru." (Bakara, 201)';
    }
    
    return 'Anlıyorum. Bu konuda sana daha fazla yardımcı olabilmem için biraz daha detay verir misin?';
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController();
});
