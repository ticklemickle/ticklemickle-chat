import 'package:flutter/material.dart';

class CommonMenuItem extends StatelessWidget {
  final String title;
  final Widget destinationScreen;

  const CommonMenuItem(
      {super.key, required this.title, required this.destinationScreen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.normal)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
    );
  }
}
