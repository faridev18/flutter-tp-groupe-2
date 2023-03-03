import 'package:blog/models/billet.dart';
import 'package:blog/vue/detail/billetDetail.dart';
import 'package:blog/vue/detail/commentaireForm.dart';
import 'package:blog/vue/detail/detailAppBar.dart';
import 'package:blog/vue/detail/listeCommentaire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final billet = ModalRoute.of(context)!.settings.arguments as Billet;
    final _user = Provider.of<User>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            DatailAppBar(
              user: _user,
              billet: billet,
            ),
          ];
        }),
        body: CustomScrollView(
          slivers: [
            BilletDetail(
              user: _user,
              billet: billet,
            ),
            CommentaireForm(
              user: _user,
              billet: billet,
            ),
            CommentaireList(
              billetID: billet.billetID,
            )
          ],
        ),
      ),
    );
  }
}
