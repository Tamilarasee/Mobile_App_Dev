import 'package:flutter/material.dart';
import '/models/all_decks.dart';
import '/models/card_model.dart';
import 'package:provider/provider.dart';

class CardEditPage extends StatefulWidget {
  final int deckId;
  final int cardId;

  const CardEditPage(this.deckId, this.cardId, {super.key});

  @override
  State<CardEditPage> createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  late FlashCardModel? card;
  late DecksAll? decks;

  @override
  void initState() {
    super.initState();
    decks = Provider.of<DecksAll>(context, listen: false);

    if (widget.cardId != 0 && widget.deckId != 0) {
      card = decks!.getCard(widget.deckId, widget.cardId);
    } else {
      card = FlashCardModel(question: "", answer: "", deckId: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var deleteButton = widget.cardId == 0
        ? Container()

        : TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              await decks?.deleteCard(widget.deckId, widget.cardId);

              Navigator.of(context).pop();
            },
          );

    return Scaffold(
        appBar: AppBar(title: const Text('Edit Card',
        style: TextStyle(color: Color.fromARGB(255, 8, 7, 7))),
          backgroundColor: const Color.fromARGB(255, 223, 128, 40)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  initialValue: card?.question,
                  decoration: const InputDecoration(hintText: 'Question'),
                  onChanged: (value) => card?.question = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  initialValue: card?.answer,
                  decoration: const InputDecoration(hintText: 'Answer'),
                  onChanged: (value) => card?.answer = value,
                ),
              ),
              Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
              TextButton(
                child: const Text('Save'),
                onPressed: () async {
                  if (widget.cardId == 0) {
                    await decks?.addNewFlashCard(card!, widget.deckId);
                  } else {
                    await decks?.updateFlashCard(widget.cardId, widget.deckId, card);
                  }
              
                  Navigator.of(context).pop();
                },
              ),
              deleteButton,
                              ],
                            )
            ],
          ),
        ));
  }
}
