// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: []),
    );
  }
}
