import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static GenerativeModel? _model;

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    
    if (apiKey == null || apiKey.isEmpty || apiKey == 'your_gemini_api_key_here') {
      print('⚠️ GEMINI_API_KEY bulunamadı veya geçersiz. Mock modda çalışılıyor.');
      return;
    }

    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
    );
  }

  static Future<String> getChatResponse(String userMessage) async {
    if (_model == null) {
      // Mock mode - return predefined responses
      return _getMockResponse(userMessage);
    }

    try {
      final systemPrompt = '''
Sen "Şahsiyet" isimli İslami bir kişisel gelişim uygulamasının yapay zeka asistanısın.
Adın Şahsiyet Rehberi. Kullanıcılara dini konularda, kişisel gelişimde ve maneviyatta yardımcı oluyorsun.

Özellikler:
- Samimi, sıcak ve anlayışlı bir dille konuşursun
- İslami değerlere saygılı ve bilgilendiricisisin
- Kullanıcıları motive eder, pozitif tutar ve yüreklendirirsin
- Dua, ayet ve hadis önerileri sunarsın
- Kısa ve öz cevaplar verirsin (2-3 cümle ideal)
- Türkçe konuşursun ve "sen" diye hitap edersin

Cevap verirken:
- Selamlaşmalarda "Aleykümselam" veya "Selamün aleyküm" kullan
- Dualar için Türkçe meal ver
- Kaynak belirtirken kısa ol: (Bakara, 155) gibi
- Çok uzun yazmaktan kaçın
''';

      final content = [Content.text('$systemPrompt\n\nKullanıcı: $userMessage')];
      final response = await _model!.generateContent(content);
      
      return response.text ?? 'Üzgünüm, şu anda cevap veremiyorum.';
    } catch (e) {
      print('Gemini API Error: $e');
      return _getMockResponse(userMessage);
    }
  }

  static String _getMockResponse(String input) {
    final lowerInput = input.toLowerCase();
    
    if (lowerInput.contains('selam') || lowerInput.contains('merhaba')) {
      return 'Aleykümselam güzel kardeşim! Sana nasıl yardımcı olabilirim?';
    }
    if (lowerInput.contains('nasılsın')) {
      return 'Elhamdülillah, senin için buradayım. Sen nasılsın?';
    }
    if (lowerInput.contains('namaz')) {
      return 'Namaz, dinin direğidir ve müminin miracıdır. Namazla ilgili spesifik bir sorun var mı?';
    }
    if (lowerInput.contains('üzgün') || lowerInput.contains('sıkıntı') || lowerInput.contains('zor')) {
      return 'Allah sabredenlerle beraberdir. Her zorlukla beraber bir kolaylık vardır. (İnşirah, 5-6) Bu günler de geçecek inşallah.';
    }
    if (lowerInput.contains('dua')) {
      return 'Rabbena atina fid-dunya haseneten ve fil-ahirati haseneten ve kına azaben-nar.\n\n"Rabbimiz! Bize dünyada da iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru." (Bakara, 201)';
    }
    if (lowerInput.contains('teşekkür') || lowerInput.contains('sağol')) {
      return 'Rica ederim! Her zaman buradayım. Başka bir konuda yardımcı olabilir miyim?';
    }
    
    return 'Anlıyorum. Bu konuda daha fazla yardımcı olabilmem için biraz daha detay verir misin?';
  }

  static bool get isApiKeyConfigured {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    return apiKey != null && apiKey.isNotEmpty && apiKey != 'your_gemini_api_key_here';
  }
}
