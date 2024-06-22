// import 'dart:js_interop';

import 'package:flutter/material.dart';
import '../models/dice.dart';
import '../models/scorecard.dart';
import 'dice_display.dart';
import 'scorecard_display.dart';

class Yahtzee extends StatelessWidget {
  Yahtzee({super.key});
final DiceModel _dice = DiceModel();  
  @override
  Widget build(BuildContext context) {
    return 
      Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
           DiceDisplay(dice: _dice),
           ScorecardDisplay(dice: _dice)        
          
           ],),
        ),
      );
    }
  
}


class GameoverAlert {

   Future<void> gameover( BuildContext context,  ScoreCard scorecard) async 
  {await
showDialog(
        context: context,
        builder: (BuildContext context) {
            return
         AlertDialog(
          title: const Text ('Game Over! '),
          content: Text('Final Score : ${scorecard.total}'),
          actions: <Widget>[
            
            TextButton(
              child: const Text('Play again! '),
              onPressed: () { 
              Navigator.of(context).pop();
              
              }
              
              )],
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 159, 204, 238),
         );
        }
      );
  }
     
  }

