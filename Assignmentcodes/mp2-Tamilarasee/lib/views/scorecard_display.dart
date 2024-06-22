// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import '../models/scorecard.dart';
import 'scorecard_panel.dart';
// import 'package:mp2/views/yahtzee.dart';

class ScorecardDisplay extends StatefulWidget {
final DiceModel dice;

const ScorecardDisplay({super.key, required this.dice});

  @override
  State<ScorecardDisplay> createState() => _ScorecardDisplayState();

}

class _ScorecardDisplayState extends State<ScorecardDisplay>{

final ScorecardModel scorecard = ScorecardModel();
final int index =-1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Center(   
                  child:          
          ListenableBuilder(
            listenable: scorecard, 
            builder: (BuildContext context, Widget? child) {
              return 
              
                   Column(children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                          Column(                       
                            children:[
                          for (final category in ScoreCategory.values) 
                            if (category.index<6)  
                            ScorecardPanel(
                            name: category.name,                         
                            value:scorecard.scores[category],
                            onTap: () => scorecard.updatescore(category, widget.dice,context),) ,  
                            ]),
                            const SizedBox(width: 50,),
                           Column(                       
                            children:[
                            for (final category in ScoreCategory.values) 
                            if (category.index>5)  
                            ScorecardPanel(
                            name: category.name,                         
                            value:scorecard.scores[category],
                            onTap: () => scorecard.updatescore(category, widget.dice,context),) , 
                            ]
                            ),
                            
                      ]
                    ),
                    const SizedBox(height: 20,),
                    Text('Current Score: ${scorecard.total}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 4, 167, 242),
                      fontWeight: FontWeight.bold,
                      ),
                      
                    ),
                            
                                 ],
                                 );
                      // Column(children: [ for (final category in ScoreCategory.values)  Text('${category.name}: ${scorecard.scores[category]}'),],)
                
            } 
          )
  
          
      
        
      ),
    );
  }



}

