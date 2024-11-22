import 'package:flutter/material.dart';

import '../color/color.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? opTap;

  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.opTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
            color: BlackColor,
          )),
      leading: Icon(
        icon,
        color: BlackColor,
      ),
      onTap: opTap,
    );
  }
}
