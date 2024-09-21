import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'dart:developer' as devlog;
import 'package:golobe/core/consttants/api_path.dart';
import 'package:dio/dio.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/gg_exept.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class AuthRepo {
  final FirebaseAuth _auth_fb = FirebaseAuth.instance;
  final dio = Dio();
  Future<LoginEntity> authLogin({
    BuildContext? context,
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'username': email,
        'password': password,
      };
      Response req = await dio.post(ApiPath.loginEndPoint, data: data);
      if (req.statusCode == 200) {
        Box<Map<String, dynamic>> authBox = await Hive.openBox(BoxName.authBox);
        final jsonEncoded = jsonEncode(req.data);

        final jsonDecoded = jsonDecode(jsonEncoded);

        final decoded = JWT.decode(jsonDecoded);
        await authBox.put(BoxName.authToken, decoded.payload ?? "");
        final inBox = authBox.get(BoxName.authToken);
        return LoginEntity(
            id: inBox!['_id'],
            username: inBox['username'],
            email: inBox['email'],
            avatar: inBox['avatar'] ?? "",
            isAdmin: inBox['admin']);
      } else {
        throw const LoginEntity(error: true);
      }
    } catch (e) {
      devlog.log("login failed due to -> $e");
      return const LoginEntity(error: true);
    }
  }

  //Sing with Google
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
