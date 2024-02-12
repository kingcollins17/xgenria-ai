// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/image.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';



class ImageScreen extends ConsumerStatefulWidget {
  const ImageScreen({super.key});
  @override
  ConsumerState<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends ConsumerState<ImageScreen>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController controller;
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
  String? name, input;
  final sizes = [(256, 256), (512, 512), (1024, 1024)];
  int variants = 1;
  int lightingIndex = 0;
  int artistIndex = 0;

  Widget? notification;
  bool isLoading = false;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'AI Image',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF252525),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                        onChanged: (value) => name = value,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            focusedBorder: InputBorder.none)),
                  ),
                  const SizedBox(height: 20),
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
                        onChanged: (value) => input = value,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                      'Select Artist',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF222222),
                    ),
                    child: DropdownButtonFormField<int>(
                      value: artistIndex,
                      items: [
                        ...List.generate(
                            artists.length,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: Text(
                                  artists[index],
                                  style: GoogleFonts.poppins(fontSize: 14),
                                )))
                      ],
                      onChanged: (value) =>
                          setState(() => artistIndex = value ?? artistIndex),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select number of variants',
                            style: GoogleFonts.poppins(fontSize: 16),
                          )),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Color(0xFF222222)),
                        child: DropdownButtonFormField<int>(
                          value: variants,
                          items: [
                            ...List.generate(
                              4,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text(
                                  '${index + 1} variants',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) => setState(() {
                            variants = value ?? variants;
                          }),
                        ),
                      )
                    ],
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
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: MediaQuery.of(context).size.width *
                                          0.21,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lighting',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Color(0xFF242424)),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButtonFormField<int>(
                      // value: lightingIndex[lightingIndex],
                      value: lightingIndex,
                      items: [
                        ...List.generate(
                          lighting.length,
                          (index) => DropdownMenuItem(
                              value: index,
                              child: Text(
                                lighting[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              )),
                        )
                      ],
                      onChanged: (value) => setState(() {
                        lightingIndex = value ?? lightingIndex;
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StoreConnector<XgenriaState, _ViewModel>(
                    converter: (store) => _ViewModel(store),
                    builder: (context, vm) => GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed('/image-result');

                        if (!isLoading) {
                          if (name != null && input != null) {
                            setState(() {
                              isLoading = true;
                            });
                            ImageAPI.createImage(
                                    ref.read(dioProvider), vm.auth.token!,
                                    input: input!,
                                    name: name!,
                                    style: styles[currentStyleIndex].$2,
                                    size:
                                        '${sizes[currentSizeIndex].$1}x${sizes[currentSizeIndex].$2}',
                                    lighting: lighting[lightingIndex],
                                    artist: artists[artistIndex],
                                    variants: variants)
                                .then((result) {
                              setState(() {
                                isLoading = false;
                              });
                              result.data != null
                                  ? notify(result.message).then((value) =>
                                      Navigator.of(context).pushNamed(
                                          '/image-result',
                                          arguments: result))
                                  : notify(result.message);
                            });
                          } else {
                            notify(
                                'The name field and input field are required');
                          }
                        } else {
                          notify('Please wait ...');
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        constraints: BoxConstraints(
                            minHeight: 55,
                            minWidth: MediaQuery.of(context).size.width * 0.8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.primary,
                            ])),
                        child: isLoading
                            ? SpinKitThreeInOut(color: Colors.white, size: 25)
                            : Text(
                                'Generate Image',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        if (notification != null)
          Positioned(
              top: 40,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: notification!))),
      ],
    );
  }

  Future<dynamic> notify(String message) {
    setState(() {
      notification = PopUp(animation: controller, message: message);
    });
    return showPopUp(controller);
  }
}

class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState auth;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        auth = store.state.auth;
  void dispatch(XgenriaAction action) => _store.dispatch(action);
}

final artists = [
  'Leonardo Da Vinci',
  'Vincent Van Gogh',
  'Pablo picasso',
  'Salvador Dali',
  'Banksy',
  'Takashi Murakami',
  'George Condo',
  'Tim Burton',
  'Normal Rockwell',
  'Andy warhol',
  'Claude Monet'
];

final lighting = [
  'Warm',
  'Cold',
  'Golden hour',
  'Blue hour',
  'Ambient',
  'Studio',
  'Neon',
  'Dramatic',
  'Cinematic',
  'Natural',
  'Foggy',
  'Backlight',
  'Hard'
];
