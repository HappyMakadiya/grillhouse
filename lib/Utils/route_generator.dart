import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/Registration/email_verification_screen.dart';
import 'package:grillhouse/Screens/Registration/login_screen.dart';
import 'package:grillhouse/Screens/Registration/signup_screen.dart';
import 'package:grillhouse/Screens/home_screen.dart';
import 'package:grillhouse/Screens/user_info.dart';
import 'package:grillhouse/main.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => UserState());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup_screen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home_screen':
          return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/verify_email':
        if(args is UserInfo){
          return MaterialPageRoute(builder: (_) => EmailVerificationScreen(userinfo: args));
        }
        else{
          _errorRoute();
        }
        break;
      // case '/cart_screen':
      //   return MaterialPageRoute(builder: (_) => Cart());
      // case '/subscription_screen':
      //   return MaterialPageRoute(builder: (_) => Subscription());
      // case '/userprofile_screen':
      //   return MaterialPageRoute(builder: (_) => UserProfile());
      // case '/setting_screen':
      //   return MaterialPageRoute(builder: (_) => Setting());

      default:
        _errorRoute();
    }
  }
}

void _errorRoute() {
  print("RouteError");
}