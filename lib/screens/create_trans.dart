// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/project_provider.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/providers/trans_provider.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/pop_up.dart';
import '../widgets/widgets.dart';

class CreateTranscription extends ConsumerStatefulWidget {
  const CreateTranscription({super.key});
  @override
  ConsumerState<CreateTranscription> createState() =>
      _CreateTranscriptionState();
}

class _CreateTranscriptionState extends ConsumerState<CreateTranscription>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int currentProject = 0;
  File? file;

  Widget? notification;

  bool isLoading = false;

  String? name;
  ProjectData? project;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _pickFile() {
    setState(() => isLoading = true);
    FilePicker.platform
        .pickFiles(
          dialogTitle: 'Pick file to Transcribe',
          type: FileType.audio,
        )
        .then((value) => setState(() {
              isLoading = false;
              file = value != null ? File(value.files.first.path!) : null;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StoreConnector<XgenriaState, _ViewModel>(
            converter: (store) => _ViewModel(store),
            builder: (context, vm) {
              final projects =
                  ref.watch(projectNotifierProvider(vm.auth.token!));
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Create Transcription',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(children: [
                    const SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(
                        hintText: 'What do you want to name the transcription?',
                        hintStyle: GoogleFonts.quicksand(
                            fontSize: 16, color: Color(0xFFB3B3B3)),
                        isDense: true,
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload File',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickFile,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              () {
                                    final res = file?.path.split('/').last;
                                    if (res != null && res.length > 20) {
                                      return '${res.substring(0, 20)}... ${res.split('.').last}';
                                    }
                                    return res;
                                  }() ??
                                  'Tap to pick file',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            Icon(
                              Icons.upload_rounded,
                              size: 20,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    SelectProjectInput(
                      onChanged: (data) => project = data,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          if (file != null && name != null) {
                            setState(() => isLoading = true);
                            TranscriptionAPI.create(
                                    ref.read(dioProvider), vm.auth.token!,
                                    name: name!,
                                    file: file!,
                                    projectId: project?.projectId)
                                .then((value) {
                              value.status
                                  ? ref.invalidate(transNotifierProvider)
                                  : null;
                              setState(() {
                                notification = PopUp(
                                    animation: controller,
                                    message: value.message);
                                isLoading = false;
                              });
                              showPopUp(controller);
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          alignment: Alignment.center,
                          height: 45,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ])),
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SpinKitThreeInOut(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Please wait ',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Transcribe',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                  ]),
                ),
              );
            }),
        if (notification != null)
          Positioned(
              top: 20,
              width: MediaQuery.of(context).size.width,
              child: Center(child: notification!)),
      ],
    );
  }
}

class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState auth;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        auth = store.state.auth;
  void dispatch(action) => _store.dispatch(action);
}
