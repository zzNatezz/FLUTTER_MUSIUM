import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';

class Personal extends StatelessWidget {
  final LoginEntity? user;
  const Personal({super.key, required this.user});

  static String get routerConfig => 'personal';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('dasd')),
      body: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            user?.avatar as String,
            height: 40,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return SvgPicture.asset(IconsPath.defaultAvatar, height: 40);
            },
          )),
    );
  }
}
