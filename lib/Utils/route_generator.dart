import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/Registration/email_verification_screen.dart';
import 'package:grillhouse/Screens/Registration/login_screen.dart';
import 'package:grillhouse/Screens/Registration/signup_screen.dart';
import 'package:grillhouse/Screens/home_screen.dart';
import 'package:grillhouse/Screens/navbar.dart';
import 'package:grillhouse/Screens/user_info.dart';
import 'package:grillhouse/main.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => CheckUserState());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup_screen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home_screen':
          return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/navbar':
        return MaterialPageRoute(builder: (_) => NavBar());
      case '/verify_email':
        if(args is UserInfoData){
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