import 'package:flutter/material.dart';
import 'models/explore_recipe.dart';
import 'components/components.dart';
import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),

    // Card1(
    //     recipe: ExploreRecipe(
    //         authorName: 'Ray Wenderlich',
    //         title: 'The Art of Dough',
    //         subtitle: 'Editor\'s Choice',
    //         message: 'Learn to make the perfect bread.',
    //         backgroundImage: 'assets/magazine_pics/card_bread.jpg')),
    // Card2(
    //     recipe: ExploreRecipe(
    //         authorName: 'Mike Katz',
    //         role: 'Smoothie Connoisseur',
    //         profileImage: 'assets/profile_pics/person_katz.jpeg',
    //         title: 'Recipe',
    //         subtitle: 'Smoothies',
    //         backgroundImage: 'assets/magazine_pics/mag2.png')),

    // Card3(
    //     recipe: ExploreRecipe(
    //         title: 'Vegan Trends',
    //         tags: [
    //           'Healthy',
    //           'Vegan',
    //           'Carrots',
    //           'Greens',
    //           'Wheat',
    //           'Pescetarian',
    //           'Mint',
    //           'Lemongrass',
    //           'Salad',
    //           'Water'
    //         ],
    //         backgroundImage: 'assets/magazine_pics/mag3.png')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFFFFC107);
    // return Consumer<TabManager>(builder: context, tabManager, child){}
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Container(
            color: Colors.amber[600],
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchRecipe());
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        backgroundColor: primaryColor,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Colors.amber,
            ),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: Colors.amber,
            ),
            label: 'Recipes',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.amber,
            ),
            label: 'To Buy',
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.amber,
          //   ),
          //   label: 'Search',
          // ),
        ],
      ),
    );
  }
}
