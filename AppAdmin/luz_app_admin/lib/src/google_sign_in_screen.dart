import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> _signInWithGoogle() async {
    // Fazer login com o Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Criar credenciais do Firebase
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Autenticar com o Firebase
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Retornar as credenciais do usuário
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autenticação com o Google'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login com o Google'),
          onPressed: () {
            _signInWithGoogle().then((UserCredential userCredential) {
              // print('Usuário autenticado: ${userCredential.user}');
              print(
                  '------------------------------------------------> Autenticado');
            }).catchError((e) {
              // Erro ao autenticar
              print('Erro ao autenticar com o Google: $e');
            });
          },
        ),
      ),
    );
  }
}
