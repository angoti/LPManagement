import 'package:firebase_storage/firebase_storage.dart';

class ListImages {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> getImagesList() async {
    List<String> imageUrls = [];

    try {
      ListResult listResult = await _storage.ref().child('images/').listAll();
      List<Reference> imageRefs = listResult.items;

      for (var imageRef in imageRefs) {
        String imageUrl = await imageRef.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print('Erro ao obter a lista de imagens: $e');
    }

    return imageUrls;
  }
}
