/* Topics demonstrated:
 * - Simple back-and-forth navigation between two pages
 */

import 'package:flutter/material.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 1',
      // the home widget is the first page, or "route", to display -- 
      // it is at the bottom of the navigation stack
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: Center(
        child: TextButton(
          child: const Text('Go to Page 2'),
          onPressed: () {
            // Push a new screen onto the navigation stack
            // equivalent to Navigator.push(context, ...)
            // .of method - represents inheritence - look for a navigator up in the widget tree parents  - and inherit it
            // so, we now have access to the stack upon which we can keep pushing our new pages
            Navigator.of(context).push(
              // MaterialPageRoute defines a modal (full screen) route
              // th ereturned page 2 widget tree is wrappped around Materialpage route before pushng to stack
              MaterialPageRoute(
                // The builder function returns the widget tree
                // to display in the new route
                // builder is a function that could be building a subtree
                builder: (context) {
                  return const Page2();
                }
              ),
            );
          },
        ),
      )
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: Center(
        // This button isn't really needed, since the AppBar
        // automatically provides a "back" button
        child: TextButton(
          child: const Text('Go back to Page 1'),
          onPressed: () {
            // Pop the current screen off the navigation stack
            // equivalent to Navigator.pop(context)
            // the back button comes by default , it is customizable as well
            Navigator.of(context).pop();
          },
        ),
      )
    );
  }
}
