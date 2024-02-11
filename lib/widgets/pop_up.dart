// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopUp extends AnimatedWidget {
  const PopUp(
      {Key? key, required Animation<double> animation, required this.message})
      : super(key: key, listenable: animation);

  final String message;

  @override
  build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: animation.drive(Tween<double>(begin: 0.0, end: 1.0)).value,
      child: Transform.translate(
        offset: animation
            .drive(Tween<Offset>(begin: Offset(0, 40), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOutQuad),
            ))
            .value,
        child: Transform.scale(
            scale: animation
                .drive(Tween<double>(begin: 0.8, end: 0.9)
                    .chain(CurveTween(curve: Curves.easeInQuart)))
                .value,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFDD2222),
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Theme.of(context).colorScheme.primary
                  ]),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_rounded),
                  const SizedBox(width: 8),
                  Text(message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            )),
      ),
    );
  }
}

Future<dynamic> showPopUp(AnimationController controller) async {
  controller.reset();
  controller.duration = Duration(milliseconds: 150);
  await controller.forward();
  return Future.delayed(Duration(seconds: 4), () {
    return controller.reverse();
  });
}
