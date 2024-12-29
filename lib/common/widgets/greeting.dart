
import 'package:flutter/material.dart';

class GreetingMessage extends StatelessWidget {
  final String greetingMessage;
  final String dateInfo;
  const GreetingMessage({super.key, required this.greetingMessage, required this.dateInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greetingMessage,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            dateInfo,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
