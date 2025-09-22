import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Import all your screens
import 'package:pleasurebd/screens/splash_screen.dart';
import 'package:pleasurebd/screens/firstpage.dart';
import 'package:pleasurebd/screens/login_page.dart';
import 'package:pleasurebd/screens/signup_page.dart';
import 'package:pleasurebd/screens/dashboard_page.dart';

// Color constants
const kPrimaryColor = Color.fromARGB(255, 11, 97, 236);
const kSecondaryColor = Color(0xFF004D40);
const kTextColor = Color(0xFF212121);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Only in debug
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PLEASURE BD',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),

      // ✅ Required for Device Preview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) => DevicePreview.appBuilder(context, child),

      // ✅ Initial screen
      initialRoute: '/splash',

      // ✅ Define all app routes here
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/firstpage': (context) => const FirstPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
