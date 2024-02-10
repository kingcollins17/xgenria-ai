// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:xgenria/widgets/progress_bar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'asset/svgs/undraw_pic_profile_re_7g2h.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anders Booker',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'andersbrooker@gmail.com',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Text('My ')
              Wrap(
                spacing: 4,
                runSpacing: 5,
                children: [
                  ...List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 2),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                constraints: BoxConstraints(minHeight: 100),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Color(0xFF292929),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AI Studio',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '1 Total Document',
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                                      const SizedBox(height: 10),
                                      ProgressBar(),
                                      const SizedBox(height: 10),
                                      Text(
                                        '935 words available',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      )
                                    ])),
                          ))
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Projects',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  ...List.generate(
                      5,
                      (index) => Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 120,
                                constraints: BoxConstraints(
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2C2C2C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.grey,
                                              )),
                                          child: Icon(
                                            Icons.folder_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'My AI Project',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '10 items',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ))
                ]),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
      endDrawer: _Drawer(),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1B1B1B),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Upgrade Plan'),
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
          'Tools',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Divider(color: Color(0xFF363636)),
        _DrawerTile(data: Icons.folder_rounded, label: 'Create Project'),
        _DrawerTile(data: Icons.edit_note_rounded, label: 'Create Document'),
        _DrawerTile(data: Icons.photo_filter_rounded, label: 'Generate Image'),
        _DrawerTile(data: Icons.chat_rounded, label: 'Chat with Xgenria'),
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
                style:
                    GoogleFonts.poppins(fontSize: 16, color: Colors.redAccent),
              )
            ],
          ),
        )
      ]),
    );
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
