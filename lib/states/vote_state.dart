import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../candidate_list.dart';

class VotingScreenProvider with ChangeNotifier {
  //! create setter for values
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _elgiblityMessage = '';
  bool _isElgible;
  bool _autoValidate = true;
  int _ageInput;

  int _peselInput;
  String _nameInput;

  //! create getter for values\
  GlobalKey get formKey => _formKey;
  String get elgiblityMessage => _elgiblityMessage;
  bool get isElgible => _isElgible;
  bool get autoValidate => _autoValidate;
  int get ageInput => _ageInput;

  int get peselInput => _peselInput;
  String get nameInput => _nameInput;

  //! initialize voteState for later use in ChangeNotifier consumer
  void voteState() {}

  void checkElgiblity(int age) async {
    if (age <= 18)
      notElgibleForVoting();
    else
      elgibleforVoting();
  }

  void checkPesel(int pesel) {
    if ((pesel.toString()).length == 11) {
      elgibleforVoting();
    } else {
      // notElgibleForVoting();
      wrongPesel();
    }
  }

  void wrongPesel() {
    _elgiblityMessage = 'Pesel jest niepoprawny lub za krótki!';
    _isElgible = false;
    notifyListeners();
  }

  void notElgibleForVoting() {
    _elgiblityMessage = 'Nie mozesz glosowac!';
    _isElgible = false;
    notifyListeners();
  }

  void elgibleforVoting() {
    _elgiblityMessage = 'Mozesz glosowac!';
    _isElgible = true;
    notifyListeners();
  }

  void emptyMessage() {
    _elgiblityMessage = '';
    _isElgible = false;
  }

  void validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      _autoValidate = true;
    }
  }

  String validateAge(String age) {
// Indian Mobile number are of 10 digit only
    if (age.length == 0)
      return 'Pole nie moze byc puste';
    else
      return null;
  }

  String validatePesel(String pesel) {
// Indian Mobile number are of 10 digit only
    if (pesel.length == 11)
      return 'Nr Pesel musi mieć 11 znaków';
    else
      return null;
  }

  navigateAndDisplaySelection(BuildContext context) async {
    //! get context = value from screen and push it to snackBar
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CandidateList()),
    );

    //! After the Selection Screen returns a result=candidate, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
