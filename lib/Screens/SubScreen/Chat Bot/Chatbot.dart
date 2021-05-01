import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreen/Chat%20Bot/ChatBotCommand.dart';

class ChatBot extends StatefulWidget {
  final Function openDrawer;

  ChatBot({this.openDrawer});

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ChatBotCommands _botCommands = ChatBotCommands();
  final TextEditingController _message = TextEditingController();

  List<ChatModel> message;
  ScrollController _scrollController = ScrollController();
  int indx = 1;

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
    });
  }

  void scroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            appBar(size),
            chatmessagebuilder(size),
            buildSuggestions(size),
            messageController(size),
          ],
        ),
      ),
    );
  }

  Widget buildSuggestions(Size size) {
    return Container(
      height: size.height / 20,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _botCommands.suggestionList(indx).length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  message.add(
                    ChatModel(
                      isFromMe: true,
                      message: _botCommands.suggestionList(indx)[index],
                    ),
                  );
                  scroll();
                  String reply = _botCommands.checkAnswers(
                      _botCommands.suggestionList(indx)[index])[0];
                  Timer(Duration(milliseconds: 200), () {
                    message.add(ChatModel(isFromMe: false, message: reply));
                    setState(() {});
                    scroll();
                  });
                  indx = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _botCommands.suggestionList(indx)[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget messageController(Size size) {
    return Container(
      height: size.height / 10.5,
      width: size.width,
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _message,
            decoration: InputDecoration(hintText: "Send Message"),
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_message.text.isNotEmpty) {
                message.add(ChatModel(isFromMe: true, message: _message.text));
                setState(() {});
                scroll();
                String reply = _botCommands.checkAnswers(_message.text)[0];
                Timer(Duration(milliseconds: 200), () {
                  message.add(ChatModel(isFromMe: false, message: reply));
                  setState(() {});
                  scroll();
                });

                _message.clear();
              }
            },
          )
        ],
      ),
    );
  }

  Widget chatmessagebuilder(Size size) {
    return Container(
      height: size.height / 1.45,
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

  Widget appBar(Size size) {
    return Container(
      height: size.height / 12,
      width: size.width,
      color: Colors.blue[100],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: widget.openDrawer,
              child: Icon(Icons.menu),
            ),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Chat Bot",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.settings)
        ],
      ),
    );
  }
}

class ChatModel {
  String message;
  bool isFromMe;
  ChatModel({this.isFromMe, this.message});
}
