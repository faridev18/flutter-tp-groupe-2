import 'package:blog/models/billet.dart';

import 'package:blog/myApp.dart';
import 'package:blog/services/authentification.dart';
import 'package:blog/services/dbBillet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(
          initialData: null,
          value: AuthService().user,
        ),
        StreamProvider<List<Billet>>.value(
            initialData: const [], value: DataBaseServices().billets),
      ],
      child: const MyApp(),
    ),
  );
}
