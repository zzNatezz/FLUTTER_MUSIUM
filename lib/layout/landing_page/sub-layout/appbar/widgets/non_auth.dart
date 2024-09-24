import 'package:flutter/material.dart';
import 'package:golobe/layout/login/login.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:go_router/go_router.dart';


class NonAuth extends StatelessWidget {
  const NonAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Update weather late',
          style: TextStyle(color: Colorscontroller.whitText),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colorscontroller.whitText),
            onPressed: () {
              context.go('/${LoginPage.loginPageRoute}');
            },
            child: const Text(
              'Login',
              style: (TextStyle(color: Colorscontroller.blue, fontSize: 18)),
            ))
      ],
    );
  }
}
