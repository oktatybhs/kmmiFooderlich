import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRecipe extends SearchDelegate<String> {
  List<String> searchRecipe = [];

  void addSearchRecipe(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchRecipe = prefs.getStringList('searchRecipe') ?? [];
    searchRecipe.insert(0, value);
    await prefs.setStringList('searchRecipe', searchRecipe);
  }

  void getSearchRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchRecipe = prefs.getStringList('searchRecipe') ?? [];
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '') addSearchRecipe(query);
    return Center(
      child: Text(
        'Recipe Not Found',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getSearchRecipe();
    final count = searchRecipe.length > 10 ? 10 : searchRecipe.length;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history),
          title: Text(searchRecipe.elementAt(index)),
          trailing: Icon(Icons.north_west),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SearchRecipe extends StatefulWidget {
//   SearchRecipe({Key key}) : super(key: key);
//   @override
//   _SearchRecipe createState() => _SearchRecipe();
// }

// class _SearchRecipe extends State<SearchRecipe> {
//   Future<void> _showSearch() async {
//     final searchText = await showSearch<String>(
//       context: context,
//       delegate: SearchWithSuggestionDelegate(
//         onSearchChanged: _getRecentSearchesLike,
//       ),
//     );
//     await _saveToRecentSearches(searchText);
//   }

//   Future<List<String>> _getRecentSearchesLike(String keywords) async {
//     final pref = await SharedPreferences.getInstance();
//     final allSearches = pref.getStringList("recentSearches");
//     return allSearches.where((search) => search.startsWith(keywords)).toList();
//   }

//   Future<void> _saveToRecentSearches(String keywords) async {
//     if (keywords == null) return;
//     final pref = await SharedPreferences.getInstance();

//     Set<String> allSearches =
//         pref.getStringList("recentSearches")?.toSet() ?? {};
//     allSearches = {keywords, ...allSearches};
//     pref.setStringList("recentSearches", allSearches.toList());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xE5E5E5),
//         // shape:
//         //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         title: Text("Find Recipe"),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _showSearch,
//           ),
//         ],
//       ),
//     );
//   }
// }

// typedef OnSearchChanged = Future<List<String>> Function(String);

// class SearchWithSuggestionDelegate extends SearchDelegate<String> {
//   final OnSearchChanged onSearchChanged;

//   List<String> _Keywords = const [];

//   SearchWithSuggestionDelegate({String searchFieldLabel, this.onSearchChanged})
//       : super(searchFieldLabel: searchFieldLabel);

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => Navigator.pop(context),
//     );
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () => query = "",
//       ),
//     ];
//   }

//   @override
//   void showResults(BuildContext context) {
//     close(context, query);
//   }

//   @override
//   Widget buildResults(BuildContext context) => null;

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: onSearchChanged != null ? onSearchChanged(query) : null,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) _Keywords = snapshot.data;
//         return ListView.builder(
//           itemCount: _Keywords.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Icon(Icons.restore),
//               title: Text("${_Keywords[index]}"),
//               onTap: () => close(context, _Keywords[index]),
//               tileColor: Color(0xFFFFC107),
//               onLongPress: () => _Keywords.removeAt(index),
//             );
//           },
//         );
//       },
//     );
//   }
// }
