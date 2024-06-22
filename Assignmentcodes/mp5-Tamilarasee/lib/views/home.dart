import 'package:flutter/material.dart';
import 'package:mp5/models/newsgroup.dart';
import 'package:mp5/models/news.dart';
import 'package:mp5/views/menu.dart';
import 'package:mp5/views/search.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final url = "https://newsapi.org/v2/top-headlines";
  final apiKey = "ae99aa5d25194b29b1fbd256ddc8bf1d";

  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<NewsGroup?> newsSet;
  NewsGroup favSet = NewsGroup();

  @override
  void initState() {
    super.initState();
    _FavoriteNews();
  }


  Future<void> _loadData() async {
    newsSet = NewsGroup().fetchData(widget.url, widget.apiKey);
  }

  Future<void> _FavoriteNews() async {
    NewsGroup favList = await NewsGroup().getFavoriteNews();
    setState(() {
      favSet = favList;
    });
  }

    void reloadData() {
    setState(() {
      _loadData();
      _FavoriteNews();
    });
  }


  @override
  Widget build(BuildContext context) {
    
    final newsList = Provider.of<NewsGroup?>(context);

    if (newsList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("News Today", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () {
                reloadData();
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String>(builder: (context) {return const Search();}),);
              },
            )
          ],
        ),
        drawer: const Menu(),
        body: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final article = newsList[index];

            // checking if this news is in favorites before display
            bool isFavorite = false;
            News? news = favSet.getNewsDetail(article.source.id, article.source.name);
            if (news != null) {
              isFavorite = true;
            }


            return ListTile(
                title: Text(article.title ?? '', 
                        style: const TextStyle( fontWeight: FontWeight.bold),
                        key: Key('text_$index'),
                ),
                trailing: IconButton(
                    key: Key('icon_$index'),
                    onPressed: () {
                      if (isFavorite) {
                        //remove the favorite
                        removeFavorite(news!);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Removed from Favorites")),
                        );

                        setState(() {
                          _FavoriteNews();
                        });

                      } 
                      
                      else {
                        // add Favorite
                        addFavorite(article);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Added to Favorites")),
                        );
                        setState(() {
                          _FavoriteNews();
                        });
                      }
                    },

                    icon: isFavorite
                        ? Icon(
                            Icons.star,
                            key: Key("iconRemove$index"),
                          )
                        : Icon(
                            Icons.star_border_outlined,
                            key: Key('iconAdd$index'),
                          )),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(article.description ?? ''),
                    const SizedBox(height: 8),
                    Text(
                      article.author ?? 'Unknown',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                  ],
                ));
          },
        ));
  }

  Future<void> addFavorite(News news) async {
    await news.dbInsert("favorite");

    setState(() {
      _FavoriteNews();
    });
  }

  Future<void> removeFavorite(News news) async {
    news.dbDelete();
    favSet.delete(news.newsId);
    setState(() {
      _FavoriteNews();
    });
  }
}
