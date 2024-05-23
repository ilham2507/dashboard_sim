import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/page/karyawan/karyawan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/services/auth/auth_bloc.dart';
import 'package:drawer/page/login/login.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/sidebar/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: _prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const MyApp({Key? key, this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(
          create: (context) => ProyekBloc(proyekServices: ProyekServices()),
        ),
        // BlocProvider<UserBloc>(
        //   create: (context) => UserBloc(userService: UserService()),
        // ),
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
        // Set initialRoute berdasarkan apakah token sudah ada
        initialRoute:
            prefs!.getString('token') != null ? '/dashboard' : '/login',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => Login());
            case '/dashboard':
              return MaterialPageRoute(builder: (context) => MainScreen());
            case '/proyek':
              return MaterialPageRoute(builder: (context) => proyek());
            case '/karyawan':
              return MaterialPageRoute(builder: (context) => karyawan());
            default:
              return null;
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
      ),
    );
  }
}
