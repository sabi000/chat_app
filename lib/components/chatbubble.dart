import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool sender;
  final String message;
  const ChatBubble({super.key, required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: sender ? Colors.green : Colors.blue,
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
