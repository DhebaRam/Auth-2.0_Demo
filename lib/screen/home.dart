import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const Profile(this.logoutAction, this.user, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.network(
          'https://img.freepik.com/free-photo/bar-concept_23-2147798067.jpg?size=626&ext=jpg&ga=GA1.1.1855505643.1692086058&semt=ais',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(user?.pictureUrl.toString() ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
                color: Colors.white38,
                child: Text('${user?.name}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 16, 4, 3),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(3.0, 4.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 218, 27, 27),
                          ),
                          // Shadow(
                          //   offset: Offset(10.0, 10.0),
                          //   blurRadius: 8.0,
                          //   color: Color.fromARGB(125, 210, 57, 95),
                          // ),
                        ]))),
            Container(
                color: Colors.white38,
                child: Text('${user?.email}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 16, 4, 3),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(3.0, 4.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 229, 53, 53),
                          ),
                          // Shadow(
                          //   offset: Offset(10.0, 10.0),
                          //   blurRadius: 8.0,
                          //   color: Color.fromARGB(125, 210, 57, 95),
                          // ),
                        ]))),
            const SizedBox(height: 48),

          ],
        ),
        Positioned(
            bottom: 20,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await logoutAction();
                  },
                  child: const Text('Logout'),
                ))),
      ],
    );
  }
}
