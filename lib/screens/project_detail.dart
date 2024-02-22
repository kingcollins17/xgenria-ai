// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xgenria/api/_config.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/providers/image_provider.dart';
import 'package:xgenria/providers/trans_provider.dart';
import 'package:xgenria/redux/core.dart';

class ProjectDetail extends ConsumerStatefulWidget {
  const ProjectDetail({super.key, required this.project});
  final ProjectData project;
  @override
  ConsumerState<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends ConsumerState<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final images = ref.watch(imagesProvider(vm.auth.token!));
          final trans = ref.watch(transNotifierProvider(vm.auth.token!));
          final docs = ref.watch(docNotifierProvider(vm.auth.token!));

          return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      images.when(
                          data: (data) => ProjectImages(
                              images: data!, project: widget.project),
                          error: (err, __) => Text('Something went wrong $err'),
                          loading: () => Center(
                                child: SpinKitRipple(
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 30,
                                ),
                              )),
                      const SizedBox(height: 20),
                      docs.when(
                        data: (data) => ProjectDocuments(
                            project: widget.project,
                            documents: data!.documents),
                        error: (err, _) =>
                            Center(child: Text('Something went wrong $err')),
                        loading: () => SpinKitRipple(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 15),
                      trans.when(
                          data: (data) => data.data == null
                              ? Text(
                                  'No transcriptions to show!',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                )
                              : ProjectTranscriptions(
                                  project: widget.project, data: data.data!),
                          error: (err, _) =>
                              Center(child: Text('Something went wrong $err')),
                          loading: () => SizedBox.shrink()
                          // SpinKitRipple(
                          // color: Theme.of(context).colorScheme.primary,
                          // ),
                          ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ));
        });
  }
}

class ProjectTranscriptions extends StatelessWidget {
  const ProjectTranscriptions(
      {super.key, required this.data, required this.project});
  final List<TranscriptionData> data;
  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final projectTrans = data
        .where((element) =>
            (element.projectId != null) &&
            element.projectId == project.projectId)
        .toList();
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft, child: Text('AI Transcriptions')),
        const SizedBox(height: 15),
        ...List.generate(
            data.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/trans-detail', arguments: data[index]);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1A1A1A),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF080808),
                              offset: Offset(2, 4),
                              blurRadius: 4,
                            )
                          ]),
                      child: Row(children: [
                        Icon(
                          Icons.mic,
                          color: Theme.of(context).colorScheme.primary,
                          size: 25,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          data[index].name,
                          style: GoogleFonts.poppins(fontSize: 14),
                        )
                      ]),
                    ),
                  ),
                )),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: _AddButton(
            label: 'Add Transcription',
            onPressed: () => Navigator.of(context).pushNamed('/create-trans'),
          ),
        )
      ],
    );
  }
}

class ProjectDocuments extends StatefulWidget {
  const ProjectDocuments({
    super.key,
    required this.project,
    required this.documents,
  });
  final ProjectData project;
  final List<Document> documents;

  @override
  State<ProjectDocuments> createState() => _ProjectDocumentsState();
}

class _ProjectDocumentsState extends State<ProjectDocuments> {
  @override
  Widget build(BuildContext context) {
    final projectDocuments = widget.documents
        .where((element) =>
            (element.projectId != null) &&
            (element.projectId == widget.project.projectId))
        .toList();
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI Documents',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'see all > ',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(
            widget.documents.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/read-doc',
                      arguments: widget.documents[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFF202020),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Color(0xFF131313))
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        child: Icon(
                          Icons.edit_document,
                          size: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.documents[index].name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _AddButton(
              label: 'Add Document',
              onPressed: () => Navigator.of(context).pushNamed('/ai-doc'),
            ),
          )
          // const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ProjectImages extends StatelessWidget {
  const ProjectImages({super.key, required this.images, required this.project});
  final List<ImageData> images;
  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final projectImages = images
        .where((element) =>
            (element.projectId != null) &&
            (element.projectId == project.projectId))
        .toList();
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Images',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // const SizedBox(height: 10),
          // Text(projectImages.toString()),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                    images.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/image-result',
                                  arguments: (
                                    data: {
                                      'url':
                                          '$uploadsBaseUrl/${images[index].image}'
                                    },
                                    message: 'ImageData',
                                    status: false
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Color(0xFF242424),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  '$uploadsBaseUrl/${images[index].image}',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          loadingProgress == null
                                              ? child
                                              : Center(
                                                  child: SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 1.4,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                  ),
                                                ),
                                ),
                              ),
                            ),
                          ),
                        ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _AddButton(
              label: 'Add Image',
              onPressed: () => Navigator.of(context).pushNamed('/gen-image'),
            ),
          )
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    super.key,
    required this.label,
    this.onPressed,
  });
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
        ),
        icon: Icon(Icons.add, size: 15),
        label: Text(label));
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
