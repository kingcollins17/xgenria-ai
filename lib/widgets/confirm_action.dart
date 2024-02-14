// ignore_for_file: unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/models/models.dart';

class ConfirmAction extends StatelessWidget {
  const ConfirmAction({
    super.key,
    // required this.project,
    required this.message,
  });
  // final ProjectData project;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          constraints: BoxConstraints(maxHeight: 120),
          decoration: BoxDecoration(
              color: Color(0xFF1D1D1D),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0xFF222222),
                )
              ]),
          child: Column(
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('Cancel')),
                    const SizedBox(width: 5),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Yes')),
                  ]),
                ),
              )
            ],
          )),
    );
  }
}
