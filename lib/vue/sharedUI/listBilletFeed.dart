import 'package:blog/models/billet.dart';
import 'package:blog/services/convertisseurDate.dart';

import 'package:flutter/material.dart';

class ListBilletFeed extends StatelessWidget {
  final Billet? billet;
  final String? userID;
  const ListBilletFeed({super.key, this.billet, this.userID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/detail', arguments: billet),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: billet!.billetTitre!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            height: MediaQuery.of(context).size.width * 0.30,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(billet!.billetUrlImg!),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 5.0),
                            iconColor: Colors.amber,
                            visualDensity: VisualDensity.standard,
                            title: Text(
                              billet!.billetTitre!,
                              maxLines: 5,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.black54,
                                      size: 16.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      DateConvertisseur().formattingDate(
                                          billet?.billetTimestamp),
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1.0,
        ),
      ],
    );
  }
}
