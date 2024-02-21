// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
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
                        alignment: Alignment.centerRight,
                        child: _CopyClipboard()),
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
