import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zetaton_task/core/helpers/session_manager.dart';
import 'package:zetaton_task/features/authentication/presentation/pages/login_page.dart';
import 'package:zetaton_task/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _navigationTimer() async {
    Timer(const Duration(seconds: 2), () async {
      bool isLogged = await sessionManager.getLogged();
      if (isLogged) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
      }
    });
  }


  @override
  void initState() {
    _navigationTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
