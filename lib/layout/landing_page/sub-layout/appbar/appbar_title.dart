import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/layout/landing_page/sub-layout/appbar/widgets/isAuth.dart';
import 'package:golobe/layout/landing_page/sub-layout/appbar/widgets/non_auth.dart';

class AppbarTitle extends StatefulWidget {
  final LoginEntity? user;
  const AppbarTitle({super.key, this.user});

  @override
  State<AppbarTitle> createState() => _AppbarTitleState();
}

class _AppbarTitleState extends State<AppbarTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      return AuthedState(user: widget.user);
    }

    return const NonAuth();
  }
}
