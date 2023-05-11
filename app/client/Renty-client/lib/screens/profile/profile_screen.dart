import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/widgets/components/primary_button.dart';
import 'package:client/widgets/components/secondary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Личный кабинет "),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(children: const [
                Text(
                  'Имя',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black)
              ]),
            ),
            Expanded(
              child: Column(children: const [
                Text(
                  'Электронная почта',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black)
              ]),
            ),
            buildButton(
              "Выйти",
              "secondary",
              () {
                // Navigator.of(context).pop(const SignInScreen());
                // or
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const SignInScreen(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: MyBottomNavBar(
      //   selectedIndex: 3,
      // ),
    );
  }
}
