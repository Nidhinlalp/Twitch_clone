import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twithc_clone/providers/user_provider.dart';
import 'package:twithc_clone/resources/auth_methods.dart';
import 'package:twithc_clone/screens/home_screen.dart';
import 'package:twithc_clone/screens/login_screen.dart';
import 'package:twithc_clone/screens/onbording_screen.dart';
import 'package:twithc_clone/screens/signup_screen.dart';
import 'package:twithc_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twithc_clone/widgets/loding_indicator.dart';
import 'firebase_options.dart';
import 'models/users.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitch Clone',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: backgroundColor,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: const IconThemeData(
              color: primaryColor,
            ),
          ),
        ),
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const OnboardingScreen();
          },
        ),
      ),
    );
  }
}
