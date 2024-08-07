import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as devlog;
import 'package:golobe/core/consttants/api_login.dart';
import 'package:golobe/core/consttants/api_path.dart';
import 'package:dio/dio.dart';
import 'package:golobe/core/repo/repo_auth/gg_excep/gg_exept.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  // final ApiClient _apiClient = ApiClient();
  static final _auth_fb = FirebaseAuth.instance;
  final dio = Dio();
  Future<ClientModel> authLogin({
    BuildContext? context,
    required String email,
    required String password,
  }) async {
    try {
      final dio = Dio();
      final Map<String, dynamic> data = {
        'username': email,
        'password': password,
      };
      Response req = await dio.post(ApiPath.loginEndPoint, data: data);
      final jsonEncodde = jsonEncode(req.data);

      final jsondecodde = jsonDecode(jsonEncodde);

      final decoded = JWT.decode(jsondecodde);

      if (req.statusCode == 200) {
        return ClientModel(accessToken: decoded.payload);
      } else {
        return ClientModel(error: true);
      }
    } catch (e) {
      devlog.log('error due to --> $e');
      return ClientModel(error: true);
    }
  }

  //Sing with Googl;e
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw const NoGoogleAccountChosenException();
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    // await _auth_fb.signOut();
    await GoogleSignIn().signOut();
    // await FirebaseAuth.instance.signOut();
  }
}
