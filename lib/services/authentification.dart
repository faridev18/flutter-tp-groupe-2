import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Connexion avec Google

  Future<UserCredential> signWithGoogle() async {
    // Déclencher les flux d'authentification
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    //Obtenir les details d'autorisation
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Créer un nouvel identifiant

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    //Une fois connecté,  renvoyer les identifiants de l'utilisateur

    return await _auth.signInWithCredential(credential);
  }

  // L'état dde l'utilisateur en temps réel

  Stream<User?> get user => _auth.authStateChanges();

  // Deconnexion

  Future<void> sigOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
