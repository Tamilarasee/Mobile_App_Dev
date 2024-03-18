/* Topics demonstrated:
 * - Common list -> detail drill-down pattern
 * - "Editing" and returning new data from a detail page
 * - `async`/`await` syntax
 */

import 'package:flutter/material.dart';
import '../models/macguffin.dart';

class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 3',
      home: MacGuffinsListPage(50),
    );
  }
}


class MacGuffinsListPage extends StatefulWidget {
  final int numMacGuffins;

  const MacGuffinsListPage(this.numMacGuffins, {super.key});

  @override
  State<MacGuffinsListPage> createState() => _MacGuffinsListPageState();
}

class _MacGuffinsListPageState extends State<MacGuffinsListPage> {
  late List<MacGuffin> data;

  @override
  void initState() {
    super.initState();
    // Called when this object is inserted into the tree.(after the widget, its elements and its state object are created)
    // The framework will call this method exactly once for each [State] object it creates.
    // It is different from constructor because constructor will be called to create the object but this one already kind of happens after the widget is initialized
    // In a real app, this data would be fetched from a database or API

// It's called when the stateful widget is inserted into the widget tree for the first time. This method is typically used for one-time initialization tasks,
// such as initializing variables, setting up listeners, or fetching data from external sources.

    data = List.generate(widget.numMacGuffins,
      (index) => MacGuffin(name: 'MacGuffin ${index + 1}')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MacGuffins')),
      // create a list of tiles based on the length(no.) of the macguffins
      body: ListView.builder(
        itemCount: data.length, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].name),
            onTap: () {
              _editMacGuffin(context, index);
              // On tap, push a new page passing the appropriate index along which is used to retrieve the macguffin model and display the values
            },
          );
        }
      )
    );
  }

  Future<void> _editMacGuffin(BuildContext context, int index) async {
    // `await` suspends execution until the `DetailPage` is popped off the
    // navigation stack, at which point it returns the value passed to
    // `Navigator.pop` (if any)
    var result = await Navigator.of(context).push(
      MaterialPageRoute<MacGuffin>(
        builder: (context) {
          return MacGuffinEditPage(data[index]);
        }
      ),
    );

    // Check that this state object is still associated with a mounted widget
    // for the same reason as discussed before (i.e., the "async gap").
    if (!mounted) return;

    // Check that the result isn't null and is different from the original
    // Result could be null when we simply click on "back" button and 
    // the second condition is used to save the effort of redrawing the same thing, if no actual changes made, no need to update
    if (result != null && result != data[index]) {
      // Update the model data & rebuild the widget
      // this redraws the list tiles which are currently visible on the screen
      // So, though we change 1 tile, the list of tiles on screen(say 10 of the 50) will be redrawn
      setState(() {
        data[index] = result;
      });
    }
  }
}


class MacGuffinEditPage extends StatefulWidget {
  final MacGuffin macguffin;

  const MacGuffinEditPage(this.macguffin, {super.key});

  @override
  State<MacGuffinEditPage> createState() => _MacGuffinEditPageState();
}

class _MacGuffinEditPageState extends State<MacGuffinEditPage> {
  late MacGuffin editedMacGuffin;

  @override
  void initState() {
    super.initState();
    // make a copy of the MacGuffin for editing using the copy constructor function from the datamodel
    editedMacGuffin = MacGuffin.from(widget.macguffin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit MacGuffin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                initialValue: editedMacGuffin.name,
                // whatever name stored previously will be visible
                decoration: const InputDecoration(hintText: 'Name'),
                // when you delete existing and  nothing is typed , show by default 'Name'
                onChanged: (value) => editedMacGuffin.name = value,
                // when we change the value it get stored only to the edited copy, because we havent saved it yet,
                // only when saved buttin is clicked it is confirmed to be a valid data
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                initialValue: editedMacGuffin.description,
                decoration: const InputDecoration(hintText: 'Description'),
                onChanged: (value) => editedMacGuffin.description = value,
              ),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Pop the current screen off the navigation stack, and pass
                // the new name back to the previous screen
                Navigator.of(context).pop(editedMacGuffin);
                // Now the edited value is sent to the first page
              },
            ),
          ],
        ),
      )
    );
  }
}
