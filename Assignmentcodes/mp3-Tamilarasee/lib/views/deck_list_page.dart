import 'package:flutter/material.dart';
import '../models/all_decks.dart';
import '../models/deck_model.dart';
import '../models/card_set.dart';
import '../models/card_model.dart';
import '/utils/db_helper.dart';
import '/views/decklist.dart';
import 'package:provider/provider.dart';

class DeckListPage extends StatelessWidget {
  const DeckListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<DecksAll?>(
        create: (_) => _loadData(), initialData: null, child: const DeckList());
  }

  Future<DecksAll> _loadData() async {

    final decks = await DBHelper().queryDecks();    
    DecksAll deckCollection = DecksAll();

    for (var deck in decks) {
     
      String where = "deck_id= ${deck['deck_id'] as int}";

      final cards = await DBHelper().query("cards", where: where);
      CardSet cardSet = CardSet();

      if (cards.isNotEmpty) {
        for (var card in cards) {
          cardSet.addInCollection(FlashCardModel(
              question: card['question'],
              answer: card['answer'],
              deckId: card['deck_id'],
              cardId: card['card_id']));
        }
      }
      deckCollection.addInCollection(DeckModel(
          deckId: deck['deck_id'] as int,
          title: deck['title'] as String,
          cardsCount: deck['cards_count'],
          cardSet: cardSet));
    }
    return deckCollection;
  }
}
