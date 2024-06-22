import 'package:flutter/material.dart';
import 'package:mp3/models/card_model.dart';

//set of all cards for a given deck - CardSet/collection

class CardSet extends ChangeNotifier {
  final List<FlashCardModel> cardSet;

  CardSet() : cardSet = List.empty(growable: true);

  int get length => cardSet.length;

  FlashCardModel operator [](int index) => cardSet[index];

  void addInCollection(FlashCardModel card) {
    cardSet.add(card);

    notifyListeners();
  }

  FlashCardModel find(int cardID) {
    return cardSet
        .firstWhere((element) => element.cardId == cardID);
  }

  void removeWhere(int cardID) {
    cardSet
        .removeWhere((element) => element.cardId == cardID);
  }

  void clear() {
    cardSet.clear();
    notifyListeners();
  }

  List<FlashCardModel> getList() => cardSet;
  List<FlashCardModel> sortOrder() {
    cardSet.sort((flashModelFirst, flashModelSecond) =>
        flashModelFirst.question.compareTo(flashModelSecond.question));

    return cardSet;
  }

  List<FlashCardModel> shuffle() {
    cardSet.shuffle();
    return cardSet;
  }
}
