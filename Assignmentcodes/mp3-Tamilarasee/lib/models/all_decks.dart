import 'package:flutter/material.dart';
import '/models/deck_model.dart';
import '/models/card_set.dart';
import '/models/card_model.dart';

class DecksAll with ChangeNotifier {
  final List<DeckModel> allDecks;

  DecksAll() : allDecks = List.empty(growable: true);

  int get length => allDecks.length;

  DeckModel operator [](int index) => allDecks[index];

  Future<void> update(int deckId, DeckModel deck) async {
    DeckModel oldDeck = allDecks
        .firstWhere((element) => element.deckId == deck.deckId);
    oldDeck.title = deck.title;
    deck.updateDeck(deck.title, deckId);
    notifyListeners();
  }

  void add(DeckModel deck) {
    allDecks.add(deck);
    deck.saveDeck(deck.title);
    notifyListeners();
  }

  void addInCollection(DeckModel deck) {
    allDecks.add(deck);

    notifyListeners();
  }

  void addInCollectionInSortOrder(DeckModel deck) {
    
    CardSet? cardSet = deck.cardSet;
    
    if (cardSet!.length > 0) {
      List<FlashCardModel> cardSetSortedList = cardSet.sortOrder();
      CardSet cardSetSorted = CardSet();
      for (var card in cardSetSortedList) {
        cardSetSorted.addInCollection(card);
      }
      deck.cardSet = cardSetSorted;
    }

    allDecks.add(deck);

    notifyListeners();
  }

  void clear() {
    allDecks.clear();
    notifyListeners();
  }

  Future<void> delete(int deckId) async {
    DeckModel deck =
        allDecks.firstWhere((element) => element.deckId == deckId);

    deck.deleteDeck(deckId);
    notifyListeners();
  }

  DeckModel getDeckData(int deckID) {
    DeckModel deck =
        allDecks.firstWhere((element) => element.deckId == deckID);
    return deck;
  }

  CardSet? getFlashCardData(int deckID) {
    
    DeckModel deck =
        allDecks.firstWhere((element) => element.deckId == deckID);
    
    if (deck.cardsCount == 0) {
      return null;
    } else {
      return deck.cardSet;
    }
  }

  FlashCardModel? getCard(int deckId, int cardID) {
    DeckModel deck =
        allDecks.firstWhere((element) => element.deckId == deckId);
    if (deck.cardSet != null) {
      FlashCardModel card = deck.cardSet!.find(cardID);
      return card;
    } else {
      return null;
    }
  }

  void addFlashCard(FlashCardModel card) {
    card.saveFlashCards(card, card.deckId as Future<int>);
    notifyListeners();
  }

  Future<void> addNewFlashCard(FlashCardModel card, int deckId) async {
    await card.saveNewFlashCards(card, deckId);
    notifyListeners();
  }

  Future<void> updateFlashCard(
      int flashCardId, int deckId, FlashCardModel? card) async {
    card?.updateFlashCard(card.question, card.answer, flashCardId, deckId);
    notifyListeners();
  }

  Future<void> deleteCard(int deckId, int flashCardId) async {
    DeckModel deck =
        allDecks.firstWhere((element) => element.deckId == deckId);
    FlashCardModel card = deck.cardSet!.find(flashCardId);
    card.deleteFlashCard(flashCardId);
    deck.cardSet?.removeWhere(flashCardId);
    notifyListeners();
  }
}
