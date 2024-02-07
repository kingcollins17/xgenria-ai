// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIDocuments extends ConsumerStatefulWidget {
  const AIDocuments({super.key});
  @override
  ConsumerState<AIDocuments> createState() => _AIDocumentsState();
}

class _AIDocumentsState extends ConsumerState<AIDocuments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
