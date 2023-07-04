import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/core/themes/app_colors.dart';
import 'package:zetaton_task/features/authentication/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zetaton_task/features/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/features/home/provider/home_provider.dart';
import 'package:zetaton_task/features/splash/presentation/pages/splash_page.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'Zetaton task',
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true,
              ),
              home: child);
        },
        child: const SplashPage(),
      ),
    );
  }
}
