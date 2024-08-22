import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/layout/landing_page/components/appbar_title.dart';
import 'package:golobe/layout/landing_page/sub-layout/history_list.dart';

//
class LandingPage extends StatelessWidget {
  static const landingPageRoute = '/';
  final LoginEntity? user;
  final AuthCubit authCubit = AuthCubit();
  LandingPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade200,
          title: AppbarTitle(user: user)),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HistoryList(userId: user?.id),
            const Text(' dsada'),
            ElevatedButton(
                onPressed: () {
                  authCubit.Logout(context: context);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
