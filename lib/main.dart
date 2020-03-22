import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'states/vote_state.dart';
import 'candidate_list.dart';
import 'thanks_screen.dart';

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
        '/thankYouScreen': (context) => ThankYouPage(),
      },
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('polish_flag.jpg'),
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Wybory Prezydenckie \n2020',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w600),
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
                    'Przejdz do glosowania ',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(letterSpacing: .5),
                    ),
                  ),
                  Icon(Icons.flag)
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/validationScreen');
              },
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              borderSide: BorderSide(width: 2, color: Colors.white),
              highlightElevation: 10,
              highlightColor: Colors.red,
              highlightedBorderColor: Colors.white,
              splashColor: Colors.white,
            ),
          ],
        ));
  }
}

class VotingScreen extends StatelessWidget {
  final ageController = TextEditingController();
  final peselController = TextEditingController();
  final nameController = TextEditingController();

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
                                  height: 10,
                                ),
                                Text(
                                    'Sprawdz czy mozesz glosowac w Wyborach Prezydenckich \n2020',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .apply(color: Colors.black87)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        labelText: 'Imie i nazwisko',
                                        prefixIcon: Icon(Icons.person)),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: peselController,
                                    decoration: InputDecoration(
                                      labelText: 'Pesel',
                                      prefixIcon: Icon(Icons.lock_outline),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: provider.validateAge,
                                    maxLength: 11,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                OutlineButton(
                                  child: Text(
                                    'Sprawdz',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(letterSpacing: .5),
                                    ),
                                  ),
                                  onPressed: () {
                                    // getting text from FormField
                                    final int pesel =
                                        int.parse(peselController.text.trim());

                                    //call method to check the age
                                    provider.checkPesel(pesel);
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
                                                    Text('Glosuj! '),
                                                    Icon(Icons
                                                        .arrow_forward_ios),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  // Navigate to the second screen using a named route.

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CandidateList()),
                                                  );
                                                  // provider
                                                  //     .navigateAndDisplaySelection(
                                                  //         context);
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
