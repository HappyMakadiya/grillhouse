import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GoogleButton extends StatelessWidget {

  GoogleButton(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(8.0),
      ),
      color: Colors.white,
      icon: SvgPicture.asset(
        'assets/images/google.svg',
        width: 20,
        height: 20,
      ),
      onPressed: this.onPressed,
      label: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text('Sign in with Google', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
      ),
    );
  }

}