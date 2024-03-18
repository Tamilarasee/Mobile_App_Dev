/// Demonstrates the use of shared preferences to persist data.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared preferences are used to store a small amount of data like the settings of an application that are saved locally in our phone/any device/browsers
// it is a third party package but maintained by flutter like provider package
// it can store int,strings, string list, double, bool
// the stored values remain if the application is closed and opened.
// to clear the values use .clear method on the shared prefrenece instnace


// shared prerference is a singleton object that creates a single instance of a partivular object at a time.
// the same instance is used over and over as it is usally is a thrid party stuff and onr reference is goood enough.


class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SharedPrefsDemo(),
    );
  }
}

class SharedPrefsDemo extends StatefulWidget {
  // toggle this to turn persistence(storing data) on/off
  final bool persistData = true;

  const SharedPrefsDemo({super.key});

  @override
  State<SharedPrefsDemo> createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  int _counter = 0;

  // needed to control the text field (e.g., change its displayed text)
  // A controller for an editable text field.Whenever the user modifies a text field with an associated [TextEditingController],
  // the text field updates [value] and the controller notifies its listeners


  final TextEditingController _messageController = TextEditingController();
  
//  one-time initialization tasks specific to the state of the widget

  @override
  void initState() {
    super.initState();
  
    _loadData();
    // load data from storage if any
    _messageController.addListener(() { 
      _saveMessage();
    });
  }

  // load data from shared preferences (asynchronously) - async because the data is not actually stoes inside the app, it s a thrid party space,
  //  handled by OS, I-O , cous, database  or whatever

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
  // prefs.clear();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      _messageController.text = (prefs.getString('message') ?? '');
    });
  }

  // save the count

  Future<void> _updateCounter(int inc) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // redraw whenever there is an udpate
      _counter += inc;
      if (widget.persistData) {
        prefs.setInt('counter', _counter);
      }
    });
  }

// save the message

  Future<void> _saveMessage() async {
    final prefs = await SharedPreferences.getInstance();
    if (widget.persistData) {
      prefs.setString('message', _messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _updateCounter(-1), 
                child: const Text('--')
              ),
              const SizedBox(width: 20),
              Text('Counter: $_counter'),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _updateCounter(1), 
                // updates the count and also sets the preference therby storing value
                child: const Text('++')
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextFormField(
              controller: _messageController,
              // whenever this text field changes, the controller notitifies its listeners,
              // which has the save message fn that saves to preference
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Constructor: The constructor of the stateful widget is called first. 
//This is where you initialize the widget's properties and variables.

// createState(): After the constructor, Flutter calls the createState() method of the stateful widget, 
//which creates the corresponding state object.

// initState(): Once the state object is created, Flutter calls its initState() method. 
//This is where you perform initialization tasks specific to the state of the widget.

// build(): After the initState() method completes, Flutter calls the build() method to construct the widget's UI 
//based on its current state. This is where the widget is built and inserted into the widget tree.
// diff b/w builder widget and others is that , builder widget has reference to a function that constructs the widget structure.