/* Topics to demonstrate:
 * - Using the `provider` package to disseminate a ChangeNotifier
 */

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

// All classes are stateless making less remaking of widgets and use provider for building stuff that needs to be when change is done


class App6 extends StatelessWidget {
  const App6({super.key});

  @override
  Widget build(BuildContext context) {
    // The ChangeNotifierProvider is a widget that provides a model to all
    // children widgets. 
    return ChangeNotifierProvider(
      // Makes the counter model available for all children (inheritence)
      create: (context) => CountersModel(), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SumDisplay(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) => CounterDisplay(index: i))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) => Incrementer(index: i, increment: i+1))
          ),
        ],
      )
    );
  }
}


class CountersModel with ChangeNotifier {
  final Map<int,int> _counts = {};

  int get sum => _counts.values.sum;
  
  int getCount(int index) {
    return _counts[index] ?? 0;
  }

  void increment(int index, int inc) {
    _counts[index] = getCount(index) + inc;
    notifyListeners();
  }
}


class SumDisplay extends StatelessWidget {
  const SumDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountersModel>(
      // consumer rebuilts the stuff automatically when there is a change...it cannot change the build model
      builder: (context, counters, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Sum: ${counters.sum}'),
        );
      }
    );
  }
}


class CounterDisplay extends StatelessWidget {
  final int index;

  const CounterDisplay({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountersModel>(
      builder: (context, counters, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Counter: ${counters.getCount(index)}'),
        );
      }
    );
  }
}


class Incrementer extends StatelessWidget {
  final int index;
  final int? increment;

  const Incrementer({required this.index, this.increment, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Provider.of<CountersModel>(context, listen: false)
          // listen false- it doesnt change/rebuild its widget but sends message to model to change the value-->make change to model and rebuild own widget if need be
          .increment(index, increment ?? 1);
        },
        child: Text('+${increment ?? 1}')
      ),
    );
  }
}
