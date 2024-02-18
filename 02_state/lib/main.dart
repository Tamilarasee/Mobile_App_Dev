/* Topics to demonstrate:
 * - Stateful widgets
 * - ChangeNotifier
 * - ListenableBuilder / AnimatedBuilder
 * - provider package
 */

// ignore_for_file: unused_import

// In stateful widget, there is state object in addition to the element and widget objects.
// The state object is mutable, whose changes are then incorporated to the widget tree based on the parts changed--->which then changes the element tree
// Inside the state class, we choose to say when can we update/refresh the widget according to current changes using the set state function
// we can wrap the entire flow in setstate , so thta it is rebuilt after all changes or we can wrap a couple of main changes as well.

import 'package:flutter/material.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';
import 'views/eg4.dart';
import 'views/eg5.dart';
import 'views/eg6.dart';


void main() {
  runApp(MaterialApp(
    title: 'Flutter State',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
      ),
      body: const Center(
        child: App6()  //change app numbers and run
      )
    )
  ));
}

class App0 extends StatefulWidget {
 
  
  const App0({Key? key}):super(key:key);

@override
State<App0> createState() => _App0State();
// State class is not a widget class, it is th one used to build the widget. It is like the App0 is outsourcing widget tree build to State class
// createstate is a method of stateful widget which creates an instance of the corresponding state object
// no build method in this class, it is moved to the state class
}

class _App0State extends State<App0> {

// the variables in here tend to change and shall not be const

  int _counter = 0;
  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter: $_counter'),
        const SizedBox(height: 16,),
        ElevatedButton(onPressed:(){
        setState((){    //setState function is used to know when we can set the state and rebuild the widget
          _counter +=1; // takes the function with line counter 
        });
        },
        // setstate helps to show the updated widget on screen by rendering app./ elements
        child: const Text('Increment')
        )

    ],);
  }
}
