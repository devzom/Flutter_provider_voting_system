import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'candidate_list.dart';

class ThankYouPage extends StatelessWidget {
  final Candidate candidate;

  const ThankYouPage({Key key, this.candidate}) : super(key: key);

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
                'Dziękujemy za głosowanie!',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                'Wybrano: \n${candidate.name + candidate.lastName}',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
