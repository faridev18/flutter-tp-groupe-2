import 'package:blog/models/billet.dart';
import 'package:blog/vue/sharedUI/aLaUneFeed.dart';
import 'package:blog/vue/sharedUI/listBilletFeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/dbBillet.dart';

class BilletList extends StatelessWidget {
  final String? userID;
  const BilletList({super.key, this.userID});

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
            if (index == 0) {
              return BilletFeed(
                billet: billet[index],
                userID: userID,
              );
            } else {
              return ListBilletFeed(
                billet: billet[index],
                userID: userID,
              );
            }
          });
    }, childCount: billet.length > 3 ? 3 : billet.length));
  }
}
