import 'package:app_acueducto/routes/aap_routes.dart';
import 'package:app_acueducto/src/localization/string_harcoded.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'My appAqua'.hardcoded,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff00B0BF),
              foregroundColor: Colors.white,
              elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xff00B0BF), // background (button) color
              foregroundColor: Colors.white, // foreground (text) color
            ),
          )),
    );
  }
}
