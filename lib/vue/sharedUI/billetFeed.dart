import 'dart:io';

import 'package:blog/models/billet.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/dbBillet.dart';

class BB {
  Billet? billet;
  BB({this.billet});

  void showBilletDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    String _titre = "";
    String _detailArticle = "";
    var _image;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Card(
                elevation: 2.0,
                shadowColor: Colors.blue,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.8)),
                    color: Colors.grey,
                  ),
                  child: (_image == null)
                      ? Image.network(
                          billet!.billetUrlImg!,
                          fit: BoxFit.cover,
                        )
                      : Image.file(File(_image!.toString())),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (() => getImage(ImageSource.camera, _image)),
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.indigo,
                      )),
                  IconButton(
                      onPressed: (() => getImage(ImageSource.gallery, _image)),
                      icon: const Icon(
                        Icons.photo_library,
                        color: Colors.indigo,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 200,
                        onChanged: (value) => _titre = value,
                        validator: (value) => _titre == ''
                            ? 'Veuillez saisir le titre de votre article'
                            : null,
                        decoration: const InputDecoration(
                          labelText: "Titre de l'article",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      TextFormField(
                        maxLines: 2,
                        onChanged: (value) => _detailArticle = value,
                        validator: (value) => _titre == ''
                            ? 'Veuillez saisir les details de votre article'
                            : null,
                        decoration: const InputDecoration(
                          labelText: "Détail de l'article ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          children: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'ANNULER',
                                  style: TextStyle(color: Colors.red),
                                )),
                            ElevatedButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {},
                                child: const Text('MODIFIER'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> getImage(ImageSource source, _image) async {
    XFile? nouvelleImage = await ImagePicker().pickImage(source: source);

    _image = nouvelleImage?.path;
  }

  /*void onSubmit(context, user, keyForm, image) async {
    if (keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      DataBaseServices db = DataBaseServices();
      String _carUrlImag = await db.uploadFile(File(image));
      db.addBillet(Billet(
        billetTitre: _titre,
        billetUrlImg: _carUrlImag,
        billetDetail: _detailArticle,
        billetUserID: user!.uid,
        billetUserName: user!.displayName,
      ));
    }
  }*/
}
