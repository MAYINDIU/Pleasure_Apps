import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pleasurebd/screens/firstpage.dart';
import 'package:pleasurebd/screens/splash_screen.dart';

// Color constants
const kPrimaryColor = Color.fromARGB(255, 11, 97, 236);
const kSecondaryColor = Color(0xFF004D40);
const kTextColor = Color(0xFF212121);

void main() {
  // Ensure widgets binding initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // Force enabled for debug, automatically disabled in release
    DevicePreview(
      enabled: !kReleaseMode, 
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
      // These two are **required for Device Preview**
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) => DevicePreview.appBuilder(context, child),

      home: const SplashScreen(),
    );
  }
}
