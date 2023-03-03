import 'package:blog/services/authentification.dart';

import 'package:blog/vue/profile/profileAppBar.dart';
import 'package:blog/vue/sharedUI/photoDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
              user: _user,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Colors.blueGrey,
                child: Container(
                  color: Color.fromARGB(0, 34, 99, 72),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PhotoDetail(url: _user.photoURL!)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        alignment: Alignment.center,
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(_user.photoURL!),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                subtitle: Text(
                  _user.displayName!,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                title: const Text("Nom et Prenoms",
                    style: TextStyle(fontSize: 14.0)),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email),
                subtitle: Text(
                  _user.email!,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                title: const Text("Email", style: TextStyle(fontSize: 14.0)),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.40,
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 180, 21, 10)),
                    onPressed: () => signOut(context),
                    child: const Text(
                      'Deconnexion',
                      style: TextStyle(fontSize: 16.0),
                    )),
              )
            ])),
          ],
        ),
      ),
    );
  }

  signOut(BuildContext context) {
    Navigator.of(context).pop();
    AuthService().sigOut();
  }
}
