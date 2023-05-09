//unify BlocProvider and routes and screens
import 'package:client/bloc/application/application_bloc.dart';
import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/common/routes/names.dart';
import 'package:client/screens/application/application.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/user_profile_screen.dart';
import 'package:client/screens/register/register_screen.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreens {
  static List<ScreenEntity> routes() {
    return [
      ScreenEntity(
          route: AppRoutes.APPLICATION,
          screen: const Application(),
          bloc: BlocProvider(
            create: (_) => ApplicationBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.SIGN_IN,
          screen: const SignInScreen(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.REGISTER,
          screen: const RegisterScreen(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.PROFILE,
          screen:  ProfileScreen(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(), // change to ProfileBloc
          )),
      // ScreenEntity(
      //     route: AppRoutes.HOME,
      //     screen: const HomeScreen(),
      //     bloc: BlocProvider(
      //       create: (_) => ApplicationBloc(),
      //     )),
    ];
  }

//return all bloc providers
  static List<dynamic> allProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      //check for route name matching when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);

      if (result.isNotEmpty) {
        print("valid ${settings.name}");
        return MaterialPageRoute(
            builder: (_) => result.first.screen, settings: settings);
      }
    }
    print("invalid ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const SignInScreen(), settings: settings);
  }
}

class ScreenEntity {
  String route;
  Widget screen;
  dynamic bloc;

  ScreenEntity({required this.route, required this.screen, this.bloc});
}
