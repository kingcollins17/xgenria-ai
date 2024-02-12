// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});
  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final filters = <(String, int)>[
    ('Active', 12),
    ('Work', 7),
    ('Fun', 4),
    ('Archived', 34)
  ];
  final chats = [
    'The importance of Art: A conversation with ChatGPT',
    'Exploring the universe: A chat with ChatGPT about astronomy',
    'Mastering the Kitchen: A chat with ChatGPT about cooking and recipes'
  ];
  var selectedFilterIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'asset/images/logo.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      'Lets Chat with ',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Xgenria',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'AI',
                          style: GoogleFonts.poppins(
                              fontSize: 28, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  Icon(Icons.search_rounded, size: 20, color: Color(0xFFCACACA))
                ],
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: selectedFilterIndex == index
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            Text(
                              filters[index].$1,
                              style: GoogleFonts.quicksand(
                                  fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              filters[index].$2.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  color: selectedFilterIndex == index
                                      ? Colors.white
                                      : Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFF2B2B2B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(chats[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/create-chat');
        },
        child: Container(
          constraints:
              BoxConstraints(minHeight: 55, minWidth: 100, maxWidth: 130),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Chat'),
              const SizedBox(width: 4),
              Icon(Icons.add_rounded)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CreateChat extends ConsumerStatefulWidget {
  const CreateChat({super.key});
  @override
  ConsumerState<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends ConsumerState<CreateChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(children: [
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Create an AI Chat',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('asset/images/icon-6.png', width: 150, height: 150),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Chat Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFC7C7C7),
                )),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Project',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: 1,
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Project 1',
                    style: GoogleFonts.quicksand(fontSize: 14),
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Project 2',
                      style: GoogleFonts.quicksand(fontSize: 14)),
                )
              ],
              onChanged: (value) {},
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).pushNamed('/chatbox');
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ])),
                  child: Text(
                    'Create chat',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}

class ChatBox extends ConsumerStatefulWidget {
  const ChatBox({super.key});
  @override
  ConsumerState<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {
  final chats = [
    ('Hello, how can I be assist you Today?', true),
    ('How can i make a sweet margarita in under 5 mins', false),
    (
      'In order to make a sweet margarita in under five minutes'
          'here a few tips: You need to prepare your juice and keep'
          'Squeeze the lemon out of the fruits and make the tray bald ...',
      true
    ),
    ('How can i make a sweet margarita in under 5 mins', false),
    (
      'In order to make a sweet margarita in under five minutes'
          'here a few tips: You need to prepare your juice and keep'
          'Squeeze the lemon out of the fruits and make the tray bald ...',
      true
    ),
    ('Thank you, that was helpful', false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          SvgPicture.asset(
            'asset/images/logo.svg',
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'XGenria Chat 1.0',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              Text(
                DateTime.now().toString().split(' ').first,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ]),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                child: Align(
                  alignment: chats[index].$2
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (chats[index].$2)
                          Image.asset(
                            'asset/images/icon-6.png',
                            width: 30,
                            height: 30,
                            // color: Theme.of(context).colorScheme.primary,
                          ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: chats[index].$2
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: chats[index].$2
                                    ? Theme.of(context).colorScheme.primary
                                    : Color(0xFF303030),
                              ),
                              child: Text(
                                chats[index].$1,
                                style: GoogleFonts.quicksand(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                DateTime.now()
                                    .toString()
                                    .split(' ')
                                    .last
                                    .split(':')
                                    .sublist(0, 2)
                                    .join(':')
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                    fontSize: 14, color: Color(0xFFD1D1D1)),
                              ),
                            )
                          ],
                        ),
                        if (!chats[index].$2)
                          SvgPicture.asset(
                            'asset/svgs/undraw_pic_profile_re_7g2h.svg',
                            width: 30,
                            height: 30,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Center(
                child: Container(
                  // height: 80,
                  constraints: BoxConstraints(minHeight: 80),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A1A),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Ask me anything',
                              hintStyle: GoogleFonts.quicksand(
                                  fontSize: 16, color: Color(0xFFB6B6B6))),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.send_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 25,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
      endDrawer: Container(),
    );
  }
}
