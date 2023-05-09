import 'package:client/bloc/application/application_bloc.dart';
import 'package:client/bloc/application/application_state.dart';
import 'package:client/screens/bloc_providers.dart';
import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: const MyAppBar(
              title: "Home",
            ),
            bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
          ),
        ),
      );
    });
  }
}
