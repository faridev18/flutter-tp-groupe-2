import 'dart:io';

import 'package:blog/models/billet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/dbBillet.dart';
import '../sharedUI/showSnackBar.dart';

class Ajout extends StatefulWidget {
  const Ajout({super.key});

  @override
  _AjoutState createState() {
    return _AjoutState();
  }
}

class _AjoutState extends State<Ajout> {
  final _formKey = GlobalKey<FormState>();
  String _titre = "";
  String _detailArticle = "";
  var _image;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter"),
        backgroundColor: const Color.fromRGBO(89, 107, 200, 0.7),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: TextButton(
                onPressed: () => onSubmit(context, user, _formKey, _image),
                child: const Text(
                  'Valider',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "New Article",
                textScaleFactor: 1.4,
                style: TextStyle(
                    color: Colors.indigo,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 5.0,
              shadowColor: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (_image == null)
                      ? Image.asset('images/acc.jpg')
                      : Image.file(File(_image!.toString())),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (() => getImage(ImageSource.camera)),
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.indigo,
                          )),
                      IconButton(
                          onPressed: (() => getImage(ImageSource.gallery)),
                          icon: const Icon(
                            Icons.photo_library,
                            color: Colors.indigo,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    XFile? nouvelleImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = nouvelleImage?.path;
    });
  }

  void onSubmit(context, user, keyForm, image) async {
    if (keyForm.currentState!.validate()) {
      if (image == null) {
        showNotification(context, "Insérez une image");
      } else {
        showNotification(context, "Chargement...");
        Navigator.of(context).pop();
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
    }
  }
}
