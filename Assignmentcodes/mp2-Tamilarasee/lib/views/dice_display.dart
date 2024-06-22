// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';

import 'dice_panel.dart';
import 'roll_button.dart';
// import 'package:mp2/views/yahtzee.dart';

class DiceDisplay extends StatefulWidget {

final DiceModel dice ;

const DiceDisplay({super.key, required this.dice});

  @override
  State<DiceDisplay> createState() => _DiceDisplayState();


}

class _DiceDisplayState extends State<DiceDisplay>{

get _dice => widget.dice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(   
          
        child:
          
          ListenableBuilder(
            listenable: _dice, 
            builder: (BuildContext context, Widget? child) {
              return 
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  
                 List<Widget>.from(Iterable<int>.generate(_dice.values.length).map(
                    (index) => DicePanel(
                      index:index,
                      dievalue: _dice.values[index], 
                      dice:_dice                   
                    ),
                  ).toList(),),
                ),
                const SizedBox(height: 3),
                RollButton(
            count: _dice.rollcount,
            onPressed: () => _dice.diceroll()),
              ],
              );
            }
          ),
          
      
        
      ),
    );
  }



}
