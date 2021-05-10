import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Chat%20Bot/ChatBotCommand.dart';

class ChatBot extends StatefulWidget {
  final Function openDrawer;

  ChatBot({this.openDrawer});

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ChatBotCommands _botCommands = ChatBotCommands();
  //final TextEditingController _message = TextEditingController();

  List<ChatModel> message;
  ScrollController _scrollController = ScrollController();
  int indx = 1;
  int listIndex = 0;
  int tappedIndex = 0;

  @override
  void initState() {
    super.initState();
    message = <ChatModel>[];
    Timer(Duration(milliseconds: 400), () {
      message.add(ChatModel(
          isFromMe: false,
          message:
              "Hello, I am Bot\nI am here to help you\nType your quaries or Tap on listed quaries"));
      setState(() {});
      Timer(Duration(seconds: 1), () => showsheet(MediaQuery.of(context).size));
    });
  }

  void scroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void showsheet(Size size) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (_) {
          return Container(
            height: size.height / 3,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: buildSuggestions(size),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat Bot"),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                chatmessagebuilder(size),
                //messageController(size),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => showsheet(size),
        // ),
      ),
    );
  }

  Widget buildSuggestions(Size size) {
    return Container(
      height: size.height / 20,
      width: size.width,
      child: ListView.builder(
        itemCount: _botCommands.suggestionList(indx, listIndex, 1).length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  message.add(
                    ChatModel(
                      isFromMe: true,
                      message: _botCommands.suggestionList(
                          indx, listIndex, 1)[index],
                    ),
                  );
                  scroll();
                  String reply = _botCommands.checkAnswers(_botCommands
                      .suggestionList(indx, listIndex, 1)[index])[0];
                  Timer(Duration(milliseconds: 500), () {
                    message.add(ChatModel(isFromMe: false, message: reply));
                    setState(() {});
                    scroll();
                    if (_botCommands
                            .suggestionList(index, listIndex, 1)
                            .length >=
                        listIndex) {
                      Timer(Duration(seconds: 1), () {
                        showsheet(size);
                        print(_botCommands.suggestionList(
                            indx, listIndex, 1)[index]);
                      });
                    }
                  });
                  indx += 1;
                  if (indx > 3) {
                    setState(() {
                      listIndex += 1;
                    });
                  }
                });
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text(
                  _botCommands.suggestionList(indx, listIndex, 1)[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget messageController(Size size) {
  //   return Container(
  //     height: size.height / 10.5,
  //     width: size.width,
  //     child: Row(
  //       children: [
  //         Expanded(
  //             child: TextField(
  //           controller: _message,
  //           decoration: InputDecoration(hintText: "Send Message"),
  //         )),
  //         IconButton(
  //           icon: Icon(Icons.send),
  //           onPressed: () {
  //             if (_message.text.isNotEmpty) {
  //               message.add(ChatModel(isFromMe: true, message: _message.text));
  //               setState(() {});
  //               scroll();
  //               String reply = _botCommands.checkAnswers(_message.text)[0];
  //               Timer(Duration(milliseconds: 200), () {
  //                 message.add(ChatModel(isFromMe: false, message: reply));
  //                 setState(() {});
  //                 scroll();
  //               });
  //               _message.clear();
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  //}

  Widget chatmessagebuilder(Size size) {
    return Container(
      height: size.height / 1.1,
      width: size.width,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: message.length,
        itemBuilder: (context, index) {
          return messages(size, index);
        },
      ),
    );
  }

  Widget messages(Size size, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      alignment: message[index].isFromMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: message[index].isFromMe ? Colors.grey : Colors.blue[300],
        ),
        child: Text(
          message[index].message,
          style: TextStyle(
            fontSize: size.width / 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatModel {
  String message;
  bool isFromMe;
  ChatModel({this.isFromMe, this.message});
}
