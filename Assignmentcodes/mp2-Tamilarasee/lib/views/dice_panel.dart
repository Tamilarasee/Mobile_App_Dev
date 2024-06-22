// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';

class DicePanel extends StatelessWidget{

final int dievalue;
final DiceModel dice;
final int index;
const DicePanel({super.key, required this.index, required this.dievalue, required this.dice});


  @override
  Widget build(BuildContext context) {
    return 
   
 Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(5),
    width: 50,    
    alignment: Alignment.center,
    decoration:BoxDecoration(
      color:const Color.fromARGB(255, 249, 251, 250),
      border:Border.all(
        color: !dice.isHeld(index) ? const Color.fromARGB(255, 141, 241, 175) : const Color.fromARGB(255, 238, 54, 54),
        width:2.0)),
    child:
   GestureDetector(
          child: Text('$dievalue',
            
            style: const TextStyle( // manually specified fancy style
              color: Color.fromARGB(255, 8, 101, 36),
              fontWeight: FontWeight.bold,
              fontSize: 30
            )),
            onTap: 
            () => dice.toggle(index)
            

          ),
        );     
  


  }         



}

