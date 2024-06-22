import 'package:collection/collection.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class Dice {
  final List<int?> _values;
  final List<bool> _held;

  Dice(int numDice) 
  : _values = List<int?>.filled(numDice, null),
    _held = List<bool>.filled(numDice, false);

  List<int> get values => List<int>.unmodifiable(_values.whereNotNull());

  int? operator [](int index) => _values[index];

  

  void clear() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = null;
      _held[i] = false;
    }
  }

  void roll() {
    for (var i = 0; i < _values.length; i++) {
      if (!_held[i]) {
        _values[i] = Random().nextInt(6) + 1;
      }
    }
  }

  void toggleHold(int index) {
    _held[index] = !_held[index];
  }
}

class DiceModel with ChangeNotifier{

final _dice = Dice(5);

get values => _dice.values;
get clear => _dice.clear();

int rollcount =  3;
// List<bool> hold = List.filled(5, false);

bool isHeld(int index) => _dice._held[index];

void toggle( int index) {
    _dice.toggleHold(index);
     notifyListeners();
}
void diceroll () {
    _dice.roll();
    rollcount -= 1;
    notifyListeners();
  }
}