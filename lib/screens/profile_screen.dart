// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/api/dash_board.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/widgets/confirm_action.dart';
import 'package:xgenria/widgets/progress_bar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, this.onDrawerChanged});
  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
  final void Function(bool isOpened)? onDrawerChanged;
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<XgenriaState, _ViewModel>(
        converter: (store) => _ViewModel(store),
        builder: (context, vm) {
          final user = ref.watch(userProvider(vm.auth.token!));
          final dashboard = ref.watch(dashboardProvider(vm.auth.token!));
          final plans = ref.watch(planProvider(vm.auth.token!));

          // ({UserData? data, String message, bool status})
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
                      data: (data) => data.data == null
                          ? GestureDetector(
                              onTap: () => ref.invalidate(userProvider),
                              child: Text(
                                'Tap to refresh',
                                style: GoogleFonts.quicksand(fontSize: 16),
                              ),
                            )
                          : Column(
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
                            child: SpinKitThreeInOut(
                              size: 15,
                              color: Colors.white,
                            ),
                          ))
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: user.when(
                      data: (userData) => Center(
                            child: plans.when(
                                data: (planData) => dashboard.when(
                                    data: (data) => _AccountSummary(
                                          dashboard: data.data,
                                          userData: userData.data,
                                          plans: planData.data,
                                        ),
                                    error: (_, __) => Center(
                                          child: Text(
                                            'Please check your internet connection and try again',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16),
                                          ),
                                        ),
                                    loading: () => Center(
                                          child: SpinKitRipple(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        )),
                                error: (_, __) => Center(),
                                loading: () => Center()),
                          ),
                      error: (_, __) => Center(),
                      loading: () => Center())),
            ),
            endDrawer: _Drawer(),
            onEndDrawerChanged: widget.onDrawerChanged,
          );
        });
  }
}

class _AccountSummary extends StatelessWidget {
  const _AccountSummary({
    super.key,
    required this.dashboard,
    required this.userData,
    required this.plans,
  });

  final DashboardData? dashboard;
  final UserData? userData;
  final List<PlanData>? plans;

  @override
  Widget build(BuildContext context) {
    if (dashboard != null && plans != null && userData != null) {
      final _currentPlan = plans!.firstWhere(
        (element) => element.planId == (int.tryParse(userData!.planId!) ?? 2),
      );
      final info = <(String, String, String, String)>[
        (
          'AI Studio',
          '${dashboard!.totalDocuments} Total Documents',
          (_currentPlan.name == 'Elite'
              ? 'Unlimited Documents'
              : '${_currentPlan.planSettings.documentsLimit} Documents'),
          '/doc-list',
        ),
        (
          'Images',
          '${dashboard!.images.length} Total Images',
          (_currentPlan.name == 'Elite'
              ? 'Unlimited Images'
              : '${_currentPlan.planSettings.imagesPerMonthLimit} left'),
          '/image-history'
        ),
        (
          'Transcriptions',
          '${dashboard!.transcriptions.length} Total transcriptions',
          (_currentPlan.name == 'Elite'
              ? 'Unlimited Transcriptions'
              : '${_currentPlan.planSettings.transcriptionsPerMonthLimit} left'),
          '/trans-list'
        ),
        (
          'AI Chats',
          '',
          (_currentPlan.name == 'Elite'
              ? 'Unlimited AI Chats'
              : '${_currentPlan.planSettings.chatsPerMonthLimit} left'),
          '/chats'
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
                    child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed(info[index].$4),
                        child: _DetailBox(info: info[index])),
                  ))
        ],
      );
    }

    return Center(
        child: Text(
      'Unable to fetch your details at this moment',
      style: GoogleFonts.poppins(
        fontSize: 16,
      ),
    ));
  }
}

class _DetailBox extends StatelessWidget {
  const _DetailBox({
    super.key,
    required this.info,
  });

  final (String, String, String, String) info;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 100,
          minWidth: MediaQuery.of(context).size.width * 0.4,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Color(0xFF292929),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(2, 4),
                color: Color(0xA6000000),
              )
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            info.$1,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            info.$2,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          const SizedBox(height: 4),
          // ProgressBar(),
          // const SizedBox(height: 10),
          Text(
            info.$3,
            style: GoogleFonts.poppins(
              fontSize: 12,
            ),
          )
        ]));
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
          final plans = ref.watch(planProvider(vm.auth.token!));
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height,
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
              user.when(
                  data: (userData) => userData.data == null
                      ? Center()
                      : GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed('/plan'),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF292929),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Plans and Pricing'),
                                      Icon(Icons.diamond_sharp,
                                          color: Color(0xFFE3FF44)),
                                    ]),
                                Text(
                                  'Current Plan: ' +
                                      plans.when(
                                          data: (data) {
                                            if (int.tryParse(
                                                    userData.data?.planId ??
                                                        'Free') !=
                                                null) {
                                              var _currentPlan = data.data!
                                                  .firstWhere((element) =>
                                                      element.planId ==
                                                      int.tryParse(
                                                        userData.data!.planId!,
                                                      ));
                                              return _currentPlan.name;
                                            }

                                            return userData.data!.planId
                                                .toString();
                                          },
                                          error: (_, __) => '',
                                          loading: () => ' '),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  error: (_, __) => Text(
                        'Unable to load user data!, please check your internet connection and try again',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                  loading: () =>
                      SpinKitThreeInOut(color: Colors.white, size: 15)),
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
              Divider(color: Color(0xFF4E4E4E)),
              TextButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/change-password'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  icon: Icon(Icons.lock_outline_rounded, size: 25),
                  label: Text(
                    'Change password',
                    style: GoogleFonts.poppins(fontSize: 14),
                  )),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModal<bool>(
                            context: context,
                            builder: (context) {
                              return ConfirmAction(
                                  message: 'Are you sure you want to logout');
                            }).then((value) {
                          if (value == true) {
                            vm.dispatch(
                                AuthAction(type: AuthActionType.logout));
                            Navigator.popAndPushNamed(context, '/auth');
                          }
                          return null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF353535),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showModal<String>(
                            context: context,
                            builder: (context) {
                              return DeleteAccountConfirmation();
                            }).then((password) {
                          if (password != null) {
                            // Navigator.popAndPushNamed(context, '/auth');
                            AuthAPI.deleteAccount(ref.read(dioProvider),
                                    vm.auth.token!, password)
                                .then((value) {
                              if (value.status) {
                                vm.dispatch(
                                    AuthAction(type: AuthActionType.logout));
                                Navigator.of(context).popAndPushNamed('/auth');
                              }
                            });
                          }
                          return null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x30E90F0F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ]),
          );
        });
  }
}

class DeleteAccountConfirmation extends StatefulWidget {
  const DeleteAccountConfirmation({super.key});

  @override
  State<DeleteAccountConfirmation> createState() =>
      _DeleteAccountConfirmationState();
}

class _DeleteAccountConfirmationState extends State<DeleteAccountConfirmation> {
  String? password;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            constraints: BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(color: Color(0xE20E0E0E)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Enter your password to delete your account',
                        style: GoogleFonts.poppins(fontSize: 14)),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelStyle: GoogleFonts.quicksand(),
                        hintText: 'Enter your password',
                        hintStyle: GoogleFonts.quicksand(fontSize: 14),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                        onPressed: () {
                          if (password != null) {
                            Navigator.pop(context, password);
                          }
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        icon: Icon(Icons.delete),
                        label: Text(
                          'Delete Account',
                          style: GoogleFonts.poppins(),
                        ))
                  ]),
            ),
          ),
        )));
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
