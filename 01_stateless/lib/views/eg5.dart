/* Demonstrating a ListView -- a very flexible widget */

import 'package:flutter/Material.dart';

class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My first list App'),
      ),
      floatingActionButton: FloatingActionButton(
        // the add icon
        child: const Icon(Icons.location_on),
        onPressed: () {
          print('Home button clicked');
        }, 
      ),
      body: ListView(
        // can you add the tiles 'Lions', 'Tigers', 'Bears', and 'Oh my!'?
        // This gives the scrollable container
        // children: ['Lions', 'Tigers', 'Bears'].map((animal){
        //   return ListTile(
        //     title: Text(animal),
        //     onTap: () => print("You tapped $animal"),
        //   );
        // }).toList(),
        children:List.generate(10, (index) => ListTile(
          title: Text('Item $index'),
          subtitle: Text('subtitle $index'),
          leading: const Icon(Icons.star),
          trailing: const Icon(Icons.more_vert),
          onTap: () => print("Item $index tapped"),
        ))
          
          ),
        
      );
    
  }
}
