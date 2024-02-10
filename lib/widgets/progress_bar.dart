// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    this.total = 10,
    this.value = 7,
  });
  final int total, value;
  // final String label;

  @override
  Widget build(BuildContext context) {
    const height = 8.0;
    const radius = 15.0;
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      // alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: const Color(0xFF505050),
          borderRadius: BorderRadius.circular(radius)),
      height: height,
      child: LayoutBuilder(
          builder: (context, constraints) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height,
                  width: (value / total) * constraints.maxWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ])),
                ),
              )),
    );
  }
}
