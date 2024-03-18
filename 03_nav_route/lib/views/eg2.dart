/* Topics demonstrated:
 * - Passing data back and forth between two pages
 * - Asynchronous callbacks via `Future`
 * - Dealing with an "async gap"
 */

import 'package:flutter/material.dart';


// This app shows sharing of data between the pages
// how page 1 gives input to page 2 and how the page 2 gives result to the old page1 which is in stack
//(seems not possible -  but done through the future variable concept)


// Summary: When we click on a option in 1st page, we put the second page in stack and go to render the second page with the input from 1st page.
// From 2nd page, do some manipulation and to send back the data to first page,we send it while we pop off the seond page from stack using navigator widget
// when you go back, the first page will now be on the top of the stack and its context(-which rendered original element for 1 st page) will
// handle the input received from 2nd age and render it as a snackbar along with th e original 1st page





class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 2',
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var questions = ['Stay home?', 'Go out?', 'Do work?'];

    return Scaffold(
      appBar: AppBar(title: const Text('Pick a question')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(questions.length, (index) {
            return TextButton(
              child: Text('${index + 1}'),
              onPressed: () {
                // `Navigator.push` returns a `Future` that completes when the
                // pushed page is popped off the navigation stack. The `Future`
                // contains the value (if any) passed to `Navigator.pop`
                // since the result is future, it does wait for the answer, it skips the part and goes to the next line of code
                Future<String?> result = Navigator.of(context).push(
                  MaterialPageRoute<String>(
                    builder: (context) {
                      // Pass the chosen question to the next page
                      return DecisionPage(questions[index]);
                    }
                  ),
                );

                // Here we register a callback with the `Future` that will be
                // called when the `Future` completes. This can be written 
                // more prettily using `async`/`await` (see `eg3.dart`).
                result.then((String? value) {

                  // Since this runs after a delay (aka an "async gap"),
                  // we need to check that the page is still mounted before
                  // showing the `SnackBar` (otherwise the context is invalid, 
                  // and we get an error) --- this is a common pattern!
                  if (!context.mounted) return;

                  // Since, we use a stack, the above line of code is not needed, because, the context will be in memory,
                  // but in cases, wheree stack is not used, we do not know if that "original context" is still hanging around in memory or was it thrown off by flutter
                  // Eg - when you switch between tabs, there might be a duration for how long an inactive tab holds your data

                  // Show a `SnackBar` with the result
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You chose: ${value ?? 'nothing'}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                });
              },
            );
          }).toList()
        ),
      )
    );
  }
}

class DecisionPage extends StatelessWidget {
  final String question;

  const DecisionPage(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Recall: the `AppBar` automatically provides a "back" button
      // -- what is returned to the `Future` if the user presses this? - "You chose nothing-snackbar"
      appBar: AppBar(title: const Text('Decide!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(question, style: Theme.of(context).textTheme.headlineSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Yes', 'No', 'Maybe'].map((String answer) {
                return TextButton(
                  child: Text(answer),
                  onPressed: () {
                    // "Return" the answer to the previous page (this gets
                    // put in the `Future` returned by `Navigator.push`)
                    Navigator.of(context).pop(answer);
                    // this answer is given as future answer
                  },
                );
              }).toList(),
            ),
          ],
        ),
      )
    );
  }
}
