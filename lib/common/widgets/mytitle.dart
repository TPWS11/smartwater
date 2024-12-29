import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final VoidCallback tap;
  const MyTitle({super.key, required this.title, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (title == 'Flow Rate')
          CardTitle(title: title),
        InkWell(
          onTap: tap,
          child: const Text(
            'See all',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (title != 'Flow Rate')
          CardTitle(title: title),
      ],
    );
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topRight: title == 'Flow Rate' ? const Radius.circular(8.0) : const Radius.circular(0),
          topLeft: title == 'Flow Rate' ? const Radius.circular(0) : const Radius.circular(8.0),
          bottomRight: title == 'Flow Rate' ? const Radius.circular(8.0) : const Radius.circular(0),
          bottomLeft: title == 'Flow Rate' ? const Radius.circular(0) : const Radius.circular(8.0)
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24.0, 5.0, 15.0, 5.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 21.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
