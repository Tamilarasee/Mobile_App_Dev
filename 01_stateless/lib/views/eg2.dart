/* Play with some more child widgets and options */

import 'package:flutter/Material.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // the following property is inherited by descendant widgets.Super class of Directionality is Inhertied widget
      textDirection: TextDirection.ltr,
      child: Column(
        // try to tweak this property in the layout explorer
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hello!'), // no need to specify `textDirection` here
          const SizedBox(height: 50, width: 50), // spacer
          GestureDetector(
            child: const Text(
              'World!!!',
              style: TextStyle( // manually specified fancy style
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30
              )
            ),
            // Text direction was not specified here as they get inherited from the directionality fn
            // callback for when the widget is tapped
            // ontap -  trigger attribute which calls a function on the event happening 
            // this is the way of handling asynchronous events - where it happens are unpredictable time and needs a response
            // this fn call can have arguements as well
            // Below is an empty unnamed fn call that prints clicked
            onTap: () => print('"World!" clicked'),
            // The output shows up in Debug console
            // No button visual was created, but it is interactivebecoz of gesture detector
          ),
        ]
      ),
    );
  }      
}
