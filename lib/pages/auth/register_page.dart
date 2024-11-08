import 'package:bts_coding_test/datasources/auth_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void gotoLogin() {
    Navigator.pop(context);
  }

  void register() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final (success, message) = await AuthDataSource.register(
      username,
      email,
      password,
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    gotoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Gap(50),
          const Text(
            'Register new account',
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
            title: 'Email',
            controller: emailController,
          ),
          const Gap(20),
          DInputMix(
            title: 'Password',
            controller: passwordController,
            obscure: true,
          ),
          const Gap(20),
          FilledButton(
            onPressed: register,
            child: const Text('Register'),
          ),
          const Gap(10),
          TextButton(
            onPressed: gotoLogin,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
