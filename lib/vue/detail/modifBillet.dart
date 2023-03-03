import 'dart:io';

import 'package:blog/models/billet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/dbBillet.dart';
import '../sharedUI/showSnackBar.dart';

class ModifierBillet extends StatefulWidget {
  Billet? billet;
  ModifierBillet({super.key, this.billet});

  @override
  _ModifierBilletState createState() {
    return _ModifierBilletState();
  }
}

class _ModifierBilletState extends State<ModifierBillet> {
  final _formKey = GlobalKey<FormState>();
  String _titre = "";
  String _detailArticle = "";
  TextEditingController titreController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titreController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    titreController.text = widget.billet!.billetTitre!;
    descController.text = widget.billet!.billetDetail!;
    super.initState();
  }

  var _image;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modification"),
        backgroundColor: const Color.fromRGBO(89, 107, 200, 0.7),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: TextButton(
                onPressed: () =>
                    onSubmit(context, user, _formKey, _image, widget.billet!),
                child: const Text(
                  'MODIFIER',
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
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                widget.billet!.billetTitre!,
                textScaleFactor: 1.4,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: widget.billet!.billetUrlImg!,
                    child: (_image == null)
                        ? Image.network(widget.billet!.billetUrlImg!,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width)
                        : Image.file(File(_image!.toString())),
                  ),
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
                      controller: titreController,
                      //initialValue: widget.billet!.billetTitre,
                      maxLength: 200,
                      onChanged: (value) => _titre = value,
                      validator: (value) => _titre == ''
                          ? 'Veuillez saisir le titre de votre titre'
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
                      controller: descController,
                      //initialValue: widget.billet!.billetDetail,
                      maxLines: 2,
                      onChanged: (value) => _detailArticle = value,
                      validator: (value) => _detailArticle == ''
                          ? 'Veuillez saisir le titre de votre article'
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

  void onSubmit(context, user, keyForm, image, Billet billet) async {
    if (keyForm.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(
                'Voulez-vous appliquer ces modifications ? ',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "ANNULER",
                      style: TextStyle(color: Colors.red),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    DataBaseServices db = DataBaseServices();
                    String _carUrlImag;
                    Billet bil = Billet();
                    if (image != null) {
                      _carUrlImag = await db.uploadFile(File(image));
                      bil.billetUrlImg = _carUrlImag;
                    } else {
                      bil.billetUrlImg = billet.billetUrlImg;
                    }
                    bil.billetID = billet.billetID;

                    bil.billetTitre = _titre;

                    bil.billetDetail = _detailArticle;

                    db.updateBillet(bil);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showNotification(context, "Chargement...");
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("MODIFIER"),
                )
              ],
            );
          });
    }
  }
}
