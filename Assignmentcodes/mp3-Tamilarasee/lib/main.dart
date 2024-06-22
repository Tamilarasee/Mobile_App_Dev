import 'package:flutter/material.dart';
import 'models/all_decks.dart';
import 'views/deck_list_page.dart';
import 'package:provider/provider.dart';

void main()  {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => DecksAll(),
        child: const DeckListPage(),
      )));
}
