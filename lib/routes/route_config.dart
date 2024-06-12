import 'package:chat_app/firebase_auth/auth_gate.dart';
import 'package:chat_app/pages/landing.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      name: 'init',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: "/login",
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/register",
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: "/home",
      name: 'home',
      builder: (context, state) => const IndexPage(),
    ),
  ],
);
