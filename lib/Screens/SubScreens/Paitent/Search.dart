import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/AvalibleDoctors.dart';

class Search extends SearchDelegate {
  List<String> data = [
    "ent",
    "dermatologist",
    "infectious disease",
    "allergist",
  ];

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
    if (query != null && data.contains(query.toLowerCase())) {
      return tiles(
        query,
        () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AvalibleDoctors(
                category: query,
              ),
            ),
          );
        },
      );
    } else {
      return Text("No result Found");
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        tiles(
          "ent",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "ent",
                ),
              ),
            );
          },
        ),
        tiles(
          "Allergist",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "Allergist",
                ),
              ),
            );
          },
        ),
        tiles(
          "Dermatologist",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "Dermatologist",
                ),
              ),
            );
          },
        ),
        tiles(
          "Infectious Disease",
          () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(
                  category: "Infectious Disease",
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
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
