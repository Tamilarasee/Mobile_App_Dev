/* Topics to demonstrate:
 * - Extracting state into a model class
 * - ChangeNotifier, Listenable, and ListenableBuilder
 */

import 'package:flutter/material.dart';

// Why must we use a `StatefulWidget` here? (`setState` isn't used!)
class App4 extends StatefulWidget {
  const App4({super.key});

  @override
  State<App4> createState() => _App4State();
}

// The set state function would call the entire Widget build (below) to recreate the whole widget tree
// This can be avoided by using Model methods shown here to rebuild only a subtree of the widget tree using the smaller builder function inside the Widget build



class _App4State extends State<App4> {
  final CounterModel _counter = CounterModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // A `ListenableBuilder`(a type of builder) is paired with a `Listenable` object 
        // (like a `ChangeNotifier`) and rebuilds its subtree whenever 
        // the `Listenable` sends notification of a change
        // this is like "call me" if your value changes
        // this builder can be called anytime the _counter changed
        ListenableBuilder(
          listenable: _counter, 
          // child: const Text() - we can send a child of the subtree to be constant as an arguement below so that it need not be recreated/rebuilt 
          builder: (BuildContext context, Widget? child) {
            return Text('Counter: ${_counter.count}');
          }
        ),
        Incrementer(
          onPressed: () => _counter.increment(1)
        ),

      ],
    );
  }
}


// Our data model is a `ChangeNotifier`, which will notify its listeners
// whenever it is updated
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  // we use a get method so that it can be used as a instance callable variable
  // there is no setter method, as we dont want to manipulate the count exernally, we use the increment method to update it as part of our logic

  void increment(int inc) {
    _count += inc;
    notifyListeners();
  }
}


class Incrementer extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;

  const Incrementer({this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label ?? '++')
      ),
    );
  }
}
