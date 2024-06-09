import 'package:flutter/material.dart';

class App1 extends StatefulWidget {
  const App1({super.key});

  @override
  State<App1> createState() => _App1State();
}

class _App1State extends State<App1> {
  int counter = 0;

// No delay between copying the value and updating the value- - runnning loop twice -->2000 normal incrementation
  Future<void> incrementCounter1() async {
    for (int i = 0; i < 1000; i++) {
      counter++;
      await Future.delayed(Duration.zero);
    }
  }

// Race condition - since we have kept the delay in between reading the value and updating the value
//- >the output is only 1000 even when run twice-->bacuse the old value was copied by both counters each time and
// it is one step behind every time and hence the result is 1000

Future<void> incrementCounter2() async {
  for (int i = 0; i < 1000; i++) {
    int temp = counter;
    await Future.delayed(Duration.zero);
    counter = temp + 1;
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Race Condition?'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter: $counter'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      counter = 0;
                      await Future.wait([
                        incrementCounter1(),
                        incrementCounter1(),
                      ]);
                      setState(() { });
                    }, 
                    child: const Text('Increment #1')
                  ),
                  ElevatedButton(
                    onPressed:() => setState(() => counter = 0),
                    child: const Text('Reset')
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      counter = 0;
                      await Future.wait([
                        incrementCounter2(),
                        incrementCounter2(),
                      ]);
                      setState(() { });
                    }, 
                    child: const Text('Increment #2')
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
