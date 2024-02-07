// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageScreen extends ConsumerStatefulWidget {
  const ImageScreen({super.key});
  @override
  ConsumerState<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends ConsumerState<ImageScreen> {
  var currentSizeIndex = 0;
  var currentStyleIndex = 0;
  final styles = [
    ('asset/style/cartoon.jpg', 'Cartoon'),
    ('asset/style/realistic.jpg', 'Realistic'),
    ('asset/style/gothic-2.jpg', 'Gothic'),
    ('asset/style/cyperpunk.jpg', 'Cyberpunk'),
    ('asset/style/pop-2.jpg', 'Pop'),
    ('asset/style/avatar.jpg', 'Avatar'),
    ('asset/style/glass.jpg', 'Glass'),
    ('asset/webp/Cute-front-portrait-AI-art.webp', 'Anime')
  ];
  final sizes = [(1024, 1024), (800, 600), (1024, 768), (600, 480), (800, 640)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Image',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Prompt',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(
                    minHeight: 120,
                    minWidth: MediaQuery.of(context).size.width * 0.8),
                decoration: BoxDecoration(
                    color: Color(0xFF252525),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                    maxLines: 4,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      hintText: 'What do you want to create',
                      hintStyle: GoogleFonts.quicksand(
                          color: Colors.grey, fontSize: 16),
                      border: InputBorder.none,
                    )),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Image size',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () => setState(() => currentSizeIndex = index),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: currentSizeIndex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Color(0xFF525252),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '${sizes[index].$1} x ${sizes[index].$2}',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select your style',
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 5,
                children: [
                  ...List.generate(
                      styles.length,
                      (index) => GestureDetector(
                            onTap: () =>
                                setState(() => currentStyleIndex = index),
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: currentStyleIndex == index
                                          ? Border.all(
                                              width: 2.5,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)
                                          : null,
                                      color: Color(0x99141414),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          styles[index].$1,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Text(
                                  styles[index].$2,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          )),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                constraints: BoxConstraints(
                    minHeight: 55,
                    minWidth: MediaQuery.of(context).size.width * 0.8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ])),
                child: Text(
                  'Generate Image',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
