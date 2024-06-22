import 'package:flutter/material.dart';
import '/models/card_set.dart';
import '/utils/db_helper.dart';

import 'card_model.dart';

class DeckModel with ChangeNotifier {
  int? deckId;
  String title;
  int? cardsCount;
  CardSet? cardSet;
  DeckModel(
      {this.deckId,
      required this.title,
      this.cardsCount,
      this.cardSet});

  factory DeckModel.fromJson(Map<String, dynamic> deckData) {

    String title = deckData['title'];
    List cardSetData = deckData['flashcards'];
    
    CardSet cardSet = CardSet();

    for (var cardData in cardSetData) {
      FlashCardModel card = FlashCardModel.fromJson(cardData);
      cardSet.addInCollection(card);
    }

    return DeckModel(
        deckId: 1,
        title: title,
        cardsCount: cardSet.length,
        cardSet: cardSet);
  }

  Future<int> saveDeck(String titleName) async {
    int deckID = await DBHelper().insert("decks", {'title': title});
    return deckID;
  }

// create a copy for using in editing page

  DeckModel.from(DeckModel other)
      : deckId = other.deckId,
        title = other.title;

  Future<void> updateDeck(String titleName, int deckId) async {
    await DBHelper().update(
        "decks", {'title': title, 'deck_id': deckId}, "deck_id");
  }

  Future<void> deleteDeck(int deckId) async {
    await DBHelper()
        .deleteDeck("decks", "cards", deckId, "deck_id");
  }
}
