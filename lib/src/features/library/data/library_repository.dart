import 'package:sahsiyet/src/features/library/domain/library_item_model.dart';

class LibraryRepository {
  List<LibraryItemModel> getLibraryItems() {
    return const [
      // Dualar
      LibraryItemModel(
        id: '1',
        category: 'Dualar',
        title: 'Sabah Duası',
        content: 'Allahım! Senin kudretinle sabaha çıktık, senin kudretinle akşama gireriz. Senin kudretinle yaşar, senin kudretinle ölürüz. Dönüş sanadır.',
        isFavorite: true,
      ),
      LibraryItemModel(
        id: '2',
        category: 'Dualar',
        title: 'Rızık Duası',
        content: 'Ey Allahım! Bize helalinden, hoş ve bol rızık ver. Bizi harama düşürme. Lütfunla bizi başkalarına muhtaç etme.',
        isFavorite: false,
      ),
      LibraryItemModel(
        id: '3',
        category: 'Dualar',
        title: 'Şifa Duası',
        content: 'Allahım! İnsanların Rabbi! Sıkıntıyı gider, şifa ver. Şifayı veren ancak sensin. Senin vereceğin şifadan başka şifa yoktur. Öyle bir şifa ver ki, arkasında hiç hastalık izi bırakmasın.',
        isFavorite: false,
      ),
       LibraryItemModel(
        id: '4',
        category: 'Dualar',
        title: 'Yolculuk Duası',
        content: 'Bunu bizim hizmetimize veren Allah’ı tesbih ve takdis ederiz; yoksa biz buna güç yetiremezdik. Biz şüphesiz Rabbimize döneceğiz.',
        isFavorite: false,
      ),

      // Hadisler
      LibraryItemModel(
        id: '5',
        category: 'Hadisler',
        title: 'Niyet Hadisi',
        content: 'Ameller niyetlere göredir. Herkes için ancak niyet ettiği şey vardır.',
        isFavorite: true,
      ),
      LibraryItemModel(
        id: '6',
        category: 'Hadisler',
        title: 'Güzel Ahlak',
        content: 'Müminlerin iman bakımından en mükemmeli, ahlakı en güzel olanıdır.',
        isFavorite: true,
      ),
      LibraryItemModel(
        id: '7',
        category: 'Hadisler',
        title: 'Kolaylaştırınız',
        content: 'Kolaylaştırınız, zorlaştırmayınız; müjdeleyiniz, nefret ettirmeyiniz.',
        isFavorite: false,
      ),
      
      // Tesbihat
      LibraryItemModel(
        id: '8',
        category: 'Tesbihat',
        title: 'Subhanallah',
        content: 'Allah noksan sıfatlardan münezzehtir.',
        isFavorite: false,
      ),
       LibraryItemModel(
        id: '9',
        category: 'Tesbihat',
        title: 'Elhamdulillah',
        content: 'Hamd (övmek ve övülmek) Allah\'a mahsustur.',
        isFavorite: false,
      ),
    ];
  }
}
