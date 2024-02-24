// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/doc_provider.dart';
import 'package:xgenria/screens/document.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xgenria/widgets/pop_up.dart';
import 'package:xgenria/widgets/select_project.dart';
import '../providers/providers.dart';
import '../api/api.dart';

import '../redux/reducers/auth_reducer.dart';
import '../redux/state.dart';

class CreateDocument extends ConsumerStatefulWidget {
  const CreateDocument({super.key, required this.data});
  final (List<Template>, TemplateCategory, int) data;
  @override
  ConsumerState<CreateDocument> createState() => _CreateDocumentState();
}

class _CreateDocumentState extends ConsumerState<CreateDocument>
    with SingleTickerProviderStateMixin {
  late TemplateCategory category;
  final languages = ['English', 'French', 'Spanish', 'Chinese', 'German'];
  int currentTemplateIndex = 0;
  int variants = 1;
  int creativity = 5;

  ProjectData? project;

  String? name, input;

  bool isLoading = false;

  Widget? notification;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    currentTemplateIndex = widget.data.$3;
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
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
                    const SizedBox(width: 10),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.$2.name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // itemCount: category.$3.length,
                            itemCount: widget.data.$1.length,
                            itemBuilder: (context, index) => Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => currentTemplateIndex = index),
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    constraints: BoxConstraints(minWidth: 80),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: currentTemplateIndex == index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Color(0xFF3A3A3A)),
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      // category.$3[index],
                                      widget.data.$1[index].name,
                                      style:
                                          GoogleFonts.quicksand(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _CustomInputField(
                            label: 'Name',
                            onChanged: (p0) => setState(() => name = p0)),
                        _CustomInputField(
                          label: 'Input',
                          maxLines: 5,
                          onChanged: (p0) => setState(() => input = p0),
                        ),
                        const SizedBox(height: 20),
                        Text('Select Variants',
                            style: GoogleFonts.poppins(fontSize: 16)),
                        const SizedBox(height: 10),
                        Container(
                          color: Color(0xFF252525),
                          child: DropdownButtonFormField<int>(
                              value: variants,
                              dropdownColor: Color(0xFF1D1D1D),
                              selectedItemBuilder: (context) => List.generate(
                                  4,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          '${index + 1} variants',
                                          style:
                                              GoogleFonts.poppins(fontSize: 16),
                                        ),
                                      )),
                              hint: Text(
                                'Select the number of variants',
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              items: List.generate(
                                  4,
                                  (index) => DropdownMenuItem(
                                      value: index + 1,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          '${index + 1} variants',
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                      ))),
                              onChanged: (value) {
                                setState(() {
                                  variants = value ?? variants;
                                });
                              }),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Creativity',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        Slider.adaptive(
                          min: 0,
                          max: 10,
                          value: double.parse('$creativity'),
                          onChanged: (value) {
                            setState(() => creativity = value.ceil());
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Languages',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Color(0xFF2C2C2C),
                          child: DropdownButtonFormField<String>(
                              value: languages.first,
                              selectedItemBuilder: (context) =>
                                  List.generate(languages.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        languages[index],
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    );
                                  }),
                              items: List.generate(
                                  languages.length,
                                  (index) => DropdownMenuItem(
                                      value: languages[index],
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          languages[index],
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                      ))),
                              onChanged: (value) => setState(() {})),
                        ),
                        const SizedBox(height: 20),
                        SelectProjectInput(
                          onChanged: (data) => setState(() => project = data),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (name != null && input != null) {
                              setState(() {
                                isLoading = true;
                              });

                              var notifier = ref.read(
                                  docNotifierProvider(vm.auth.token!).notifier);
                              notifier
                                  .createDoc(
                                      name: name!,
                                      input: input!,
                                      templateId: widget
                                          .data.$1[currentTemplateIndex].id,
                                      projectId: project?.projectId)
                                  .then((value) {
                                _notify(value.$2);
                                if (value.$1 && value.$3 != null) {
                                  DocumentAPI.readDoc(
                                          ref.read(dioProvider), vm.auth.token!,
                                          id: value.$3!)
                                      .then(
                                    (doc) {
                                      doc.status && doc.data != null
                                          ? Navigator.of(context).pushNamed(
                                              '/read-doc',
                                              arguments: doc.data!)
                                          : _notify(doc.message,
                                              loading: false);
                                      ;
                                    },
                                  );
                                }
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary
                                ])),
                            child: Center(
                              child: isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text('Please wait'),
                                          const SizedBox(width: 2),
                                          SpinKitThreeInOut(
                                              color: Colors.white, size: 20),
                                        ])
                                  : Text(
                                      'Generate',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
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
                    top: 20,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: notification!))
            ],
          );
        });
  }

  void _notify(String value, {bool loading = false}) {
    setState(() {
      isLoading = loading;
      notification =
          PopUp(animation: controller, message: '$value Please wait ...');
    });
    showPopUp(controller);
  }
}

class _CustomInputField extends StatelessWidget {
  const _CustomInputField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.onChanged,
  });
  final String label;
  final int maxLines;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          constraints: BoxConstraints(
              minHeight: 50,
              maxWidth: MediaQuery.of(context).size.width * 0.85),
          decoration: BoxDecoration(color: Color(0xFF2B2B2B)),
          child: TextField(
            minLines: 1,
            maxLines: maxLines,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
