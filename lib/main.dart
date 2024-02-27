import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth_demo/screen/user_reg.dart';
import 'package:auth_demo/splash_screen.dart';
import 'package:auth_demo/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppProvider>(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const UserRegistration(title: 'Google Login',),
        // home: const MainView(),
        home: const SplashScreen(),
      )
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Credentials? _credentials;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-5v8kd0frflwoow88.us.auth0.com', 'QDaA2wbJuNchSQzi0o5UGVzwiSHhCrRn');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_credentials == null)
          ElevatedButton(
              onPressed: () async {
                try{
                  // await auth0.webAuthentication().logout();
                  WebAuthentication webAuthentication =
                  auth0.webAuthentication();
                  Credentials credentials =
                  // await webAuthentication.login();
                  await auth0.webAuthentication(scheme: 'demo').login();
                  log('credentials --- > ${credentials.user}');

                  setState(() {
                    _credentials = credentials;
                  });
                }catch(e){
                  log('Catch --- > ${e.toString()}');
                }
              },
              child: const Text("Log in"))
        else
          Column(
            children: [
              ProfileView(user: _credentials!.user),
              ElevatedButton(
                  onPressed: () async {
                    await auth0.webAuthentication(scheme: 'demo').logout();

                    setState(() {
                      _credentials = null;
                    });
                  },
                  child: const Text("Log out"))
            ],
          )
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, required this.user}) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.name != null) Text(user.name!),
        if (user.email != null) Text(user.email!)
      ],
    );
  }
}