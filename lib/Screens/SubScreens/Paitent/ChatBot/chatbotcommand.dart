class ChatBotCommands {
  List<String> disease = [
    "I am suffering from cough",
    "I am suffering from cold",
    "I am suffering from headache",
    "I am suffering from fever"
  ];

  List<List<String>> cough = [
    [
      "Yes..",
      "No..",
      "I am suffering from flue too.",
    ],
    [
      "Yes...",
      "No...",
    ],
    [
      "Yes, I have sneezing",
      "Yes, I have body aches",
      "Yes, both",
      "No,",
    ]
  ];

  List<List<String>> cold = [
    [
      "Yes",
      "No",
      "I am suffering from chest pain too",
    ],
    [
      "Yes, I have dry cough",
      "Yes, I have wet cough",
    ],
    [
      "Yes, at work one employee having same problem",
      "Yes, family member is also suffering from same",
      "No",
    ],
    ["Yes.", "No."],
  ];

  List<List<String>> fever = [
    [
      "I feel like fever",
      "I am suffering from fever",
      "I have been suffering from fever since yesterday"
    ],
    [
      "I am suffering from headache and shivering",
      "I also have problem of headache",
      "I am suffering from weakness"
    ],
  ];

  List<List<String>> headache = [
    [
      "I feel like headache",
      "Yes, I have headache",
    ],
    [
      "Yes, I have acidity",
      "I am suffering from acidity too",
      "I also have problem of acidity",
    ],
    ["Yes, I have taken stale food", "Yes, I have taken stale food last night"]
  ];

  List<String> filterList(int index, String mess, int listIndex) {
    if (index == 0) {
      return disease;
    } else {
      String i = mess.toLowerCase();

      if (i == "i am suffering from cough") {
        if (cough.length >= listIndex) {
          return cough[listIndex];
        } else {
          return <String>[];
        }
      }

      //

      else if (i == "i am suffering from cold") {
        if (cold.length >= listIndex) {
          return cold[listIndex];
        } else {
          return <String>[];
        }
      }

      //

      else if (i == "i am suffering from headache") {
        if (headache.length >= listIndex) {
          return headache[listIndex];
        } else {
          return <String>[];
        }
      }

      //

      else {
        if (fever.length >= listIndex) {
          return fever[listIndex];
        } else {
          return <String>[];
        }
      }
    }
  }

  String responses(String input) {
    String i = input.toLowerCase();

    if (i == "i feel like headache" || i == "yes, i have headache") {
      return "Do you have a problem of acidity?";
    }

    //

    else if (i == "i am suffering from cough") {
      return "Beside this, do you have any other health problems.";
    }

    //

    else if (i == "i am suffering from cold") {
      return "Beside this, do you have any other health problems.";
    }

    //

    else if (i == "i am suffering from headache") {
      return "Tell us about your symptoms";
    }

    //

    else if (i == "i am suffering from fever") {
      return "Tell us about your symptoms";
    }

    //

    else if (i == "yes, i have acidity" ||
        i == "i am suffering from acidity too" ||
        i == "i also have problem of acidity") {
      return "Have you ate stale food?";
    }

    //

    else if (i == "yes, i have taken stale food" ||
        i == "yes, i have taken stale food last night") {
      return "Ok, This report is submitted to doctor for further medication.Thank you.";
    }

    //

    else if (i == "i feel like fever" ||
        i == "i am suffering from fever" ||
        i == "i have been suffering from fever since yesterday") {
      return "Do you have any other symptoms?\nAre you suffering from any other disease?";
    }

    //

    else if (i == "i am suffering from headache and shivering" ||
        i == "i also have problem of headache" ||
        i == "i am suffering from weakness") {
      return "Ok, This report is submitted to doctor for further medication.Thank you.";
    }

    //

    else if (i == "yes" ||
        i == "no" ||
        i == "i am suffering from chest pain too") {
      return "Do you have a problem of dry cough or wet cough?";
    }

    //

    else if (i == "yes, i have dry cough" || i == "yes, i have wet cough") {
      return "Does someone at work or in your home have same cough?";
    }

    //

    else if (i == "yes, at work one employee having same problem" ||
        i == "yes, family member is also suffering from same") {
      return "Are you allergic to anything?";
    }

    //

    else if (i == "yes." || i == "no.") {
      return "Ok, This report is submitted to doctor for further medication.Thank you.";
    }

    //

    else if (i == "yes.." ||
        i == "no.." ||
        i == "i am suffering from flue too.") {
      return "Do you have a runny or stuffy nose?";
    }

    //

    else if (i == "yes..." || i == "no...") {
      return "Do you have sneezing, body aches?";
    }

    //

    else if (i == "yes, i have sneezing" ||
        i == "yes, i have body aches" ||
        i == "yes, both" ||
        i == "no,") {
      return "Ok, This report is submitted to doctor for further medication.Thank you.";
    }

    //

    else {
      return "Sorry, I dont't understand";
    }
  }
}
