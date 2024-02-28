import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

import '../screen/home.dart';

const appScheme = 'flutterdemo'; // 👈 New code

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Credentials? _credentials;
  late Auth0 auth0;
  bool isBusy = false;
  late String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth0 = Auth0(
        '{Your Domain}',

        ///dev-5v8kd0frflwoow878071972288.us.auth0.com********
        '{Your App Client ID }');

    ///ZyurLUoLWhs90psdFnVSSrQCXkg6588780719722Gu*********
    errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Auth0 Demo'),
      // ),
      body: Center(
        child: isBusy
            ? const CircularProgressIndicator()
            : _credentials != null
                ? Profile(logoutAction, _credentials?.user)
                : Login(loginAction, errorMessage),
      ), // 👈 Updated code
    );
    // return Scaffold(
    //     body: Center(
    //         child: TextButton(
    //   onPressed: () async {
    //     try {
    //       final credential = await auth0.credentialsManager.hasValidCredentials();
    //       log('Credential ---> $credential');
    //       final credential1 = await auth0.webAuthentication().login();
    //       // final credential1 = await auth0.webAuthentication(scheme: 'https').logout();
    //       log('Credential ---> $credential1');
    //     } catch (error) {
    //       log('Error ---> ${error.toString()}');
    //     }
    //   },
    //   child: const Text('Login'),
    // )));
  }

  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: appScheme).logout();

    setState(() {
      _credentials = null;
    });
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: appScheme).login();

      setState(() {
        isBusy = false;
        _credentials = credentials;
      });
      log('Token ---- > ${credentials.expiresAt}');
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        errorMessage = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.cyan,
            content: Text(errorMessage.toString(),
                style: const TextStyle(color: Colors.white))));
      });
    }
  }
}

class Login extends StatelessWidget {
  final Future<void> Function() loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.network(
          'https://img.freepik.com/free-photo/bar-concept_23-2147798067.jpg?size=626&ext=jpg&ga=GA1.1.1855505643.1692086058&semt=ais',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          bottom: 20,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              child: Column(children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await loginAction();
                      },
                      child: const Text('Login   /   Register'),
                    ),
                  ],
                ),
              ])),
        )
      ],
    );
  }
}
