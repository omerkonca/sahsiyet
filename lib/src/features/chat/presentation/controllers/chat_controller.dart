import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/core/database/database_service.dart';
import 'package:sahsiyet/src/core/services/gemini_service.dart';
import 'package:sahsiyet/src/features/chat/domain/chat_message_model.dart';
import 'package:uuid/uuid.dart';

class ChatState {
  final List<ChatMessageModel> messages;
  final bool isTyping;
  final bool isLoading;

  ChatState({
    required this.messages,
    this.isTyping = false,
    this.isLoading = false,
  });

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isTyping,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  ChatController() : super(ChatState(messages: [], isLoading: true)) {
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      final history = await DatabaseService.getAllChatHistory();
      
      if (history.isEmpty) {
        // Add welcome message
        final welcomeMsg = ChatMessageModel(
          id: 'welcome',
          text: 'Selamunaleyküm! Ben Şahsiyet rehberin. Bugün senin için ne yapabilirim? Dertleşmek, bir soru sormak veya sadece sohbet etmek istersen buradayım.',
          isUser: false,
          timestamp: DateTime.now(),
        );
        
        await DatabaseService.insertChatMessage({
          'message_id': welcomeMsg.id,
          'text': welcomeMsg.text,
          'is_user': 0,
          'timestamp': welcomeMsg.timestamp.toIso8601String(),
        });
        
        state = state.copyWith(messages: [welcomeMsg], isLoading: false);
      } else {
        final messages = history.map((msg) => ChatMessageModel(
          id: msg['message_id'],
          text: msg['text'],
          isUser: msg['is_user'] == 1,
          timestamp: DateTime.parse(msg['timestamp']),
        )).toList();
        
        state = state.copyWith(messages: messages, isLoading: false);
      }
    } catch (e) {
      print('Error loading chat history: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    final userMsg = ChatMessageModel(
      id: const Uuid().v4(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _addMessage(userMsg);
    
    // Save to database
    await DatabaseService.insertChatMessage({
      'message_id': userMsg.id,
      'text': userMsg.text,
      'is_user': 1,
      'timestamp': userMsg.timestamp.toIso8601String(),
    });

    // 2. Show AI typing
    state = state.copyWith(isTyping: true);

    try {
      // 3. Get AI Response
      final response = await GeminiService.getChatResponse(text);
      
      state = state.copyWith(isTyping: false);
      
      final aiMsg = ChatMessageModel(
        id: const Uuid().v4(),
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _addMessage(aiMsg);
      
      // Save to database
      await DatabaseService.insertChatMessage({
        'message_id': aiMsg.id,
        'text': aiMsg.text,
        'is_user': 0,
        'timestamp': aiMsg.timestamp.toIso8601String(),
      });
    } catch (e) {
      state = state.copyWith(isTyping: false);
      print('Error getting AI response: $e');
    }
  }

  void _addMessage(ChatMessageModel message) {
    state = state.copyWith(messages: [...state.messages, message]);
  }

  Future<void> clearHistory() async {
    await DatabaseService.clearChatHistory();
    state = ChatState(messages: []);
    
    // Add welcome message again
    final welcomeMsg = ChatMessageModel(
      id: 'welcome',
      text: 'Selamunaleyküm! Ben Şahsiyet rehberin. Bugün senin için ne yapabilirim?',
      isUser: false,
      timestamp: DateTime.now(),
    );
    _addMessage(welcomeMsg);
    
    await DatabaseService.insertChatMessage({
      'message_id': welcomeMsg.id,
      'text': welcomeMsg.text,
      'is_user': 0,
      'timestamp': welcomeMsg.timestamp.toIso8601String(),
    });
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController();
});
