// ignore_for_file: avoid_print

import 'package:chat_app/components/dialog.dart';
import 'package:chat_app/const/color.dart';
import 'package:chat_app/firebase_auth/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPwdObscure = false;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                : const SizedBox(height: 250),
            const Center(
              child: Text.rich(
                style: TextStyle(fontSize: 24),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Let's start ",
                    ),
                    TextSpan(
                      text: 'chat',
                      style: TextStyle(color: TColor.prime1),
                    ),
                    TextSpan(
                      text: 'ting',
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
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text('EMAIL'),
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
                        textInputAction: TextInputAction.done,
                        obscureText: _isPwdObscure,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
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
                                _login();
                              }
                            },
                            child: const Text(
                              'LOGIN',
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
                      text: "Not a member? ",
                    ),
                    TextSpan(
                      text: 'Register Here!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed('register');
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

  void _login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final dialogWidgets = DialogWidgets(context);

    try {
      await authService.login(emailController.text, passwordController.text);
    } catch (e) {
      dialogWidgets.showErrorDialog(message: e.toString());
    }
  }
}
