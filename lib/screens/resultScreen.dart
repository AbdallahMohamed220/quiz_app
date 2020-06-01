import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizer/screens/homeScreen.dart';

class ResultScreen extends StatefulWidget {
  final marks;
  ResultScreen({this.marks});

  @override
  _ResultScreenState createState() => _ResultScreenState(marks);
}

class _ResultScreenState extends State<ResultScreen> {
  final marks;
  _ResultScreenState(this.marks);

  String _message = '';
  String _image = '';
  List<String> _images = [
    'images/bad.png',
    'images/good.png',
    'images/success.png',
  ];

  @override
  void initState() {
    super.initState();
    if (marks <= 50) {
      _image = _images[0];
      _message = 'You Should Try Hard ';
    } else if (marks <= 60) {
      _image = _images[1];
      _message = 'You Can Do Better';
    } else {
      _image = _images[2];
      _message = 'You Did Very Well';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text(
          'Result',
          style: GoogleFonts.quando(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(_image),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Your Score is $marks/100',
                          style: GoogleFonts.quando(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _message,
                        style: GoogleFonts.quando(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          height: 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 25,
                  ),
                  borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 3,
                  ),
                  splashColor: Colors.indigo,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
