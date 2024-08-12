import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'dart:developer' as devlog;
import 'package:golobe/core/consttants/api_path.dart';
import 'package:dio/dio.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/gg_exept.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  // final ApiClient _apiClient = ApiClient();
  static final _auth_fb = FirebaseAuth.instance;
  final dio = Dio();
  Future<LoginEntity> authLogin({
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

      final jsonEncoded = jsonEncode(req.data);

      final jsonDecoded = jsonDecode(jsonEncoded);

      final decoded = JWT.decode(jsonDecoded);

      if (req.statusCode == 200) {
        return LoginEntity(
            id: decoded.payload['_id'],
            username: decoded.payload['username'],
            email: decoded.payload['email'],
            avatar: decoded.payload['avatar'],
            isAdmin: decoded.payload['admin']);
      } else {
        throw const LoginEntity(error: true);
      }
    } catch (e) {
      devlog.log("login failed due to -> $e");
      return const LoginEntity(error: true);
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
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    await _auth_fb.signOut();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
