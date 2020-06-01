import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizer/screens/quizeScreen.dart';
import 'package:responsive/responsive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget customeCard({String imagName, String title, String description}) {
    return FlexWidget(
      xs: 2,
      sm: 2,
      md: 2,
      lg: 2,
      xsLand: 2,
      smLand: 2,
      lgLand: 2,
      mdLand: 2,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          bottom: 15,
          right: 15,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => GetJson(
                        langName: title,
                      )),
            );
          },
          child: Material(
            elevation: 10,
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 230,
              // width: 160,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(
                              'images/$imagName.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Text(
                        title,
                        style: GoogleFonts.quando(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   child: Text(
                  //     description,
                  //     style: GoogleFonts.alike(
                  //       fontSize: 18,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       height: 1.4,
                  //     ),
                  //     maxLines: 1,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Quizer',
          style: GoogleFonts.quando(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
      ),
      body: ListView(
        children: <Widget>[
          ResponsiveRow(
            columnsCount: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              customeCard(
                imagName: 'py',
                title: 'Python',
                description: '',
                // Python is an interpreted, high-level, general-purpose programming language. Created by Guido van Rossum and first released in 1991
              ),
              customeCard(
                imagName: 'cpp',
                title: 'C++',
                description: '',
                //C++ is a general-purpose programming language created by Bjarne Stroustrup as an extension of the C programming language
              ),
            ],
          ),
          ResponsiveRow(
            columnsCount: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              customeCard(
                imagName: 'java',
                title: 'Java',
                description: '',
                //Java is a general-purpose programming language that is class-based, object-oriented, and designed to have as few implementation dependencies as possible
              ),
              customeCard(
                imagName: 'js',
                title: 'JavaScript',
                description: '',
                //JavaScript, often abbreviated as JS, is a high-level, just-in-time compiled, multi-paradigm programming language that conforms to the ECMAScript specification. JavaScript has curly-bracket syntax, dynamic typing, prototype-based object-orientation, and first-class functions.
              ),
            ],
          ),
          ResponsiveRow(
            columnsCount: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              customeCard(
                imagName: 'linux',
                title: 'Linux',
                description:
                    'Linux is a family of open source Unix-like operating systems based on the Linux kernel, an operating system kernel first released on September 17, 1991, by Linus Torvalds. Linux is typically packaged in a Linux distribution',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
