import 'package:mp3/utils/db_helper.dart';

class FlashCardModel {
  int? cardId;
  String question;
  String answer;
  final int deckId;

  FlashCardModel(
      {this.cardId,
      required this.question,
      required this.answer,
      required this.deckId});

  FlashCardModel.from(FlashCardModel other)
      : question = other.question,
        answer = other.answer,
        deckId = other.deckId,
        cardId = other.cardId;

  factory FlashCardModel.fromJson(Map<String, dynamic> cardData) {
    return FlashCardModel(
        question: cardData['question'] as String,
        answer: cardData['answer'] as String,
        deckId: 0);
  }

  Future<void> saveFlashCards(FlashCardModel card, Future<int> deckId) async {
    await DBHelper().insert("cards", {
      'question': card.question,
      'answer': card.answer,
      'deck_id': deckId
    });
  }

Future<void> deleteFlashCard(int cardId) async {
    await DBHelper().delete("cards", cardId, "card_id");
  }

  
  Future<void> updateFlashCard(String question, String answer, int cardId, int deckId) async {
    await DBHelper().update(
        "cards",
        {
          'question': question,
          'answer': answer,
          'deck_id': deckId,
          'card_id': cardId
        },
        "card_id");
  }

  Future<int> saveNewFlashCards(FlashCardModel card, int deckId) async {
    return await DBHelper().insert("cards", {
      'question': card.question,
      'answer': card.answer,
      'deck_id': deckId
    });
  }
  
}
