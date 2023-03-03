import 'package:blog/models/billet.dart';
import 'package:blog/vue/sharedUI/aLaUneFeed.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/dbBillet.dart';

class ALaUne extends StatelessWidget {
  final String? userID;
  const ALaUne({this.userID});

  @override
  Widget build(BuildContext context) {
    final billet = Provider.of<List<Billet>>(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
      return StreamBuilder(
          stream:
              DataBaseServices(userID: userID, billetID: billet[index].billetID)
                  .billets,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return BilletFeed(
                billet: billet[0],
                userID: userID,
              );
            } else {
              return BilletFeed(
                billet: billet[0],
                userID: userID,
              );
            }
          });
    }, childCount: 1));
  }
}
