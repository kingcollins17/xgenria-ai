// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xgenria/models/transcription.dart';

class TranscriptionDetail extends ConsumerStatefulWidget {
  const TranscriptionDetail({super.key, required this.data});
  final TranscriptionData data;
  @override
  ConsumerState<TranscriptionDetail> createState() =>
      _TranscriptionDetailState();
}

class _TranscriptionDetailState extends ConsumerState<TranscriptionDetail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              SvgPicture.asset(
                'asset/images/logo.svg',
                width: 40,
                height: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: _CopyClipboard(
                          text: '${widget.data.name}\n${widget.data.content}',
                        )),
                    Text(
                      widget.data.name,
                      softWrap: true,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.data.content.split(' ').length} words',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      widget.data.content,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 100),
                  ]),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: FilledButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                      Size(MediaQuery.of(context).size.width * 0.8, 45)),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              icon: Icon(Icons.delete),
              label: Text(
                'Delete transcription',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CopyClipboard extends StatelessWidget {
  const _CopyClipboard({
    super.key,
    this.text = '',
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text))
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  // width: 100,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          height: 20,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xDFFCFCFC),
                              borderRadius: BorderRadius.circular(30)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            'Text copied',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Color(0xED0E0E0E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
      },
      child: Container(
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0x3D4489FF),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'copy',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 12, color: Theme.of(context).colorScheme.primary),
          ),
          Icon(
            Icons.copy_all_rounded,
            size: 10,
            color: Theme.of(context).colorScheme.secondary,
          )
        ]),
      ),
    );
  }
}
