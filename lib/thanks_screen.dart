import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'candidate_list.dart';

class ThankYouPage extends StatelessWidget {
  final Candidate candidate;
  final WordPair wordPair;

  // const ThankYouPage({Key key, this.wordPair}) : super(key: key);

  const ThankYouPage({Key key, this.candidate, this.wordPair})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Dziękujemy za\ngłosowanie!',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Wybrano kandydata:',
                    // 'Wybrano: \n${candidate.name + candidate.lastName}',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    '${wordPair.asPascalCase}',
                    // 'Wybrano: \n${candidate.name + candidate.lastName}',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 40,
                        letterSpacing: .15),
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                elevation: 5,
                shadowColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
