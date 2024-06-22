import 'package:flutter/material.dart';
import '../models/all_decks.dart';
import '/models/deck_model.dart';
import 'package:provider/provider.dart';

class DeckEditPage extends StatefulWidget {
  final int deckId;

  const DeckEditPage(this.deckId, {super.key});

  @override
  State<DeckEditPage> createState() => _DeckEditPageState();
}

class _DeckEditPageState extends State<DeckEditPage> {
  late DeckModel deck;
  late DecksAll decks;

  @override
  void initState() {
    super.initState();
    decks = Provider.of<DecksAll>(context, listen: false);

    if (widget.deckId != 0) {
      deck = DeckModel.from(decks.getDeckData(widget.deckId));
    } else {
      deck = DeckModel(title: "");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var deleteButton = widget.deckId == 0
        ? Container()  //Delete button not displayed if it is new deck
       
        : TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              await decks.delete(widget.deckId);

              Navigator.of(context).pop();
            },
          );

    return Scaffold(
        appBar: AppBar(title: const Text('Edit Deck', 
        style: TextStyle(color: Color.fromARGB(255, 8, 7, 7))),
          backgroundColor: const Color.fromARGB(255, 223, 128, 40)),  
        
              
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  initialValue: deck.title,
                  decoration: const InputDecoration(hintText: 'Deck Name'),
                  onChanged: (value) => deck.title = value,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      if (widget.deckId == 0)
                        decks.add(deck);
                      else
                        decks.update(widget.deckId, deck);

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
