import 'package:Flutter_provider_voting_system/thanks_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateList extends StatefulWidget {
  // List candidates = [
  //   'One',
  //   'Two',
  //   'Three',
  // ];

  @override
  _CandidateListState createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  bool chooseCandidate = false;

  final candidates = List<Candidate>.generate(
    10,
    (
      i,
    ) =>
        Candidate(
      'kandydat $i',
      '$i',
      '$i',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 40, 20, 20),
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.perm_identity),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  title: Text('Imię ${candidates[index].name}'
                          '\n' +
                      'Nazwisko ${candidates[index].lastName}' +
                      '\n' +
                      'Wiek ${candidates[index].age}'),
                  trailing: OutlineButton(
                    child: Text(
                      'Wybieram',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(letterSpacing: .5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ThankYouPage(candidate: candidates[index]),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    highlightElevation: 10,
                    // highlightColor: Colors.redAccent,
                    splashColor: Colors.red,
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                elevation: 3,
                shadowColor: Colors.red,
              );
            }),
      ),
    );
  }
}

//  Election candidate model

class Candidate {
  final String name;
  final String lastName;
  final dynamic age;

  Candidate(this.name, this.lastName, this.age);
}
