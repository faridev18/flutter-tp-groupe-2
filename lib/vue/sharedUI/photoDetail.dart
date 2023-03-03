import 'package:blog/vue/sharedUI/listBillet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/billet.dart';

class PhotoDetail extends StatelessWidget {
  final url;
  const PhotoDetail({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Image de l'Article",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: InteractiveViewer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: NetworkImage(url)),
          ),
        ),
      ),
    );
  }
}
