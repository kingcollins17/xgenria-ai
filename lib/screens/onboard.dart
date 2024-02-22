// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/widgets/typing_text/ext.dart';

class XOnboard extends StatefulWidget {
  const XOnboard({super.key});

  @override
  State<XOnboard> createState() => _XOnboardState();
}

class _XOnboardState extends State<XOnboard> {
  int currentIndex = 0;
  final pController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Transform.rotate(
              angle: -0.0125,
              child: Container(
                decoration: BoxDecoration(
                  // color: Color(0x00000000),
                  image: DecorationImage(
                    // image: AssetImage('asset/images/arcane-bg.jpg'),
                    image: AssetImage('asset/onboard/bg.JPEG'),
                    fit: BoxFit.fill,
                    opacity: 0.2,
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Color(0xB0000000),
              ),
            ),
            PageView.builder(
              controller: pController,
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),
              itemCount: contents.length,
              itemBuilder: (context, index) => _OnboardContent(
                data: contents[currentIndex],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: currentIndex == contents.length - 1
                  ? SizedBox(
                      // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Center(
                        child: FilledButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                Size(MediaQuery.of(context).size.width * 0.8,
                                    45),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary,
                              )),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/auth');
                          },
                          child: Text(
                            'Get started',
                            style: GoogleFonts.quicksand(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                contents.length,
                                (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          index == currentIndex ? 5.0 : 2.0),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: index == currentIndex ? 30 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      // shape: BoxShape.circle,
                                      color: index == currentIndex
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Color(0xFF8A8A8A),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              pController.animateToPage(
                                  currentIndex < contents.length - 1
                                      ? ++currentIndex
                                      : currentIndex,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                  // Colors.pinkAccent
                                ]),
                                // borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Positioned(
                top: 30,
                // left: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'asset/images/logo.svg',
                            width: 65,
                            height: 65,
                            // color: Theme.of(context).colorScheme.secondary,
                          ),
                          // Row(children: [],)
                          GestureDetector(
                            onTap: () =>
                                Navigator.popAndPushNamed(context, '/auth'),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                color: Color(0xFFD8D8D8),
                                fontSize: 16,
                              ),
                            ),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _OnboardContent extends StatelessWidget {
  const _OnboardContent({
    super.key,
    required this.data,
  });

  final _ContentData data;

  @override
  Widget build(BuildContext context) {

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.5,
            // width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(blurRadius: 30, color: Colors.black),
                        BoxShadow(
                            blurRadius: 25,
                            offset: Offset(0, 5),
                            color: Theme.of(context).colorScheme.primary),
                        BoxShadow(
                            blurRadius: 25,
                            color: Colors.orangeAccent,
                            offset: Offset(5, 0))
                      ]),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 220,
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Text(data.detail,
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xFFC9C9C9),
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 100)
      ],
    );
  }
}

class _ContentData {
  final String image, title, detail;

  const _ContentData(
      {this.image = '', required this.title, required this.detail});
}

const contents = <_ContentData>[
  _ContentData(
    title: 'AI Image Generator',
    image: 'asset/images/onboard-1.jpg',
    detail: 'Turn your ideas into stunning visuals with AI-created image,'
        ' share your vision and watch it come to life',
  ),
  _ContentData(
    title: 'AI Content Writer',
    image: 'asset/images/onboard-2.png',
    detail: 'Generate engaging plagiarism-Free content effortlessly using AI',
  ),
  _ContentData(
      title: 'Speech to Text',
      image: 'asset/images/onboard-3.png',
      detail: 'Transform words into written text harnessing advanced '
          'algorithms for accurate and efficient transcription'),
  _ContentData(
    title: 'AI Code Assistant',
    image: 'asset/images/onboard-4.jpg',
    detail: 'Elevate your coding prowess with AI-Generated code snippets, '
        'whether you are a pro, beginner or an expert',
  )
];
