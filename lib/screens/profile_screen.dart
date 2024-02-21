// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/progress_bar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final user = ref.watch(userProvider(vm.auth.token!));
          final dashboard = ref.watch(dashboardProvider(vm.auth.token!));
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Row(
                children: [
                  SvgPicture.asset(
                    'asset/svgs/undraw_pic_profile_re_7g2h.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  user.when(
                      data: (data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.data!.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                data.data!.email,
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                      error: (_, __) => Center(child: Text('')),
                      loading: () => Center(
                            child: SpinKitRipple(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ))
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      // Text('My ')
                      dashboard.when(
                          data: (data) {
                            final info = <(String, String, String)>[
                              (
                                'AI Studio',
                                '${data.data!.totalDocuments} Total Documents',
                                ('${data.data!.availableWords} '
                                    'words available')
                              ),
                              (
                                'Images',
                                '${data.data!.images.length} Total Images',
                                '${data.data!.availableImages} images available'
                              ),
                              (
                                'Transcriptions',
                                '${data.data!.transcriptions.length} Total transcriptions',
                                '${data.data!.availableTranscriptions}'
                                    ' transcription available'
                              ),
                            ];
                            return Wrap(
                              spacing: 4,
                              runSpacing: 5,
                              children: [
                                ...List.generate(
                                    info.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0, vertical: 2),
                                          child: Container(
                                              constraints: BoxConstraints(
                                                minHeight: 100,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.42,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 15),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF292929),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      info[index].$1,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      info[index].$2,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    // ProgressBar(),
                                                    // const SizedBox(height: 10),
                                                    Text(
                                                      info[index].$3,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ])),
                                        ))
                              ],
                            );
                          },
                          error: (_, __) => Center(
                                child: Text('Pls refresh'),
                              ),
                          loading: () => Center(
                                child: SpinKitRipple(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )),

                      const SizedBox(height: 100)
                    ],
                  );
                }),
              ),
            ),
            endDrawer: _Drawer(),
          );
        });
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

class _Drawer extends ConsumerWidget {
  const _Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final user = ref.watch(userProvider(vm.auth.token!));
          return Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFF1B1B1B),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  SvgPicture.asset(
                    'asset/images/logo.svg',
                    width: 50,
                    height: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Xgenria AI',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xFF363636)),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pricing  & Plan'),
                          Icon(Icons.diamond_sharp, color: Color(0xFFE3FF44)),
                        ]),
                    Text(
                      'Current Plan: Free',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Creations',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Divider(color: Color(0xFF363636)),
              // _DrawerTile(data: Icons.folder_rounded, label: 'Create Project'),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/doc-list'),
                child: _DrawerTile(
                    data: Icons.edit_note_rounded, label: 'Created Documents'),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/trans-list'),
                child:
                    _DrawerTile(data: Icons.mic, label: 'All Transcriptions'),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/image-history'),
                child: _DrawerTile(
                    data: Icons.photo_filter_rounded,
                    label: 'Generated Images'),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/chats');
                  },
                  child: _DrawerTile(
                      data: Icons.chat_rounded, label: 'All AI Chats')),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF353535),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Log out',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0x30E90F0F),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Delete Account',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.redAccent),
                    )
                  ],
                ),
              )
            ]),
          );
        });
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    super.key,
    required this.data,
    required this.label,
  });
  final IconData data;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(data),
            const SizedBox(width: 5),
            Text(
              label,
              style:
                  GoogleFonts.poppins(fontSize: 14, color: Color(0xFFE9E9E9)),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
