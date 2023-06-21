import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Divider(
        thickness: 0.7,
        color: Colors.grey[400],
      ),
    );
  }
}
