import 'package:chat_app/ui/screens/auth/entry.dart';
import 'package:chat_app/ui/screens/auth/login.dart';
import 'package:chat_app/ui/screens/auth/register.dart';
import 'package:chat_app/ui/screens/car/car_list.dart';
import 'package:chat_app/ui/screens/home/home.dart';
import 'package:chat_app/ui/screens/home/launching.dart';
import 'package:chat_app/ui/screens/user/user_profile.dart';
import 'package:flutter/material.dart';

const String initialRoute = "start";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'main':
        return MaterialPageRoute(builder: (_) => Home());
      case 'start':
        return MaterialPageRoute(builder: (_) => Launching());
      case 'welcome':
        return MaterialPageRoute(builder: (_) => Entry());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'sign-up':
        return MaterialPageRoute(builder: (_) => Register());
      case 'carscreen':
        return MaterialPageRoute(builder: (_) => CarList());
      case 'user':
        return MaterialPageRoute(builder: (_) => UserProfile());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
