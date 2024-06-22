import 'package:flutter/material.dart';
import 'package:mp5/views/favorites_page.dart';
import 'package:mp5/views/home.dart';
import 'package:mp5/views/search_history.dart';
import 'package:mp5/views/search.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: const Key("Drawer"),
        shadowColor: Colors.orange,
        backgroundColor: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String>(builder: (context) {return const Home();}),  );  
              },
            ),

            
            ListTile(
              key: const Key("FavoriteKey"),
              leading: const Icon(Icons.star),
              title: const Text('Favorites'),
              onTap: () {
              Navigator.of(context).push(
                      MaterialPageRoute<String>(builder: (context) {return const FavoritesPage();}),); 
               }             
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Search History'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String>(builder: (context) {return const SearchHistory();}),);  
              },
            )

          ],
        ));
  }
}