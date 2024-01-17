import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:currency_conversion/screens/history_screen.dart';
import 'package:currency_conversion/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/Constants.dart';
import '../utils/userdata_services.dart';
import '../widgets/currency_convert.dart';
import '../widgets/currency_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;
  final _controller = NotchBottomBarController();
  List destination = [
    const CurrencyConvert(),
    CurrencyList(),
    const HistoryScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData = Provider.of<UserDataProvider>(context).userData;
    return Scaffold(
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          itemLabelStyle: const TextStyle(color: Color(0xFFFABA49)),
          kIconSize: 20,
          color: const Color(0xff1d2937),
          onTap: (value) {
            setState(() {
              _currentIndex = value;
              log(_currentIndex.toString());
            });
          },
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.currency_exchange,
                color: Color(0xFFFABA49),
              ),
              activeItem: Icon(
                Icons.currency_exchange,
                color: Color(0xFFFABA49),
              ),
              itemLabel: 'Convert',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.list,
                color: Color(0xFFFABA49),
              ),
              activeItem: Icon(
                Icons.list,
                color: Color(0xFFFABA49),
              ),
              itemLabel: 'List',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.history,
                color: Color(0xFFFABA49),
              ),
              activeItem: Icon(
                Icons.history,
                color: Color(0xFFFABA49),
              ),
              itemLabel: 'History',
            ),
          ],
          kBottomRadius: 20,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff1d2937),
          title: const Row(
            children: [
              Icon(
                Icons.monetization_on,
                color: Color(0xFFFABA49),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Currency Converter",
                    style: TextStyle(
                      color: Color(0xFFFABA49),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton(
              color: const Color(0xFFFABA49),
              icon: CircleAvatar(
                backgroundColor: const Color(0xFFFABA49),
                radius: 11,
                child: Text(
                  userData.name.isNotEmpty
                      ? userData.name[0].toUpperCase()
                      : '',
                  style: const TextStyle(
                    color: Color(0xff1d2937),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: Text(
                      userData.name,
                      style: AppDesignSystem.currencyHeading.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        extendBody: true,
        body: destination[_currentIndex]);
  }
}
