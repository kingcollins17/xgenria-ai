// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/widgets/menu.dart';

class XProject extends StatefulWidget {
  const XProject({super.key});

  @override
  State<XProject> createState() => _XProjectState();
}

class _XProjectState extends State<XProject> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Material(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _HeaderLogo(),
                        const SizedBox(height: 30),
                        Text(
                          'Start your Project',
                          // textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Create and manage your Xgenria AI projects',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFFBBBBBB),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF313131),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFFB3B3B3),
                                size: 20,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                                const Color(0xFF7BABFF)
                              ])),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, size: 25),
                                Text(
                                  'Add New Project',
                                  style: GoogleFonts.poppins(),
                                )
                              ]),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'My Projects',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Container(
                                  height: 140,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFF1F1F1F),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: const Color(0x249E9E9E),
                                              border: Border.all(
                                                  color:
                                                      const Color(0x73797979)),
                                              shape: BoxShape.circle),
                                          child: const Icon(
                                            Icons.folder,
                                            size: 12,
                                            color: Color(0xFFB6B5B5),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'My Video',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '12 items',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const _ProgressBar(),
                                        const SizedBox(height: 5),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '2/4 projects',
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'asset/images/logo.svg',
              width: 45,
              height: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Text(
              'Xgenria AI',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFFDADADA),
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          'asset/svgs/undraw_profile_pic_re_iwgo.svg',
          width: 35,
          height: 35,
        )
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
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
