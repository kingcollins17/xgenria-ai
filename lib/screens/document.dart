// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AIDocuments extends ConsumerStatefulWidget {
  const AIDocuments({super.key});
  @override
  ConsumerState<AIDocuments> createState() => _AIDocumentsState();
}

class _AIDocumentsState extends ConsumerState<AIDocuments> {
  final templates = [
    (
      'asset/logos/png-transparent-web-development-html'
          '-responsive-web-design-logo-javascript-html-angle-web-design-text-thumbnail.png',
      'Coding'
    ),
    ('asset/images/icon-1.png', 'Coding Explanator'),
    ('asset/images/icon-3.png', 'Text'),
    ('asset/images/icon-4.png', 'Social Media'),
    ('asset/images/icon-5.png', 'Website'),
    ('asset/images/icon-6.png', 'Formula Bot'),
    ('asset/images/icon-2.png', 'Custom')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'AI Studio',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'There are no created AI Documents',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Start by creating your first AI written documents',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  ...List.generate(
                      templates.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x42DF40FB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                              constraints: BoxConstraints(minHeight: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    templates[index].$1,
                                    width: 60,
                                    height: 60,
                                    // color: Colors.transparent,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    templates[index].$2,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateDocument extends ConsumerStatefulWidget {
  const CreateDocument({super.key});
  @override
  ConsumerState<CreateDocument> createState() => _CreateDocumentState();
}

class _CreateDocumentState extends ConsumerState<CreateDocument> {
  final category = (
    'asset/images/icon-1.png',
    'Coding Explanator',
    ['Python', 'C++', 'Javascript', 'C#', 'Go']
  );
  final languages = ['English', 'French', 'Spanish', 'Chinese', 'German'];
  int currentTemplateIndex = 0;
  int variants = 1;
  int creativity = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Image.asset(
                category.$1,
                width: 60,
                height: 60,
              ),
              Text(
                category.$2,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.$3.length,
                  itemBuilder: (context, index) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => currentTemplateIndex = index),
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          constraints: BoxConstraints(minWidth: 80),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: currentTemplateIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Color(0xFF3A3A3A)),
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            category.$3[index],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _CustomInputField(label: 'Name'),
              _CustomInputField(label: 'Python Problem', maxLines: 5),
              _CustomInputField(label: 'Creative'),
              const SizedBox(height: 20),
              Text('Select Variants', style: GoogleFonts.poppins(fontSize: 16)),
              const SizedBox(height: 10),
              Container(
                color: Color(0xFF252525),
                child: DropdownButtonFormField<int>(
                    value: variants,
                    dropdownColor: Color(0xFF1D1D1D),
                    selectedItemBuilder: (context) => List.generate(
                        4,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '${index + 1} variants',
                                style: GoogleFonts.poppins(fontSize: 16),
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
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(),
                              child: Text(
                                '${index + 1} variants',
                                style: GoogleFonts.poppins(fontSize: 14),
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
                color: Color(0xFF1D1D1D),
                child: DropdownButtonFormField<String>(
                    value: languages.first,
                    selectedItemBuilder: (context) =>
                        List.generate(languages.length, (index) {
                          return Text(
                            languages[index],
                            style: GoogleFonts.poppins(fontSize: 16),
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
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ))),
                    onChanged: (value) => setState(() {})),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ])),
                child: Center(
                  child: Text(
                    'Generate',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  const _CustomInputField({
    super.key,
    required this.label,
    this.maxLines = 1,
  });
  final String label;
  final maxLines;

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
