import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/page/login/login.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/sidebar/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => login());
            case '/dashboard':
              return MaterialPageRoute(builder: (context) => MainScreen());
            case '/proyek':
              return MaterialPageRoute(builder: (context) => proyek());
            default:
          }
        },
        // home: MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(
        //       create: (context) => MenuAppController(),
        //     ),
        //   ],
        //   child: login(),
        // ),
        home: login(),
      ),
    );
  }
}
