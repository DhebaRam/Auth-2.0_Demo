import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Auth0 auth0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth0 = Auth0('dev-5v8kd0frflwoow88.us.auth0.com',
        'QDaA2wbJuNchSQzi0o5UGVzwiSHhCrRn');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () async {
        try {
          final credential = await auth0.credentialsManager.hasValidCredentials();
          log('Credential ---> $credential');
          final credential1 = await auth0.webAuthentication(scheme: 'https').login();
          log('Credential ---> $credential1');
        } catch (error) {
          log('Error ---> ${error.toString()}');
        }
      },
      child: const Text('Login'),
    )));
  }
}
