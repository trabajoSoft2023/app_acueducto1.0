import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/features/authentication/presentation/sign_in/email_password_screen.dart';
import '../src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import '../src/home.dart';

enum AppRouter { account, signIn, home }

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
