// import 'dart:js_interop';

import 'package:flutter/material.dart';
// import 'package:mp2/views/dice_display.dart';

class RollButton extends StatefulWidget{


final VoidCallback? onPressed;
final int count;

 const RollButton({this.onPressed, required this.count, super.key});


  @override
  State<RollButton> createState() => _RollButtonState();
}

class _RollButtonState extends State<RollButton> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        onPressed: widget.count>0 ? widget.onPressed : null,
        style: ElevatedButton.styleFrom(
        backgroundColor: widget.count>0 ? Colors.blue : Colors.grey, // Set the background color
        foregroundColor: Colors.white),
        child: widget.count>0 ? Text('Rolls left: ${widget.count} 😊'): const Text('Out of rolls 😢')
      )
    );
  } 
}

