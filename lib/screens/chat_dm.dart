// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/api/chat.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/core.dart';

class ChatDM extends ConsumerStatefulWidget {
  const ChatDM({super.key, required this.chat, required this.token});
  final ChatData chat;
  final AccessToken token;
  @override
  ConsumerState<ChatDM> createState() => _ChatDMState();
}

class _ChatDMState extends ConsumerState<ChatDM> {
  var chats = <ChatBubbleData>[];
  bool isLoading = true;
  bool isChatLoading = false;

  String? input;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    ChatAPI.messages(
      ref.read(dioProvider),
      widget.token,
      chatId: widget.chat.chatId,
    ).then((value) => setState(() {
          isLoading = false;
          chats = value.data ?? chats;
        }));
  }

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
                // 'XGenria Chat 1.0',
                widget.chat.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              Text(
                isChatLoading
                    ? 'AI Typing...'
                    : () {
                        var now = DateTime.now();
                        return '${now.day} ${[
                          'Jan',
                          'Feb',
                          'Mar',
                          'April',
                          'May',
                          'June',
                          'July',
                          'Aug',
                          'Sept',
                          'Oct',
                          'Nov',
                          'Dec'
                        ][now.month - 1]}'
                            ', ${now.year}';
                      }(),
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ]),
      ),
      body: StoreConnector<XgenriaState, _ViewModel>(
          converter: (store) => _ViewModel(store),
          builder: (context, vm) {
            return Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: isLoading
                        ? Center(
                            child: SpinKitRipple(
                              color: Theme.of(context).colorScheme.primary,
                              size: 50,
                            ),
                          )
                        : ListView.builder(
                            itemCount: chats.length + 1,
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                index >= chats.length
                                    ? SizedBox(height: 150)
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 15),
                                        child: _Bubble(data: chats[index])),
                          )),
                Positioned(
                    bottom: 0,
                    child: Center(
                      child: Container(
                        // height: 80,
                        constraints: BoxConstraints(minHeight: 60),
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFF1A1A1A),
                        ),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) => input = value,
                                controller: textController,
                                minLines: 1,
                                maxLines: 4,
                                enabled: !isChatLoading,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ask me anything',
                                    hintStyle: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        color: Color(0xFFB6B6B6))),
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                if (input != null && input!.isNotEmpty) {
                                  setState(() {
                                    chats.add(ChatBubbleData(
                                      role: 'user',
                                      content: input!,
                                      datetime: DateTime.now(),
                                    ));
                                    FocusScope.of(context).unfocus();
                                    textController.text = '';
                                    isChatLoading = true;
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeIn);
                                  });
                                  ChatAPI.talk(
                                          ref.read(dioProvider), vm.auth.token!,
                                          chatId: widget.chat.chatId,
                                          content: input!)
                                      .then((value) => value.status
                                          ? setState(() {
                                              final newChat = ChatBubbleData(
                                                  role: value.data!.role,
                                                  content: value.data!.content,
                                                  datetime: DateTime.now());

                                              chats.add(newChat);
                                              isChatLoading = false;

                                              scrollController.animateTo(
                                                  scrollController.offset + 100,
                                                  duration: const Duration(
                                                      milliseconds: 600),
                                                  curve: Curves.easeIn);
                                            })
                                          : null);
                                }
                              },
                              child: Icon(
                                Icons.send_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            );
          }),
    );
  }
}

class _ViewModel {
  final Store<XgenriaState> _store;
  final AuthState auth;
  _ViewModel(Store<XgenriaState> store)
      : _store = store,
        auth = store.state.auth;
  void dispatch(XgenriaAction action) => _store.dispatch(action);
}

class _Bubble extends StatefulWidget {
  const _Bubble({super.key, required this.data});
  final ChatBubbleData data;

  @override
  State<_Bubble> createState() => __BubbleState();
}

class __BubbleState extends State<_Bubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.data.role == 'assistant'
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: widget.data.role == 'assistant'
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.data.role == 'assistant')
              Image.asset(
                'asset/images/icon-6.png',
                width: 30,
                height: 30,
                // color: Theme.of(context).colorScheme.primary,
              ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: widget.data.role == 'assistant'
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.data.role == 'assistant'
                        ? Theme.of(context).colorScheme.primary
                        : Color(0xFF303030),
                  ),
                  child: Text(
                    widget.data.content,
                    style: GoogleFonts.quicksand(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    () {
                      return ((widget.data.datetime) ?? DateTime.now())
                          .toString()
                          .split(' ')
                          .last
                          .split(':')
                          .sublist(0, 2)
                          .join(':')
                          .toString();
                    }(),
                    style: GoogleFonts.quicksand(
                        fontSize: 14, color: Color(0xFFD1D1D1)),
                  ),
                )
              ],
            ),
            if (widget.data.role == 'user')
              SvgPicture.asset(
                'asset/svgs/undraw_pic_profile_re_7g2h.svg',
                width: 30,
                height: 30,
              )
          ],
        ),
      ),
    );
  }
}
