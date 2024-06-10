import 'package:chat_app/pages/landing.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/login",
  routes: <RouteBase>[
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
