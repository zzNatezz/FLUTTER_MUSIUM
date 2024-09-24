import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/layout/landing_page/sub-layout/appbar/appbar_title.dart';
import 'package:golobe/layout/landing_page/sub-layout/body/body.dart';

//
class LandingPage extends StatelessWidget {
  static const landingPageRoute = '/';
  final LoginEntity? user;

  const LandingPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade200,
            title: AppbarTitle(user: user)),
        // drawer: const Drawer(), <-- TẠM THỜI BỎ VÌ CHƯA BIẾT LÀM J VỚI DRAWER NÀY
        body: const BodyLayout(),
        bottomSheet: const Text('Handle navigate area'));
  }
}
