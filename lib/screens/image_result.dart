// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/models/image.dart';

class ImageResult extends ConsumerStatefulWidget {
  const ImageResult({super.key, required this.data});
  final ImageResultData data;
  @override
  ConsumerState<ImageResult> createState() => _ImageResultState();
}

class _ImageResultState extends ConsumerState<ImageResult> {
  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)?.settings.arguments as ImageResultData;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              widget.data.data!['url'],
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                  child,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 2,
                            value: (loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!),
                          ),
                        ),
                      );
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: TextButton(
                    onPressed: () => setState(() {}),
                    child: Text(
                      'Reload',
                      style: GoogleFonts.quicksand(
                          fontSize: 16, color: Colors.white),
                    )),
              ),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.45),
                  decoration: BoxDecoration(
                    color: Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share_rounded),
                      const SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                //download button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.45),
                  decoration: BoxDecoration(
                    color: Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_forever_rounded),
                      const SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ]),
            ),
            child: Text(
              'Generate more variants',
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
