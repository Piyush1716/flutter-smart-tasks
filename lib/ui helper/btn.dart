import 'package:flutter/material.dart';
import 'package:todoapp/theme/appcolor.dart';

class Btn extends StatelessWidget {
  final Function() ontap;
  final String text;
  final double width;
  const Btn({required this.ontap, required this.text, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                  onPressed: ontap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primary,
                    minimumSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(text,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                );
  }
}