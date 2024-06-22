// import 'dart:js_interop';

import 'package:flutter/material.dart';
// import 'package:mp2/views/scorecard_display.dart';

class ScorecardPanel extends StatefulWidget {

final String name;
final VoidCallback? onTap;
final int? value;

const ScorecardPanel({super.key, required this.name, required this.onTap, required this.value});

  @override
  State<ScorecardPanel> createState() => _ScorecardPanelState();
}

class _ScorecardPanelState extends State<ScorecardPanel> {
  @override
  Widget build(BuildContext context) {
    return 
   
 Row(            
   children: [
  Text('${widget.name} :'),
   const SizedBox(width: 10),         
    MouseRegion(
     cursor: SystemMouseCursors.click,
      child: InkWell(                
       onTap: (widget.value == null) ? widget.onTap : null,
        child:Container(
         padding: const EdgeInsets.all(3),                
         child: (widget.value ==null) ? const Text('Select',
         style: TextStyle(color: Colors.blue,))
         :Text('${widget.value}')),      
      ),
    ),         
    
 ],);      
}
}