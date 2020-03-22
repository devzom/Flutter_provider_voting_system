import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'states/vote_state.dart';
import 'candidate_list.dart';

void main() {
  runApp(VotingApp());
}

class VotingApp extends StatefulWidget {
  @override
  _VotingAppState createState() => _VotingAppState();
}

class _VotingAppState extends State<VotingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: StartScreen(),
      ),
      // initialRoute: '/',
      routes: {
        '/validationScreen': (context) => VotingScreen(),
        '/candidateList': (context) => CandidateList(),
      },
    );
  }
}

class StartScreen extends StatelessWidget {
  // final Shader linearGradient = LinearGradient(
  //   colors: <Color>[Colors.white, Colors.red],
  // ).createShader(Rect.fromLTRB(150.0, 0.0, 250.0, 50.0));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://image.freepik.com/darmowe-zdjecie/osoba-machajaca-flaga-rzeczypospolitej-polskiej_53876-21034.jpg"),
              fit: BoxFit.fitHeight,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Wybory Prezydenckie \n2020',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w600),
                // TextStyle(
                //     fontSize: 30.0,
                //     fontWeight: FontWeight.bold,
                //     foreground: Paint()..shader = linearGradient),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 75,
              ),
              OutlineButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Przejd? do g?osowania ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(letterSpacing: .5),
                      ),
                    ),
                    Icon(Icons.flag)
                  ],
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/validationScreen');
                },
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                borderSide: BorderSide(width: 2, color: Colors.white),
                highlightElevation: 10,
                highlightColor: Colors.red,
                splashColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VotingScreen extends StatelessWidget {
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VotingScreenProvider>(
        create: (context) => VotingScreenProvider(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                accentColor: Colors.red,
                accentColorBrightness: Brightness.dark,
                primaryColor: Colors.red,
                brightness: Brightness.light,
              ),
              home: Scaffold(
                body: Container(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Consumer<VotingScreenProvider>(
                      builder: (context, provider, child) {
                        return Form(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                    'Sprawd? czy masz prawo do g?osowania w wyborach prezydenckich 2020',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .apply(color: Colors.black87)),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      labelText: 'Twój wiek',
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: provider.validateAge,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                OutlineButton(
                                  child: Text(
                                    'Sprawd?',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(letterSpacing: .5),
                                    ),
                                  ),
                                  onPressed: () {
                                    // getting text from FormField
                                    final int age =
                                        int.parse(ageController.text.trim());

                                    //call method to check the age
                                    provider.checkElgiblity(age);
                                  },
                                  color: Colors.white,
                                  textColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.red),
                                  highlightElevation: 10,
                                  // highlightColor: Colors.redAccent,
                                  splashColor: Colors.red,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      provider.elgiblityMessage,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    provider.isElgible == true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              OutlineButton(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text('G?osuj! '),
                                                    Icon(Icons
                                                        .arrow_forward_ios),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  // Navigate to the second screen using a named route.

                                                  // Navigator.pushNamed(
                                                  //     context, '/candidateList');
                                                  provider
                                                      .navigateAndDisplaySelection(
                                                          context);
                                                },
                                                color: Colors.white,
                                                textColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.red),
                                                highlightElevation: 10,
                                                // highlightColor: Colors.redAccent,
                                                splashColor: Colors.red,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ]),
                          key: provider.formKey,
                          autovalidate: provider.autoValidate,
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
