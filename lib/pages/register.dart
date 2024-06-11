// ignore_for_file: avoid_print

import 'package:chat_app/const/color.dart';
import 'package:chat_app/firebase_auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool _isPwdObscure = true;
  bool _isPwd2Obscure = true;

  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController password2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    password2Controller = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLandScape
                ? const SizedBox(height: 40)
                : const SizedBox(height: 180),
            const Center(
              child: Text.rich(
                style: TextStyle(fontSize: 24),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Start your ",
                    ),
                    TextSpan(
                      text: 'chat',
                      style: TextStyle(color: TColor.prime1),
                    ),
                    TextSpan(
                      text: 'ting journey.',
                    ),
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Username';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text('USERNAME'),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: TColor.prime1)),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Email Address';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text('EMAIL ADDRESS'),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: TColor.prime1)),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        obscureText: _isPwdObscure,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          } else {
                            if (password2Controller.text ==
                                passwordController.text) {
                              return null;
                            } else {
                              return 'Password Mismatch';
                            }
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: ExcludeFocus(
                              child: IconButton(
                                  icon: _isPwdObscure
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isPwdObscure = !_isPwdObscure;
                                    });
                                  }),
                            ),
                            label: const Text('PASSWORD'),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: password2Controller,
                        textInputAction: TextInputAction.done,
                        obscureText: _isPwd2Obscure,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password';
                          } else {
                            if (password2Controller.text ==
                                passwordController.text) {
                              return null;
                            } else {
                              return 'Password Mismatch';
                            }
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: ExcludeFocus(
                              child: IconButton(
                                  icon: _isPwd2Obscure
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isPwd2Obscure = !_isPwd2Obscure;
                                    });
                                  }),
                            ),
                            label: const Text(' CONFIRM PASSWORD'),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  TColor.prime1),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _register();
                              }
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            ))),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Center(
              child: Text.rich(
                style: const TextStyle(fontSize: 16),
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Already joined us? ",
                    ),
                    TextSpan(
                      text: 'Login Here!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed('login');
                        },
                      style: const TextStyle(
                          color: TColor.prime1,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.register(email, password);

    if (user != null) {
      print("register successful");
    } else {
      print('error');
    }
  }
}
