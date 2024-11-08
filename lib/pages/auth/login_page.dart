import 'package:bts_coding_test/datasources/auth_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void gotoRegister() {
    Navigator.pushNamed(context, '/register');
  }

  void login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final (success, message) = await AuthDataSource.login(
      username,
      password,
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Gap(50),
          const Text(
            'Login First',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const Gap(30),
          DInputMix(
            title: 'Username',
            controller: usernameController,
          ),
          const Gap(20),
          DInputMix(
            title: 'Password',
            controller: passwordController,
            obscure: true,
          ),
          const Gap(20),
          FilledButton(
            onPressed: login,
            child: const Text('Login'),
          ),
          const Gap(10),
          TextButton(
            onPressed: gotoRegister,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
