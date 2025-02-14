import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class LoginFormField extends StatefulWidget {
  final TextStyle hintStyle;

  const LoginFormField(
      {super.key, this.hintStyle = const TextStyle(color: Colors.grey)});

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isCheck = false;
  //
  late AuthCubit _authCubit;

  ValueNotifier<bool> isObs = ValueNotifier(true);
  @override
  void initState() {
    _authCubit = AuthCubit();
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  dynamic handleLogin() {
    if (_formkey.currentState!.validate() == false) {
      return;
    }
    return _authCubit.login(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please fill in user name or email";
              }
              if (value.length < 5) {
                return "Invalid input, please check";
              }
              return null;
            },
            decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 10, maxHeight: 50),
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                  child: SvgPicture.asset(IconsPath.email),
                ),
                hintText: 'Accept user name',
                hintStyle: widget.hintStyle,
                border: const OutlineInputBorder()),
          ),
          VerticalSpace(value: 15),
          ValueListenableBuilder(
              valueListenable: isObs,
              builder: (_, obsBuilder, __) {
                return TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill in password";
                    }
                    if (value.length < 5) {
                      return "Invalid input, please check";
                    }
                    return null;
                  },
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: obsBuilder,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Password here",
                    hintStyle: widget.hintStyle,
                    prefixIconConstraints:
                        const BoxConstraints(minHeight: 10, maxHeight: 50),
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 5, end: 5),
                      child: SvgPicture.asset(
                        IconsPath.lock,
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 10, maxHeight: 50),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onTap: () {
                          isObs.value = !isObs.value;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Ink(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              obsBuilder ? IconsPath.eyeClosed : IconsPath.eye,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          VerticalSpace(value: 15),

          //Check box here
          Row(
            children: [
              Checkbox(
                  value: isCheck,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheck = value!;
                    });
                  }),
              const Text(
                'Remember me ?',
                style: TextStyle(color: Colorscontroller.warning, fontSize: 15),
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: BlocProvider(
              create: (context) => _authCubit,
              child: BlocBuilder(
                  bloc: _authCubit,
                  builder: (context, state) {
                    if (state is AuthProcessing) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colorscontroller.loginButton),
                      onPressed: () {
                        handleLogin();
                      },
                      child: const Text('Login',
                          style: TextStyle(
                              color: Colorscontroller.whitText,
                              fontSize: 30,
                              fontWeight: FontWeight.w400)),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
