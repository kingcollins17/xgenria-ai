// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/screens/home_screen.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Xgenria',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(width: 5),
                Text(
                  'AI',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Features',
            //     style: GoogleFonts.poppins(),
            //   ),
            // ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 4,
                runSpacing: 2,
                children: [
                  ...List.generate(
                      actions.length,
                      (index) => GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              actions[index].$4,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2B2B2B),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Image.asset(actions[index].$1,
                                          width: 30, height: 30),
                                      const SizedBox(height: 10),
                                      Text(
                                        actions[index].$2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Start creating with our Templates',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Templates',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'see all',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xFFC4C4C4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  _templates.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFF252525),
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _templates[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

final _templates = [
  'Explain Python code',
  'Generate content for Blog post',
  'Find Excel Formula',
];

final actions = [
  (
    'asset/images/icon-2.png',
    'Create AI Image',
    'Have our AI be that expert programmer who whispers tough code snippets to you',
    '/gen-image'
  ),
  (
    'asset/images/icon-4.png',
    'Create Documents',
    'Create captivating content and captions for social media postings',
    '/ai-docs'
  ),
  (
    'asset/images/icon-6.png',
    'Chat with Xgenria AI',
    'Easily chat with our very capable language models about everything and anything',
    '/chats'
  ),
  (
    'asset/images/icon-5.png',
    'Transcribe documents',
    'Easily chat with our very capable language models about everything and anything',
    '/test'
  )
];
