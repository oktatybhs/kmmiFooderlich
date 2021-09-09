import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:provider/provider.dart';
import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
        title: 'Fooderlich',
        theme: theme,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => TabManager()),
            ChangeNotifierProvider(
              create: (context) => GroceryManager(),
            ),
            ChangeNotifierProvider(create: (context) => GroceryManager())
          ],
          child: const Home(),
        ));
  }
}
