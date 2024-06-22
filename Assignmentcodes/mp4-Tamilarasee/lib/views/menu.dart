import 'package:battleships/utils/sessionmanager.dart';
import 'package:battleships/views/games_list_page.dart';
import 'package:battleships/views/login_screen.dart';
import 'package:battleships/views/game_screen.dart';
import 'package:flutter/material.dart';

/// Very similar to main screen in eg2.dart, but with authentication.
class Menu extends StatefulWidget {
  bool activepage;
  Menu({super.key, required this.activepage});

  @override
  State createState() => _MenuState();
}

class _MenuState extends State<Menu> {
 
  void toggleGamesList() {
    setState(() {
      widget.activepage = !widget.activepage;
    });
  }

  Future<void> _doLogout(BuildContext context) async {
    await SessionManager.clearSession();
    if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(      
        builder: (_) => const LoginScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Battleships",
              textAlign: TextAlign.justify,
            ),
          ),
          ListTile(
            title: const Text("New Game Human"),            
            onTap: () {    
              Navigator.pop(context);   
              Navigator.of(context).push(MaterialPageRoute<String>
                (builder: (context) =>const  GameScreen(gameId: 0)),
                    );
            },
          ),
          Builder(
            builder: (context) => ExpansionTile(
              title: const Text("New Game (AI)"),
              children: [
                ListTile(
                  title: const Text("Random"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute<String>(
                      builder: (context) =>const  GameScreen(gameId: 0, aiGameType: 'Random')),
                    );
                    
                  },
                ),
                ListTile(
                  title: const Text("Perfect"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute<String>
                    (builder: (context) =>const GameScreen(gameId: 0, aiGameType: 'Perfect')),
                    );
                     
                  },
                ),
                ListTile(
                  title: const Text("One Ship AI"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute<String>(
                      builder: (context) => const GameScreen(gameId: 0, aiGameType: 'OneShip')),
                    );
                   
                  },
                ),
              ],
            ),
          ),
          widget.activepage ?
          ListTile(
             title:  Text ("Show Active Games"),           
            onTap: () {   
             Navigator.pop(context);           
             Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GamesListPage(isActive: true,))); 
            },
          ):
          ListTile(
            title:  Text ("Show Completed Games"),           
            onTap: () {              
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => GamesListPage(isActive: false,)));
            },
           
          ),
          ListTile(
            title: const Text("Log out"),
            onTap: () {
              Navigator.pop(context);              
               _doLogout(context);
              
            },
          )
        ],
      ),
    );
  }
}

