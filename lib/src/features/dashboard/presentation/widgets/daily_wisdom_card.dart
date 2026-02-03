import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class DailyWisdomCard extends StatelessWidget {
  const DailyWisdomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
           BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Overlay
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCAR5_hkWdRFbebRCPdlq8kwKuRPir5ss9e4LjEVlpFfCwTw9AP2OUlJydih7EJ4nBH2-qmXalnxV01Aukmv7B_jdaJtEmKJLjtT9KDoQnU2ig2X5Ub-jfGSEik-Yi978-g34seGRwbFBt5jaIBlHg6h6sWj_dgJOCEOu4IToostz3bOx82ZpahdUlmugGkqoHUDS5PyNgJcajvkbRhwWPmgO5Ie8sQtIFvt9E70Z5lTFYWZeU4gNx79qufGIUDG7936-LQrzD3Zg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: AppColors.backgroundDark),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundDark.withOpacity(0.0),
                  AppColors.backgroundDark.withOpacity(0.6),
                  AppColors.backgroundDark.withOpacity(0.95),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Text(
                    'Günün Ayeti',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Quote Icon
                Text(
                  '“',
                  style: TextStyle(
                    fontSize: 64,
                    color: AppColors.primary.withOpacity(0.4),
                    height: 0.1,
                    fontFamily: 'Serif',
                  ),
                ),
                
                // Quote Text
                const Text(
                  'Muhakkak ki zorlukla beraber bir kolaylık vardır.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Divider
                Container(
                  height: 4,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Author/Source
                const Text(
                  'İnşirah Suresi (94:6)',
                  style: TextStyle(
                    color: AppColors.accentGold,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.messageCircle, size: 18),
                        label: const Text('AI ile Tefekkür Et'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.backgroundDark,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _IconButton(icon: LucideIcons.share2),
                    const SizedBox(width: 12),
                    _IconButton(icon: LucideIcons.heart),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;

  const _IconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white, size: 20),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
