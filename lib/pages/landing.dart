import 'package:chat_app/firebase_auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOMEPAGE'),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('This is a landing page.'),
      ),
    );
  }
}
