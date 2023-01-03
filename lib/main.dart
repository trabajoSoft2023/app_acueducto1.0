//import 'package:app_acueducto/routes/app_routes.dart';
//import 'package:app_acueducto/src/app_theme.dart';
import 'package:app_acueducto/src/features/authentication/presentation/sign_in/email_password_screen.dart';
import 'package:app_acueducto/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:app_acueducto/src/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const EmailPasswordSignInScreen(
          formType: EmailPasswordSignInFormType.signIn,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
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
            )));
  }
}
