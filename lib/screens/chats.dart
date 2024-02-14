// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/chat.dart';
import 'package:xgenria/providers/chat_provider.dart';
import 'package:xgenria/providers/project_provider.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/core.dart';

import '../models/models.dart';
import '../redux/reducers/data_reducer.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
  });
  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final filters = <(String, int)>[
    ('All', 10),
    // ('Active', 12),
    // ('Work', 7),
    // ('Fun', 4),
    // ('Archived', 34)
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
              const SizedBox(height: 30),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4)),
                  child: StoreConnector<XgenriaState, _ViewModel>(
                      converter: (store) => _ViewModel(store),
                      builder: (context, vm) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.quicksand(
                                  fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(width: 3),
                            Text('4',
                                style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  color: Colors.white,
                                ))
                          ],
                        );
                      }),
                ),
              ),
              StoreConnector<XgenriaState, _ViewModel>(
                  converter: (store) => _ViewModel(store),
                  builder: (context, vm) {
                    final chats =
                        ref.watch(chatNotifierProvider(vm.auth.token!));
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: chats.when(
                            data: (data) => data.data == null
                                ? Center(
                                    child: Text(data.message,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        )))
                                : Column(
                                    children: List.generate(
                                      data.data!.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: _ChatTileUI(
                                            chat: data.data![index],
                                            token: vm.auth.token!),
                                      ),
                                    ),
                                  ),
                            error: (error, stackTrace) => Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Text(
                                    'We are unable to load your chats right now',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                            loading: () => Center(
                                  child: SpinKitRipple(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 40),
                                )),
                      ),
                    );
                  }),
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

class _ChatTileUI extends StatefulWidget {
  const _ChatTileUI({
    super.key,
    required this.chat,
    required this.token,
  });

  final ChatData chat;
  final AccessToken token;

  @override
  State<_ChatTileUI> createState() => _ChatTileUIState();
}

class _ChatTileUIState extends State<_ChatTileUI> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        '/chatbox',
        arguments: (widget.chat, widget.token),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF111111),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF141414),
              offset: Offset(1, 4),
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              child: Icon(
                Icons.chat_bubble_rounded,
                size: 10,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '${widget.chat.totalMessages} messages',
                  style:
                      GoogleFonts.quicksand(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Consumer(builder: (context, ref, child) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => isLoading = true);
                      ref
                          .read(chatNotifierProvider(widget.token).notifier)
                          .delete(widget.chat.chatId)
                          .then((value) => setState(() => isLoading = false));
                    },
                    child: isLoading
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: SpinKitPulse(
                                color: Theme.of(context).colorScheme.secondary,
                                duration: Duration(seconds: 2),
                                size: 20),
                          )
                        : Icon(
                            Icons.delete,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final Store<XgenriaState> _store;
  final DataState data;
  final AuthState auth;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        data = store.state.data,
        auth = store.state.auth;
  void dispatch(XgenriaAction action) => _store.dispatch(action);
}

class CreateChat extends ConsumerStatefulWidget {
  const CreateChat({super.key});
  @override
  ConsumerState<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends ConsumerState<CreateChat> {
  String? chatName;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: StoreConnector<XgenriaState, _ViewModel>(
                converter: (store) => _ViewModel(store),
                builder: (context, vm) {
                  final projects =
                      ref.watch(projectNotifierProvider(vm.auth.token!));
                  return Column(children: [
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
                    Image.asset('asset/images/icon-6.png',
                        width: 150, height: 150),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Chat Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (value) => chatName = value,
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
                    projects.when(
                        data: (data) {
                          return DropdownButtonFormField(
                            // value: 1,
                            items: [
                              ...List.generate(
                                data.data!.length,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(
                                    data.data![index].name,
                                    style: GoogleFonts.quicksand(fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                            onChanged: (value) {},
                          );
                        },
                        error: (Object error, StackTrace stackTrace) =>
                            Center(),
                        loading: () => Center()),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isLoading = true);
                          ref
                              .read(
                                  chatNotifierProvider(vm.auth.token!).notifier)
                              .create(chatName!)
                              .then((id) {
                            if (id != null) {
                              Navigator.of(context)
                                  .popAndPushNamed('/chatbox', arguments: (
                                ref
                                    .read(chatNotifierProvider(vm.auth.token!))
                                    .asData!
                                    .value
                                    .data!
                                    .firstWhere(
                                        (element) => element.chatId == id),
                                vm.auth.token!
                              ));
                            }
                            setState(() => isLoading = false);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ])),
                          child: isLoading
                              ? SpinKitThreeInOut(color: Colors.white, size: 20)
                              : Text(
                                  'Create chat',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 0)
                  ]);
                }),
          ),
        ),
      ),
    );
  }
}
