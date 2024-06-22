import 'dart:convert';
import 'package:battleships/utils/sessionmanager.dart';
import 'package:battleships/views/game_screen.dart';
import 'package:battleships/views/login_screen.dart';
import 'package:battleships/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GamesListPage extends StatefulWidget {
  final String baseUrl = 'http://165.227.117.48/games';
  final bool isActive;
  final List<int> statusList;
   

  GamesListPage({Key? key, required this.isActive}) :
    statusList = isActive ? [0,3] : [1,2],
    super(key: key); 

  @override
  State createState() => _GamesListPageState();
}


class _GamesListPageState extends State<GamesListPage> {
  Future<List<dynamic>>? futureGames;
  String? userName;

  @override
  void initState() {
    super.initState();
    loadUserName();
    futureGames = _loadGames();
  }

 Future<void> loadUserName() async {
    String sessionUserName = await SessionManager.getSessionUserName();
    setState(() {
      userName = sessionUserName;
      
    });
  }

 Future<List<dynamic>> _loadGames() async {
  List<dynamic> games = [];
  
    final response = await http.get(Uri.parse(widget.baseUrl),    
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await SessionManager.getSessionToken()}',
      },
    );
        

    if (response.statusCode == 200) {
      final games = json.decode(response.body)['games'];
      return games;}      
    else if (response.statusCode == 401) {
      _doLogout();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
    return games;
  }
  



  Future<void> _refreshGames() async {
    setState(() {
      futureGames = _loadGames();  
    });
  }



  Future<String> _deleteGame(int id) async {
   final response =  await http.delete(Uri.parse('${widget.baseUrl}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await SessionManager.getSessionToken()}',
      },
    );
    String message = "";
    final deletion = json.decode(response.body);
    if (response.statusCode == 200) {
      if (deletion['message'] != null) {
        message = deletion['message'];
      }
    } else if (response.statusCode == 401) {
      _doLogout();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(deletion['error'])),
      );
    }
    _refreshGames();
    return message;    
  }

  Future<void> _doLogout() async {
    // get rid of the session token
    await SessionManager.clearSession();

    if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(      
        builder: (_) => const LoginScreen(),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isActive ? const Text("Active Games") : const Text("Completed Games"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshGames(),
          ),

        ],
      ),
      drawer: widget.isActive ? Menu(activepage: false) : Menu(activepage: true),
      body: FutureBuilder<List<dynamic>>(
        
        future: futureGames,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final game = snapshot.data![index];
                int status = game['status'];

// data preparation for display from response

                String gameInfo = "";

                if (game['player2'] == null) {
                  gameInfo = 'Waiting for opponent';
                 
                } else {
                   gameInfo = '${game['player1']} Vs ${game['player2']}';
                }
                String gameStatus = "";

                switch(status){
                case 0:               
                  gameStatus = "Matchmaking";
                  break;

                case 3:
                 if ((game['turn'] == 1 && game['player1'] == userName ||
                        game['turn'] == 2 && game['player2'] == userName) &&
                    userName != null) 
                    {gameStatus = "My turn"; }
                  else {gameStatus = "Opp turn";}
                  break;

                case 1:
                  if (game['player1'] == userName)
                     { gameStatus = 'Won'; } 
                  else {gameStatus = 'Lost';}
                  break;

                case 2:
                  if (game['player2'] == userName)
                     { gameStatus = 'Won'; } 
                  else {gameStatus = 'Lost';}
                  break;

                } 

// Display based on the otion chose - Active/Completed Games

                if (widget.statusList.contains(status)){
                return Dismissible(
                  key: Key(game['id'].toString()),
                  onDismissed: (_) async {
                    snapshot.data!.removeAt(index);
                    final message = await _deleteGame(game['id']);
                    if (message == "Game forfeited") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Game forfeited")),
                      );
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: ListTile(
                    title: Center(child: Row 
                    (mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: 
                    [
                      Text(game['id'].toString()),
                      Expanded(child: 
                      Text(gameInfo,textAlign: TextAlign.center)                      
                      ),
                      Text(gameStatus)],) 
                  ),
                  onTap: () =>     Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) {
                                   return GameScreen(gameId: game['id']);}),
                                   ).then((value) {_refreshGames();}) 
                  )
                );
                }
                else { return Container();}

              },
            );
          } else if (snapshot.hasError) {           
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}
