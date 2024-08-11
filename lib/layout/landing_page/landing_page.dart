import 'package:flutter/material.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/layout/landing_page/components/appbar_title.dart';

class LandingPage extends StatelessWidget {
  static const landingPageRoute = '/';
  final AuthCubit authCubit = AuthCubit();
   LandingPage({super.key });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade200,
          title: AppbarTitle()),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                authCubit.Logout(context: context);
              },
              child: const Text('LogOut temporary'))
        ],
      ),
    );
  }
}
