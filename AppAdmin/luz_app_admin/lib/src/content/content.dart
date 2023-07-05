import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:luz_app_admin/src/content/upload_image.dart';

import 'list_images.dart';

class Content extends StatefulWidget {
  static const routeName = '/Content';

  const Content({super.key});
  @override
  _ContentState createState() => _ContentState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _ContentState extends State<Content> {
  final ListImages listImages = ListImages();
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() {
      isLoading = true;
    });

    List<String> urls = await listImages.getImagesList();

    setState(() {
      imageUrls = urls;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gerenciar Conteúdo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.file_upload_outlined),
              onPressed: () {
                Navigator.restorablePushNamed(context, UploadImage.routeName);
              },
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showImagePopup(context, imageUrls[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(imageUrls[index]),
                        title: Text('Imagem $index'),
                      ),
                    ),
                  );
                },
              ));
  }

  void _showImagePopup(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Image.network(imageUrl),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, imageUrl);
                  },
                  child: const Text('Excluir'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Tem certeza de que deseja excluir esta imagem?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteImage(imageUrl);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteImage(String imageUrl) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.refFromURL(imageUrl);
      await reference.delete();
      print('Imagem excluída com sucesso');
      _loadImages(); // Atualiza a lista de imagens após excluir uma imagem
    } catch (e) {
      print('Erro ao excluir a imagem: $e');
    }
  }
}
