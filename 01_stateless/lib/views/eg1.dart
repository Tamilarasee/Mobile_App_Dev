/* Super-simple widget */

import 'package:flutter/Material.dart';

class App1 extends StatelessWidget {
  // why is this constructor `const`? (what happens if we remove it?)
  // note the unused optional parameter `key` (we'll talk about this later)
  const App1({super.key});

  // `build` is called by the framework to build the widget tree
  @override
  Widget build(BuildContext context) {  // `context` is my location in the tree
    // construct and return a widget tree
    // (try to navigate the tree in the widget inspector)
    // Build method is called upon a widget instance , which creates a widget tree
    // Buildcontext referes to the elements which is sort of creating a element and keeping before hand which is then passed on later
    return const Center(
      child: Text(
        'Hello World!', // try changing this and hot-reloading 
        // Hot reload means when there is no change to the main function, but there is a change in other files, we can see the output just by saving it. need not rerun the code.
        textDirection: TextDirection.ltr, // what happens if we remove this? - it needs a directions-else exception
      )
    );
  }      
}
