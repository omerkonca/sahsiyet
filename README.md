# 🌙 Şahsiyet

**Şahsiyet**, kişisel gelişim ve maneviyata odaklanan, İslami değerlerle harmanlanmış modern bir mobil uygulamadır. Flutter ile geliştirilmiştir ve kullanıcıların günlük görevlerini takip etmelerini, ibadetlerini organize etmelerini ve maneviyatlarını beslemelerini sağlar.

## ✨ Özellikler

### 🎯 Ana Özellikler
- **Günlük Görevler**: Kişiselleştirilebilir görev listesi ve ilerleme takibi
- **Namaz Vakitleri**: Konum bazlı gerçek zamanlı namaz vakti bildirimleri (Aladhan API)
- **Yapay Zeka Rehberi**: Gemini AI destekli İslami sohbet asistanı
- **Zengin Kütüphane**: 100+ dua, hadis ve tesbihat içeriği
- **İlerleme Takibi**: Detaylı istatistikler ve grafiklerle gelişiminizi görün
- **Gamification**: Rozet sistemi, seviye atlama ve deneyim puanları

### 🎨 Kullanıcı Deneyimi
- Modern ve minimal dark theme tasarımı
- Smooth animasyonlar ve geçişler
- Onboarding ekranları ile kolay başlangıç
- Türkçe yerelleştirme
- Offline çalışma desteği (local database)

## 🛠️ Teknoloji Stack'i

### Frontend
- **Flutter SDK**: ^3.6.0
- **Dart**: ^3.6.0

### State Management
- **Riverpod**: ^2.6.1 - Güçlü ve type-safe state management
- **Riverpod Generator**: Code generation ile boilerplate azaltma

### Database
- **SQLite**: Local data storage
- **Shared Preferences**: Basit key-value storage
- **Path Provider**: File system yönetimi

### API Entegrasyonları
- **Gemini AI** (Google Generative AI): Yapay zeka sohbet asistanı
- **Aladhan Prayer Times API**: Namaz vakitleri
- **Geolocator**: Konum bazlı servisler

### UI/UX Paketleri
- **Google Fonts**: Özel font desteği
- **Lucide Icons**: Modern ikon seti
- **FL Chart**: Grafikler ve istatistikler
- **Shimmer**: Loading efektleri
- **Lottie**: Animasyonlar
- **Smooth Page Indicator**: Onboarding göstergeleri

### Utilities
- **Hijri Calendar**: Hicri takvim desteği
- **Intl**: Tarih ve dil formatlama
- **UUID**: Benzersiz ID oluşturma
- **Dio & HTTP**: Network istekleri
- **Connectivity Plus**: İnternet bağlantı kontrolü

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK (>= 3.6.0)
- Dart SDK (>= 3.6.0)
- Android Studio / VS Code
- Android SDK / Xcode (platform bazlı)

### Adım 1: Repository'yi Klonlayın
```bash
git clone https://github.com/omerkonca/sahsiyet.git
cd sahsiyet
```

### Adım 2: Bağımlılıkları Yükleyin
```bash
flutter pub get
```

### Adım 3: Environment Variables
`.env` dosyası oluşturun ve gerekli API key'lerini ekleyin:

```env
# Gemini AI Configuration
GEMINI_API_KEY=your_gemini_api_key_here

# Aladhan Prayer Times API (No key needed)
# Documentation: https://aladhan.com/prayer-times-api
```

**Not**: `.env.example` dosyasını referans alabilirsiniz.

### Adım 4: Uygulamayı Çalıştırın
```bash
flutter run
```

## 📱 Platform Desteği

| Platform | Durum |
|----------|-------|
| Android  | ✅ Destekleniyor |
| iOS      | ✅ Destekleniyor |
| Web      | ⚠️ Kısıtlı destek |
| Windows  | 🔧 Beta |
| macOS    | 🔧 Beta |
| Linux    | 🔧 Beta |

## 🎯 API Key'leri Nasıl Alınır?

### Gemini AI API Key
1. [Google AI Studio](https://makersuite.google.com/app/apikey) adresine gidin
2. Google hesabınızla giriş yapın
3. "Get API Key" butonuna tıklayın
4. Oluşturulan key'i kopyalayıp `.env` dosyasına ekleyin

### Namaz Vakti API
Aladhan API key gerektirmez, ücretsizdir. Ancak uygulamanın konum izni alması gerekir.

## 📚 Proje Yapısı

```
lib/
├── src/
│   ├── common_widgets/        # Paylaşılan widget'lar
│   │   ├── animations/
│   │   └── custom_bottom_nav.dart
│   ├── core/                  # Core katmanı
│   │   ├── database/          # SQLite database
│   │   │   ├── database_service.dart
│   │   │   └── seed_data.dart
│   │   ├── services/          # Servisler
│   │   │   ├── gemini_service.dart
│   │   │   ├── prayer_times_service.dart
│   │   │   └── local_storage_service.dart
│   │   └── theme/             # Tema ve renkler
│   │       ├── app_theme.dart
│   │       └── app_colors.dart
│   ├── features/              # Feature-based architecture
│   │   ├── chat/             # AI sohbet özelliği
│   │   ├── dashboard/        # Ana ekran
│   │   ├── library/          # Kütüphane
│   │   ├── onboarding/       # İlk kullanım
│   │   ├── profile/          # Profil
│   │   ├── progress/         # İlerleme takibi
│   │   └── settings/         # Ayarlar
│   └── main_layout.dart      # Ana layout
└── main.dart                 # Giriş noktası
```

## 🎨 Ekran Görüntüleri

*(Buraya ekran görüntüleri eklenecek)*

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen aşağıdaki adımları izleyin:

1. Bu repository'yi fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

### Commit Mesajları
Conventional Commits standardını kullanıyoruz:
- `feat`: Yeni özellik
- `fix`: Bug düzeltmesi
- `docs`: Dokümantasyon
- `style`: Kod formatı
- `refactor`: Kod iyileştirmesi
- `test`: Test ekleme
- `chore`: Bakım işleri

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👨‍💻 Geliştirici

**Ömer Faruk Konca**
- GitHub: [@omerkonca](https://github.com/omerkonca)

## 🙏 Teşekkürler

- [Aladhan API](https://aladhan.com) - Namaz vakitleri için
- [Google Gemini](https://ai.google.dev/) - AI asistan için
- Flutter ve Dart topluluğu

## 📞 İletişim

Sorularınız veya önerileriniz için:
- GitHub Issues: [Issues](https://github.com/omerkonca/sahsiyet/issues)

---

**Not**: Bu uygulama aktif geliştirme aşamasındadır. Özellikler ve API'ler değişebilir.
