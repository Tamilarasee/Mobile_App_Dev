/* Our first Material app! */

import 'package:flutter/Material.dart';

class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // what happens if we remove the scaffold?  - It creates a kind of invisible place(background) to put the visual things on
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "I'm a Material App!",
              // where does this style come from? how is it retrieved?
              style: Theme.of(context).textTheme.titleLarge 
              //thrmes are calling back to material to get specs. Here, context is used as arugument, which is a buildcontext instance that relates to elements
              // the elements also has references up the level of the widgets--/>thereby niw it says, go up the widget tree and find something related to theme - -->lands on Materialapp class
            ),
            // automatic gesture detection
            // (try to find the GestureDetector in the widget details tree)
            ElevatedButton(
              child: const Text('Hey! Click me!'),
              onPressed: () {
                print('Button clicked');
              }, 
            )
          ],
        ),
      ),
    );
  }
}
