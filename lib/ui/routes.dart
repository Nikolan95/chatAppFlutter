import 'package:chat_app/ui/screens/login_screen.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/screens/signup_screen.dart';
import 'package:chat_app/ui/screens/start_screen.dart';
import 'package:chat_app/ui/screens/users/profile_screen.dart';
import 'package:chat_app/ui/screens/welcome_screen.dart';
import 'package:chat_app/ui/screens/car/car_screen.dart';
import 'package:flutter/material.dart';

const String initialRoute = "start";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'main':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case 'start':
        return MaterialPageRoute(builder: (_) => StartScreen());
      case 'welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'sign-up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case 'carscreen':
        return MaterialPageRoute(builder: (_) => CarScreen());
      case 'user':
        return MaterialPageRoute(builder: (_) => ProfileScreen());

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
