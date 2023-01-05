import 'package:app_acueducto/src/features/authentication/presentation/account/account_screen.dart';
import 'package:app_acueducto/src/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//import '../src/features/authentication/presentation/account/account_screen.dart';
import '../src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

enum AppRouter { home, account, signIn }

final goRouter =
    GoRouter(initialLocation: '/', debugLogDiagnostics: false, routes: [
  GoRoute(
      path: '/',
      name: AppRouter.home.name,
      builder: (context, state) => const EmailPasswordSignInScreen(
          formType: EmailPasswordSignInFormType.signIn),
      routes: [
        GoRoute(
          path: 'home',
          name: AppRouter.account.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const HomePage(),
          ),
        )
      ]),
]);
