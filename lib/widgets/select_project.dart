// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/project_provider.dart';
import 'package:xgenria/redux/core.dart';

class SelectProjectInput extends ConsumerStatefulWidget {
  const SelectProjectInput({
    this.onChanged,
    super.key,
  });
  final void Function(ProjectData data)? onChanged;
  @override
  ConsumerState<SelectProjectInput> createState() => _SelectProjectInputState();
}

class _SelectProjectInputState extends ConsumerState<SelectProjectInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Project',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        StoreConnector<XgenriaState, _ViewModel>(
            converter: (store) => _ViewModel(store),
            builder: (context, vm) {
              final _projects = ref.watch(
                projectNotifierProvider(vm.auth.token!),
              );
              return _projects.when(
                  error: (error, stackTrace) => Center(),
                  loading: () => Center(),
                  data: (data) => data.data == null
                      ? Center()
                      : Container(
                          decoration: BoxDecoration(color: Color(0xFF242424)),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButtonFormField<int>(
                              // value: data.data!.length,
                              items: [
                                ...List.generate(
                                  data.data!.length,
                                  (index) => DropdownMenuItem(
                                      value: index,
                                      child: Text(
                                        data.data![index].name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      )),
                                )
                              ],
                              onChanged: (value) =>
                                  value == null || widget.onChanged == null
                                      ? null
                                      : widget.onChanged!(data.data![value])),
                        ));
            }),
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
