import 'package:blog/models/billet.dart';
import 'package:blog/services/convertisseurDate.dart';
import 'package:blog/vue/sharedUI/photoDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BilletFeed extends StatelessWidget {
  final Billet? billet;
  final String? userID;
  const BilletFeed({super.key, this.billet, this.userID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 3.0,
                  color: Colors.indigo,
                  indent: 15.0,
                  endIndent: 100.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
                  child: Text(
                    billet!.billetTitre!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                            DateConvertisseur()
                                .formattingDate(billet?.billetTimestamp),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )),
                ),
                Hero(
                  tag: billet!.billetTitre!,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PhotoDetail(url: billet!.billetUrlImg!)));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.70,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black54,
                          size: 16.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                          height: 10.0,
                        ),
                        const Text(
                          "| ",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${billet!.billetUserName}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 170, 14, 3),
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          billet!.billetDetail!,
                          maxLines: 8,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/detail',
                              arguments: billet),
                          child: Container(
                            width: 150.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                                color: Colors.indigo,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'LIRE LA SUITE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Autres Articles',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/articles',
                              arguments: billet),
                          style: TextButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Color.fromARGB(255, 235, 236, 243),
                          ),
                          child: const Text(
                            'Voir tout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.indigo),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
