import 'package:chat_app/UI/chat/chatpage.dart';
import 'package:chat_app/services/firebase_auth/auth_gate.dart';
import 'package:chat_app/UI/chat/landing.dart';
import 'package:chat_app/UI/auth/login.dart';
import 'package:chat_app/UI/auth/register.dart';
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
    GoRoute(
      path: "/chatpage/:email/:id",
      name: 'chatpage',
      builder: (context, state) {
        final String receiverUserEmail =
            state.pathParameters['email'] ?? 'Unknown';
        final String receiverUserID = state.pathParameters['id'] ?? 'Unknown';
        return ChatPage(
          receiverUserEmail: receiverUserEmail,
          receiverUserID: receiverUserID,
        );
      },
    ),
  ],
);
