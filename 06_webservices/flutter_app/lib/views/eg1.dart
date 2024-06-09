// Demonstrates:
//  - HTTP requests
//  - Using FutureBuilder to perform async web requests
//  - Integrating a simple web service
// 
// Note that HTTP requests won't work in Chrome/Edge because of CORS.
// 
//  here 192.168.0.250 is IPaddress of localhost.replaced it because while runnning in andriod emulator it takes the emulator as localhost 

// For MacOS, add the following to macos/Runner/DebugProfile.entitlements:
//  <key>com.apple.security.network.client</key><true/>

import 'dart:convert'; //used for converting types
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //needed for using http requests

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App1',
      home: Hello(),
    );
  }
}

// Displays "Hello World" messages from a web service.
class Hello extends StatefulWidget {
  final String url = 'http://192.168.0.250:5001/';
  
  const Hello({super.key});

  @override
  State<StatefulWidget> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  Future<String>? hello;

  Future<String> _fetchHello() async {
    final response = await http.get(Uri.parse(widget.url));
    // url is a string which has to be parsed we send it as a request to http
    // response contains the output of https with headers, body and status,etc..
    return response.body;
  }


// init state is called as soon as we create a state object but before set a context for build
//  so, use it only to create datastructures but nothing related to UI elements that are attached to context which is not created yet
  @override
  void initState() {
    super.initState();
    hello = _fetchHello();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            // Rebuild when refreshed
            onPressed: () {
              setState(() {
                hello = _fetchHello();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HelloEditor()),
              );      
            },
          ),
        ],
      ),

      // Futute builder rebuilds the widget when the future object mentioned is changed
      body: FutureBuilder<String>(
        future: hello,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data!, style: const TextStyle(fontSize: 24)),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// Allows the user to add "Hello World" messages to the web service.
class HelloEditor extends StatefulWidget {
  final String url = 'http://192.168.0.250:5001/';
  
  const HelloEditor({super.key});

  @override
  State<StatefulWidget> createState() => _HelloEditorState();
}

class _HelloEditorState extends State<HelloEditor> {
  final TextEditingController _langField = TextEditingController();
  final TextEditingController _helloField = TextEditingController();

  Future<void> _addHello() async {
    // compose the URL to send the PUT request to
    var putUrl = Uri.parse(widget.url + _langField.text);

    // send the PUT request and wait for a response
    final response = await http.put(
      putUrl, 
      // we'll be sending UTF-8 encoded text
      headers: {
        'Content-Type': 'text/plain; charset=UTF-8',
      },
      // make sure to convert the text to UTF-8 before sending
      body: utf8.encoder.convert(_helloField.text)
    );

    if (!mounted) return; // async gap

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Response status code: ${response.statusCode}'),
      ),
    );

    _langField.clear();
    _helloField.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _langField,
              decoration: const InputDecoration(
                labelText: 'Language',
              ),
            ),
            TextFormField(
              controller: _helloField,
              decoration: const InputDecoration(
                labelText: '"Hello"',
              ),
            ),
            ElevatedButton(
              onPressed: () => _addHello(),
              child: const Text('Add')
            )
          ]
        ),
      ),
    );
  }
}
