import 'package:flutter/material.dart';

class ChatBotCommands {
  final String botname = "Bot";

  List<String> illnessSuggestionList = <String>[
    "fever",
    "Cough",
    "Headache",
    "Backpain",
    "Runny Nose",
    "Hairfall",
    "Vomating",
    "Abdominal Pain",
  ];

  List<String> starterSuggestionList = <String>[
    "I Have Health Issues",
    "I am not feeling well",
  ];

  List<String> sug = <String>[];

  List suggestionList(int index) {
    if (index == 1) {
      return starterSuggestionList;
    } else if (index == 2) {
      return illnessSuggestionList;
    } else {
      return sug;
    }
  }

  List<String> checkAnswers(String userInput) {
    String u = userInput.toLowerCase();

    if (u == "hi" || u == "hello") {
      return <String>["Hello, how are you ?\nI am Bot, nice to meet you"];
    } else if (u == "i am fine" ||
        u == "fine" ||
        u == "good" ||
        u == "i am good") {
      return <String>["Then you Not needed a doctor, ThankYou :)"];
    } else if (u == "fever" ||
        u == "headache" ||
        u == "backpain" ||
        u == "fever" ||
        u == "runny nose" ||
        u == "hairfall" ||
        u == "Vomating") {
      return <String>[" "];
    } else if (u == "i have health issues") {
      return <String>["Please Select Below Issue you having"];
    } else {
      return <String>[
        "Sorry, i can't understand. Please check your question, or select below Suggestions"
      ];
    }
  }
}
