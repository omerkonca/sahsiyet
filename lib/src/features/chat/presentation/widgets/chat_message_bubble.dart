import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUser;
  final String? quoteText;
  final String? quoteSource;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isUser,
    this.quoteText,
    this.quoteSource,
  });

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI Avatar
          if(!isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCjpVBZfL-qKDggYBfg44XCJBpDvYCv2SJ0y6LjAP_wTuM0qLH1IDjerWIH5iM7XN4WdAGIjGIMhPL9NOxrSuXfrPHav1G0rqb33dp-_O9VZtVDCBdwl-81f-OkX-hEnuSUoYhsWk1e_8iuqqLrfDGz_c8XkAFeo_-PCmaeGMoXx63CrVgs-Bkaj4mI_rSCMKcbtGqyWyylB1PR91q6PqaIOfpQ2ZLvHug_Fwukml0OIMYBMvbbu4NITBZl-DPn6A_nlTqWwYGc6A'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    isUser ? 'Ben' : 'Şahsiyet Rehberi',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accentGold, // Using accent gold for muted text match
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 0), // Pointy corner for AI
                      bottomRight: Radius.circular(isUser ? 0 : 16), // Pointy corner for User
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: isUser ? AppColors.backgroundDark : Colors.grey[800],
                        ),
                      ),
                      if (quoteText != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.white.withOpacity(0.2) : AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                              left: BorderSide(
                                color: isUser ? Colors.white : AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"$quoteText"',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isUser ? Colors.white : Colors.grey[600],
                                ),
                              ),
                              if (quoteSource != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '($quoteSource)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isUser ? Colors.white : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),

           // User Avatar
          if(isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCixFCPip3psQq3RK4RFEZ_YydoaD-eu55RMPFPEDL3LPSdt22NGH6kax547M-Qg8aMtZch8_eyUDU8XXQlcA8zpgmRJnWZwltttNuYh2uTr8JXbw0phKYX6m_-fwxsfeQma1ODG9UwXfIDiicw0nluT8eqWhoMECBSJkx4rD41r4T04GwNuOr-cM5bWAjROWsx-ugHQQls3ZZPdj0WKhZZJFKUuE2-xlHhg0JS6WMNzsSAP0y3_VoMhxAtVfObgAl_XlZCY2CFUw'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                   )
                ]
              ),
            ),
          ],
        ],
      ),
    );
  }
}
