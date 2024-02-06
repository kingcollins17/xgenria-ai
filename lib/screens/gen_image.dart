import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class XGenImage extends StatefulWidget {
  const XGenImage({super.key});

  @override
  State<XGenImage> createState() => _XGenImageState();
}

class _XGenImageState extends State<XGenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(
            'AI Image',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )
        ]),
        actions: [
          SvgPicture.asset('asset/images/logo.svg', width: 35, height: 35),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Prompt',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFE6E6E6),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: const Color(0xFF313131),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  minLines: 4,
                  maxLines: 4,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: 'What do you want to create',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                    hintStyle:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Select Image size',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                    )),
              ),
              //Image size list
              SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ])),
                    ),
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select your style',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 2,
                runSpacing: 2,
                alignment: WrapAlignment.start,
                children: [
                  ...List.generate(
                    styles.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width * 0.20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFF000000),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(styles[index].$1),
                                )),
                          ),
                          Text(
                            styles[index].$2,
                            style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: const Color(0xFFE7E7E7),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

const sizes = [
  (1024, 1024),
  (1024, 768),
  (800, 600),
  (640, 480),
  (640, 800),
];

const styles = [
  ('asset/style/realistic.jpg', 'Realistic'),
  ('asset/style/pop-2.jpg', 'Pop'),
  ('asset/style/cyperpunk.jpg', 'Cyberpunk'),
  ('asset/style/gothic.jpg', 'Gothic'),
  ('asset/style/glass.jpg', 'Glass'),
  ('asset/webp/T-shirt-girl-AI-anime-art.webp', 'Anime'),
  ('asset/style/cartoon.jpg', 'Cartoon'),
  ('asset/style/avatar.jpg', 'Avatar'),
];
