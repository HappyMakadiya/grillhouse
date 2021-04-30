import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grillhouse/Screens/home_screen.dart';
import 'package:grillhouse/Screens/profile_screen.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedItemPosition = 0;
  Color cartColor = Colors.black38;
  Color badgeColor = Color(0xffffb525);
  Color badgeTextColor = Colors.white;
  List<Widget> _nabBarWidget = <Widget>[
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _nabBarWidget.elementAt(_selectedItemPosition),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          boxShadow: shadowList,
        ),
        child: Consumer<CartModel>(
          builder: (context, cartModel, child) =>  ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GNav(
              hoverColor: Colors.grey[100],
              color: Colors.black38,
              activeColor: Colors.white,
              backgroundColor: Colors.white,
              tabBackgroundColor: Theme.of(context).primaryColor,
              gap: 15,
              iconSize: 30,
              curve: Curves.easeInOut,
              tabMargin: EdgeInsets.all(12),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                ),
                GButton(
                  leading: Badge(
                    badgeContent: Text(cartModel.cart.length.toString(), style: TextStyle(color: badgeTextColor),),
                    badgeColor: badgeColor,
                    animationType: BadgeAnimationType.fade,
                    child: Icon(
                      CupertinoIcons.bag,
                      size: 30,
                      color: cartColor
                    ),
                  ),
                  // icon: CupertinoIcons.bag,
                  text: 'Cart',
                ),
                GButton(
                  icon: CupertinoIcons.profile_circled,
                  text: 'Profile',
                )
              ],
              selectedIndex: _selectedItemPosition,
              onTabChange: (index)
              {
                setState((){
                  _selectedItemPosition = index;
                  cartColor = index == 1 ? Colors.white : Colors.black38;
                  badgeColor = index == 1 ?   Colors.white : Color(0xffffb525);
                  badgeTextColor = index == 1 ? Color(0xffffb525) : Colors.white;
                }
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
