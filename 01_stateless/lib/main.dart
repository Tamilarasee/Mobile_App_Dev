/* Topics demonstrated:
 * - Running/Debugging a Flutter app
 * - Viewing Flutter framework source code
 * - Widget Inspector
 * - Hot reload & limitations
 * - Material Design
 * - Some basic widgets: 
 *    - AppBar
 *    - Center
 *    - Column
 *    - ElevatedButton
 *    - GestureDetector
 *    - Icon
 *    - ListView and ListTile
 *    - MaterialApp
 *    - Placeholder
 *    - Row
 *    - SizedBox
 *    - Scaffold
 *    - Text
 * - Inherited widgets
 * - Stateless widgets
 */

// ignore_for_file: unused_import
// The above comment is for the compiler so that it does not give warning for unused imports
import 'package:flutter/Material.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';
import 'views/eg4.dart';
import 'views/eg5.dart';
import 'views/eg6.dart';


void main() {
  const exampleNum = 6; // can we hot-reload a change to this?
                        // see https://docs.flutter.dev/tools/hot-reload#special-cases

  switch(exampleNum) {
    case 0:
      // simplest possible app!
      // (check out definitions of `runApp`, `Placeholder`, and superclasses)
      runApp(const Placeholder());
      // Ctrl+cursor takes you to lib of a given keyword
      // runapp attaches the placedholder widget as the root in the UI component - inflate the widget and attach to the screen
      // runapp - intializes the widgetflutterbinding - The glue between the widgets layer and the Flutter engine.
      // const - compile time constant - cache - declared so as to say the widget placeholder remains same, there would be no change, we can reuse this render element(same reference at memeory) wherever it is called.
      // later, if there is a need to change specs on the same render element, it can be done at the constraint /size identification phase, still having the same render element
      // widget  - describes the configuration of an element
      break;
// Explore every app and see code
    case 1:
      // a custom widget
      runApp(const App1()); // why the `const`?
      break;

    case 2:
      runApp(const App2());
      break;

    case 3:
      // our first Material app (what is Material? what does it provide?)
      // (check it out in the widget details tree)
      // It uses  Chrome's theme , we cans till override at any time, but certain norms always follwed, good practice - having a menu/list/buttons
      runApp(const MaterialApp(
        title: 'App3',
        home: App3() // the "home" / root widget
      ));
      break;

    case 4:
      runApp(const MaterialApp(
        title: 'App4',
        home: App4(),
      ));
      break;

    case 5:
      runApp(const MaterialApp(
        title: 'App5',
        home: App5(),
      ));
      break;

    case 6:
      runApp(const MaterialApp(
        title: 'App6',
        home: App6(),
        debugShowCheckedModeBanner: false,
      ));
  }
}
