import 'package:sahsiyet/src/core/database/database_service.dart';
import 'package:uuid/uuid.dart';

class SeedData {
  static const _uuid = Uuid();

  static Future<void> seedAll() async {
    await seedLibraryContent();
    await seedBadges();
  }

  static Future<void> seedLibraryContent() async {
    final existing = await DatabaseService.getAllLibraryContent();
    if (existing.isNotEmpty) return; // Already seeded

    final content = [
      // Dualar
      {
        'content_id': _uuid.v4(),
        'title': 'Sabah Akşam Duası',
        'content': 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\nاللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ',
        'category': 'Dualar',
        'transliteration': 'Bismillahirrahmanirrahim\nAllahumme ente rabbi la ilahe illa ente',
        'translation': 'Rahman ve Rahim Allah\'ın adıyla\nAllah\'ım! Sen benim Rabbimsin, Senden başka ilah yoktur',
        'reference': 'Buhari, Daavat 16',
        'tags': '["sabah", "akşam", "dua", "zikir"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Yemek Duası',
        'content': 'بِسْمِ اللَّهِ وَبَرَكَةِ اللَّهِ',
        'category': 'Dualar',
        'transliteration': 'Bismillahi ve berekâtillâh',
        'translation': 'Allah\'ın adıyla ve Allah\'ın bereketi ile',
        'reference': 'İbn Mâce, Et\'ime 7',
        'tags': '["yemek", "dua", "bereket"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Uyku Duası',
        'content': 'اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
        'category': 'Dualar',
        'transliteration': 'Allahumme bismike emûtu ve ahya',
        'translation': 'Allah\'ım! Senin adınla ölürüm ve diril irim',
        'reference': 'Buhari, Daavat 7',
        'tags': '["uyku", "gece", "dua"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Ayetel Kürsi',
        'content': 'اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
        'category': 'Dualar',
        'transliteration': 'Allahu la ilahe illa huve\'l hayyul kayyum',
        'translation': 'Allah, O\'ndan başka ilah yoktur. Diri ve Kayyumdur',
        'reference': 'Bakara Suresi, 255',
        'tags': '["ayetel", "kürsi", "koruma"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Çıkarken Dua',
        'content': 'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ',
        'category': 'Dualar',
        'transliteration': 'Bismillahi, tevekkeltü alallah',
        'translation': 'Allah\'ın adıyla, Allah\'a tevekkül ettim',
        'reference': 'Ebu Davud, Edeb 102',
        'tags': '["çıkmak", "yol", "dua"]',
        'created_at': DateTime.now().toIso8601String(),
      },

      // Hadisler
      {
        'content_id': _uuid.v4(),
        'title': 'İnsanların Hayırlısı',
        'content': 'İnsanların hayırlısı, insanlara faydalı olandır',
        'category': 'Hadisler',
        'reference': 'Dârimî, Mukaddime, 1',
        'tags': '["fazilet", "ahlak", "hayır"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Güzel Ahlak',
        'content': 'Mü\'minlerin imanı bakımından en mükemmeli, ahlakı en güzel olanıdır',
        'category': 'Hadisler',
        'reference': 'Tirmizi, Rada 11',
        'tags': '["ahlak", "güzellik", "iman"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Gülümsemek',
        'content': 'Kardeşine gülümsemen sadakadır',
        'category': 'Hadisler',
        'reference': 'Tirmizi, Birr 36',
        'tags': '["gülümsemek", "sadaka", "iyilik"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Sabır',
        'content': 'Sabır, ilk şoku karşılarken gösterilir',
        'category': 'Hadisler',
        'reference': 'Buhari, Cenaiz 32',
        'tags': '["sabır", "sıkıntı", "musibet"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'İlim Öğrenmek',
        'content': 'İlim öğrenmek her Müslüman\'a farzdır',
        'category': 'Hadisler',
        'reference': 'İbn Mâce, Mukaddime 17',
        'tags': '["ilim", "öğrenmek", "farz"]',
        'created_at': DateTime.now().toIso8601String(),
      },

      // Tesbihat
      {
        'content_id': _uuid.v4(),
        'title': 'Subhanallah',
        'content': 'سُبْحَانَ اللَّهِ',
        'category': 'Tesbihat',
        'transliteration': 'Subhanallah',
        'translation': 'Allah noksan sıfatlardan münezzehtir',
        'tags': '["tesbih", "zikir", "subhan"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Elhamdülillah',
        'content': 'الْحَمْدُ لِلَّهِ',
        'category': 'Tesbihat',
        'transliteration': 'Elhamdülillah',
        'translation': 'Hamd Allah\'a mahsustur',
        'tags': '["hamd", "şükür", "zikir"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Allahu Ekber',
        'content': 'اللَّهُ أَكْبَرُ',
        'category': 'Tesbihat',
        'transliteration': 'Allahu Ekber',
        'translation': 'Allah en büyüktür',
        'tags': '["tekbir", "zikir", "büyüklük"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'La ilahe illallah',
        'content': 'لَا إِلَهَ إِلَّا اللَّهُ',
        'category': 'Tesbihat',
        'transliteration': 'La ilahe illallah',
        'translation': 'Allah\'tan başka ilah yoktur',
        'tags': '["tevhid", "kelime", "şehadet"]',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'content_id': _uuid.v4(),
        'title': 'Estağfirullah',
        'content': 'أَسْتَغْفِرُ اللَّهَ',
        'category': 'Tesbihat',
        'transliteration': 'Estağfirullah',
        'translation': 'Allah\'tan bağışlanma dilerim',
        'tags': '["istiğfar", "bağışlanma", "tevbe"]',
        'created_at': DateTime.now().toIso8601String(),
      },
    ];

    for (final item in content) {
      await DatabaseService.insertLibraryContent(item);
    }

    print('✅ Kütüphane içeriği yüklendi: ${content.length} öğe');
  }

  static Future<void> seedBadges() async {
    final existing = await DatabaseService.getAllBadges();
    if (existing.isNotEmpty) return;

    final badges = [
      {
        'badge_id': 'first_task',
        'name': 'İlk Adım',
        'description': 'İlk görevini tamamladın',
        'icon_name': 'trophy',
        'category': 'tasks',
        'required_value': 1,
        'requirement_type': 'tasks_completed',
        'rarity': 'common',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'task_master_10',
        'name': 'Görev Ustası',
        'description': '10 görev tamamladın',
        'icon_name': 'award',
        'category': 'tasks',
        'required_value': 10,
        'requirement_type': 'tasks_completed',
        'rarity': 'rare',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'task_legend_50',
        'name': 'Görev Efsanesi',
        'description': '50 görev tamamladın',
        'icon_name': 'crown',
        'category': 'tasks',
        'required_value': 50,
        'requirement_type': 'tasks_completed',
        'rarity': 'epic',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'streak_7',
        'name': 'Haftalık Disiplin',
        'description': '7 gün üst üste aktif oldun',
        'icon_name': 'flame',
        'category': 'consistency',
        'required_value': 7,
        'requirement_type': 'streak_days',
        'rarity': 'rare',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'streak_30',
        'name': 'Aylık Kararlılık',
        'description': '30 gün üst üste aktif oldun',
        'icon_name': 'fire',
        'category': 'consistency',
        'required_value': 30,
        'requirement_type': 'streak_days',
        'rarity': 'epic',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'knowledge_seeker',
        'name': 'Bilgi Arayıcısı',
        'description': '25 içerik okudun',
        'icon_name': 'book_open',
        'category': 'knowledge',
        'required_value': 25,
        'requirement_type': 'content_viewed',
        'rarity': 'rare',
        'is_unlocked': 0,
      },
      {
        'badge_id': 'scholar',
        'name': 'Âlim',
        'description': '100 içerik okudun',
        'icon_name': 'graduation_cap',
        'category': 'knowledge',
        'required_value': 100,
        'requirement_type': 'content_viewed',
        'rarity': 'legendary',
        'is_unlocked': 0,
      },
    ];

    for (final badge in badges) {
      await DatabaseService.insertBadge(badge);
    }

    print('✅ Rozetler yüklendi: ${badges.length} rozet');
  }
}
