import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/chat/presentation/controllers/chat_controller.dart';
import 'package:sahsiyet/src/features/chat/presentation/widgets/chat_message_bubble.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);
    final textController = TextEditingController();
    final scrollController = ScrollController();

    // Auto-scroll to bottom when messages change
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
         if (scrollController.position.hasContentDimensions) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
         }
      }
    });

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'Şahsiyet Rehberi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              'Yapay Zeka Destekli',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white54,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.moreVertical, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: chatState.messages.length + (chatState.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < chatState.messages.length) {
                  final msg = chatState.messages[index];
                  return ChatMessageBubble(
                    message: msg.text,
                    time: DateFormat('HH:mm').format(msg.timestamp),
                    isUser: msg.isUser,
                  );
                } else {
                  // Typing Indicator
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16, left: 16),
                    child: Text(
                      'Yazıyor...',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 116), // Bottom nav space
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: TextField(
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Bir şeyler yaz...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      onSubmitted: (value) {
                         if (value.isNotEmpty) {
                            controller.sendMessage(value);
                            textController.clear();
                         }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    if (textController.text.isNotEmpty) {
                      controller.sendMessage(textController.text);
                      textController.clear();
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(LucideIcons.send, color: AppColors.backgroundDark, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
