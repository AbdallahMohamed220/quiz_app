import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizer/screens/resultScreen.dart';
import 'package:responsive/responsive_row.dart';

String assettoload;

class GetJson extends StatelessWidget {
  final String langName;

  GetJson({this.langName});
  setAsset() {
    if (langName == "Python") {
      assettoload = "assets/python.json";
    } else if (langName == "Java") {
      assettoload = "assets/java.json";
    } else if (langName == "JavaScript") {
      assettoload = "assets/js.json";
    } else if (langName == "C++") {
      assettoload = "assets/cpp.json";
    } else {
      assettoload = "assets/linux.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: true),
      builder: (context, snapshot) {
        var myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return QuizeScreen(
            myData: myData,
            langName: langName,
          );
        }
      },
    );
  }
}

class QuizeScreen extends StatefulWidget {
  final myData;
  final langName;
  QuizeScreen({this.myData, this.langName});

  @override
  _QuizeScreenState createState() => _QuizeScreenState(myData, langName);
}

class _QuizeScreenState extends State<QuizeScreen> {
  var myData;
  var langName;
  _QuizeScreenState(this.myData, this.langName);
  Color colorToShow = Colors.indigo;
  Color right = Colors.green;
  Color wrong = Colors.red;
  Map<String, Color> btnColor = {
    'a': Colors.indigo,
    'b': Colors.indigo,
    'c': Colors.indigo,
    'd': Colors.indigo,
  };
  List<Icon> scoreKeeper = [];
  var marks = 0;
  int questionNumber = 1;
  int timer = 31;
  String showTimer = '30';
  bool cancelTimer = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          scoreKeeper.add(Icon(Icons.close, size: 30, color: Colors.red));
          moveToNextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void moveToNextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (questionNumber < 10) {
        questionNumber++;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResultScreen(marks: marks),
          ),
        );
      }

      btnColor['a'] = Colors.indigo;
      btnColor['b'] = Colors.indigo;
      btnColor['c'] = Colors.indigo;
      btnColor['d'] = Colors.indigo;
    });
    startTimer();
  }

  void checkAnswer(String k) {
    setState(() {
      if (myData[2]['1'] == myData[1]['1'][k]) {
        marks = marks + 10;
        colorToShow = right;
        scoreKeeper.add(Icon(Icons.check, size: 30, color: Colors.green));
      } else {
        colorToShow = wrong;
        scoreKeeper.add(Icon(Icons.close, size: 30, color: Colors.red));
      }
      btnColor[k] = colorToShow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 2), moveToNextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: MaterialButton(
        elevation: 10,
        onPressed: () => checkAnswer(k),
        child: Text(
          myData[1][questionNumber.toString()][k],
          style: GoogleFonts.alike(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: btnColor[k],
        minWidth: 200,
        height: 45,
        highlightColor: Colors.indigo[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text(langName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 15, left: 15),
              child: Container(
                height: 65,
                width: double.infinity,
                child: ResponsiveRow(
                  columnsCount: 2,
                  // crossAxisAlignment: WrapCrossAlignment.end,
                  alignment: WrapAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 30,
                      child: Text(
                        '$questionNumber/10',
                        style: GoogleFonts.quando(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 30,
                      child: Text(
                        showTimer,
                        style: GoogleFonts.quando(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(top: 4, bottom: 20, left: 15, right: 15),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    myData[0][questionNumber.toString()],
                    style: GoogleFonts.quando(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  children: <Widget>[
                    choiceButton('a'),
                    choiceButton('b'),
                    choiceButton('c'),
                    choiceButton('d'),
                  ],
                ),
              ),
            ),
            Container(
                width: 320,
                height: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 2,
                  ),
                ),
                child: Row(children: scoreKeeper)),
          ],
        ),
      ),
    );
  }
}
