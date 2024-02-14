// ignore_for_file: unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/project.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/project_provider.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/menu.dart';

import '../widgets/confirm_action.dart';
import '../widgets/progress_bar.dart';

class XProject extends StatefulWidget {
  const XProject({super.key});

  @override
  State<XProject> createState() => _XProjectState();
}

class _XProjectState extends State<XProject> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Material(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: StoreConnector<XgenriaState, _ViewModel>(
                      converter: (store) => _ViewModel(store),
                      builder: (context, vm) {
                        return Consumer(builder: (context, ref, child) {
                          final projects = ref
                              .watch(projectNotifierProvider(vm.auth.token!));
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _HeaderLogo(),
                                const SizedBox(height: 30),
                                Text(
                                  'Start your Project',
                                  // textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Create and manage your Xgenria AI projects',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFFBBBBBB),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _SearchBar(),
                                const SizedBox(height: 20),
                                _AddProjectButton(),
                                const SizedBox(height: 20),
                                Text(
                                  'My Projects',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                _ProjectUI(projects: projects),
                              ]);
                        });
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF313131),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFB3B3B3),
            size: 20,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _AddProjectButton extends StatelessWidget {
  const _AddProjectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModal(context: context, builder: (context) => _CreateProjectUI());
      },
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              const Color(0xFF7BABFF)
            ])),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.add, size: 25),
          Text(
            'Add New Project',
            style: GoogleFonts.poppins(),
          )
        ]),
      ),
    );
  }
}

class _ProjectUI extends StatelessWidget {
  const _ProjectUI({
    super.key,
    required this.projects,
  });

  final AsyncValue<FetchProjectResponse> projects;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: projects.when(
          data: (data) => Column(
                  children: List.generate(
                // scrollDirection: Axis.horizontal,
                data.data?.length ?? 0,
                (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Center(
                    child: Container(
                      // height: 140,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 4,
                              color: Color(0xFF202020))
                        ],
                        color: const Color(0xFF1F1F1F),
                      ),
                      child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0x379E9E9E),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.folder,
                                size: 10,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              data.data![index].name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Consumer(builder: (context, ref, child) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: StoreConnector<XgenriaState,
                                          _ViewModel>(
                                      converter: (store) => _ViewModel(store),
                                      builder: (context, vm) {
                                        return GestureDetector(
                                          onTap: () => showModal<bool>(
                                            context: context,
                                            builder: (context) => ConfirmAction(
                                              message:
                                                  'Are you sure you want to delete project '
                                                  '${data.data![index].name} and all resources under it',
                                            ),
                                          ).then((value) => value == true
                                              ? ref
                                                  .read(projectNotifierProvider(
                                                          vm.auth.token!)
                                                      .notifier)
                                                  .delete(
                                                    vm.auth.token!,
                                                    data.data![index].projectId,
                                                  )
                                              : null),
                                          child: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            size: 20,
                                          ),
                                        );
                                      }),
                                );
                              }),
                            ),
                            const SizedBox(width: 1),
                          ]),
                    ),
                  ),
                ),
              )),
          error: (error, stackTrace) => Text(
                'Unable to fetch projects right now',
                style: GoogleFonts.quicksand(fontSize: 16),
              ),
          loading: () => Center(
                child:
                    SpinKitRipple(color: Theme.of(context).colorScheme.primary),
              )),
    );
  }
}

class _CreateProjectUI extends ConsumerStatefulWidget {
  const _CreateProjectUI({super.key});

  @override
  ConsumerState<_CreateProjectUI> createState() => __CreateProjectUIState();
}

class __CreateProjectUIState extends ConsumerState<_CreateProjectUI> {
  bool isLoading = false;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0),
      body: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create a New Project',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                    'Use projects to group and manage your AI resources',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xFFB9B9B9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Project Name',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                  enabled: !isLoading,
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    border: UnderlineInputBorder(),
                  )),
            ),
            const SizedBox(height: 20),
            // FilledButton(onPressed: (){}, child: child)
            StoreConnector<XgenriaState, _ViewModel>(
                converter: (store) => _ViewModel(store),
                builder: (context, vm) {
                  return GestureDetector(
                    onTap: () {
                      if ((!isLoading) && name != null) {
                        setState(() {
                          isLoading = true;
                        });
                        ref
                            .read(projectNotifierProvider(vm.auth.token!)
                                .notifier)
                            .create(vm.auth.token!, name: name!)
                            .then((value) {
                          setState(() => isLoading = false);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 0.85),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ])),
                      child: Center(
                        child: isLoading
                            ? SpinKitThreeInOut(color: Colors.white, size: 20)
                            : Text('Create Project',
                                style: GoogleFonts.poppins(fontSize: 16)),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
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

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'asset/images/logo.svg',
              width: 45,
              height: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Text(
              'Xgenria AI',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFFDADADA),
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          'asset/svgs/undraw_profile_pic_re_iwgo.svg',
          width: 35,
          height: 35,
        )
      ],
    );
  }
}
