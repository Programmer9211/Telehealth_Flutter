class ChatBotCommands {
  final String botname = "Bot";

  List<String> illnessSuggestionList = <String>[
    "fever",
    "Headache",
  ];

  List<List<String>> headacheList = [
    [
      "I feel like headache",
      "I am suffering from headache",
      "I have got headache",
      "I have a headache",
      "Yes, I have headache"
    ],
    [
      "Yes, I have acidity",
      "Yes",
      "I am suffering from acidity too",
      "I also have problem of acidity"
    ],
    [
      "Yes, I have taken stale food",
      "Yes, I have taken stale food last night",
    ],
  ];

  List<List<String>> feverList = [
    [
      "I feel like fever",
      "I am suffering from fever",
      "I have fever",
      "I have got fever",
      "I have been suffering from fever since yesterday",
    ],
    [
      "Yes, I have headache",
      "Yes",
      "I am suffering from headache and shivering",
      "I also have problem of headache",
      "I am suffering from weakness",
    ],
  ];

  List<String> starterSuggestionList = <String>[
    "I Have Health Issues",
    "I am not feeling well",
  ];

  List suggestionList(int index, int listIndex, int selectedList) {
    if (index == 1) {
      return starterSuggestionList;
    } else {
      if (index == 2) {
        return illnessSuggestionList;
      } else {
        if (selectedList == 0) {
          if (feverList.length < listIndex) {
            return null;
          } else {
            return feverList[listIndex];
          }
        } else {
          if (headacheList.length < listIndex) {
            return null;
          } else {
            return headacheList[listIndex];
          }
        }
      }
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
    } else if (u == "fever" || u == "headache") {
      return <String>[
        "Please select below options which describe your disease best"
      ];
    } else if (u == "i feel like headache" ||
        u == "i am suffering from headache" ||
        u == "i have got headache" ||
        u == "i have a headache" ||
        u == "yes, I have headache") {
      return <String>[
        "Do you drink lot of water.\nAre you taking stress of something?\nDo you have a problem of acidity?"
      ];
    } else if (u == "yes, i have taken stale food" ||
        u == "yes, i have taken stale food last night") {
      return <String>[
        "Ok, This report is submitted to doctor for further medication. Thank you."
      ];
    } else if (u == "yes, i have acidity" ||
        u == "yes" ||
        u == "i am suffering from acidity too" ||
        u == "i also have problem of acidity") {
      return <String>["Have you ate stale food?\nDo you take stale food?"];
    } else if (u == "i have health issues") {
      return <String>["Please Select Below Issue you having"];
    } else {
      return <String>[
        "Sorry, i can't understand. Please check your question, or select below Suggestions"
      ];
    }
  }
}
