import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_menu/model/provider.dart';
import 'package:food_menu/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAac7IrNsdkfqIYKWyqkHnAp38HWDNQfVg",
            authDomain: "foodmenu1-e105c.firebaseapp.com",
            databaseURL: "https://foodmenu1-e105c-default-rtdb.firebaseio.com",
            projectId: "foodmenu1-e105c",
            storageBucket: "foodmenu1-e105c.appspot.com",
            messagingSenderId: "1058332156385",
            appId: "1:1058332156385:web:de03136b208d69b9edb2a0",
            measurementId: "G-CEYK5DRNJV"
        ));
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyCc2mKWweZ3EngeL-SNfCCPxp8rOGPbThs',
          appId: ':1058332156385:android:f67e4bafc12fa0f4edb2a0',
          messagingSenderId: 'sendid',
          projectId: 'foodmenu1-e105c',
          storageBucket: 'foodmenu1-e105c.appspot.com',
        )
    );
  }
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isDark: isDark),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.themeDataStyle,
      debugShowCheckedModeBanner: false,
      home: Splash_Page(),
    );
  }
}