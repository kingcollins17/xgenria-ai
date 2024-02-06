// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_element, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_riverpod/flutter_riverppod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/states/data/data_state.dart';
import 'package:xgenria/redux/xgenria_state.dart';

class XTemplates extends ConsumerStatefulWidget {
  const XTemplates({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _XTemplateState();
}

class _XTemplateState extends ConsumerState<XTemplates> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final templates = ref.watch(templatesProvider());

    return SafeArea(
      child: Material(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: StoreConnector<XgenriaState, _ViewModel>(
              builder: (BuildContext context, vm) {
                //
                final categories2 = vm.state.dashboard!.categories;
                final templates2 = vm.state.dashboard!.templates
                    .where(
                      (element) =>
                          element.categoryId == categories2[currentIndex].id,
                    )
                    .toList();
                //
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Templates',
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SvgPicture.asset(
                            'asset/images/logo.svg',
                            width: 40,
                            height: 40,
                            color: Theme.of(context).colorScheme.tertiary,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: vm.state.dashboard!.categories.length,
                        itemBuilder: (context, index) => Center(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              currentIndex = index;
                            }),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: index == currentIndex
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context)
                                          .colorScheme
                                          .surfaceTint,
                                ),
                                child: Text(
                                  vm.state.dashboard!.categories[index].name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: templates2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x7F464646)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(categories2[currentIndex].emoji),
                                  const SizedBox(height: 10),
                                  Text(
                                    templates2[index].name,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    templates2[index].prompt.toString().length >
                                            50
                                        ? templates2[index]
                                                .prompt
                                                .toString()
                                                .substring(0, 50) +
                                            '...'
                                        : templates2[index].prompt.toString(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
              converter: (Store<XgenriaState> store) => _ViewModel(store),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final DataState state;
  final Store<XgenriaState> _store;

  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        state = store.state.dataState;

  void dispatch(DataStateAction action) => _store.dispatch(action);
}
