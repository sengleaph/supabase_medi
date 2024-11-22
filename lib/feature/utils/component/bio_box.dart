import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BioBox extends StatelessWidget {
  final String text;
  BioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        //color
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text.isNotEmpty ? text : "Empty Bio"),
    );
  }
}
