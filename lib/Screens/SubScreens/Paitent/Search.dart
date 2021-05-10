import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/AvalibleDoctors.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => Navigator.pop(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        tiles(
          "Fever",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "fever",
                ),
              ),
            );
          },
        ),
        tiles(
          "Headache",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "headache",
                ),
              ),
            );
          },
        ),
        tiles(
          "Cough",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "cough",
                ),
              ),
            );
          },
        ),
        tiles(
          "Covid 19",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "covid",
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget tiles(String text, Function func) {
    return ListTile(
      onTap: func,
      title: Text(text),
    );
  }
}
