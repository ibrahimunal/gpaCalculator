import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String courseName;
  int courseCredit = 1;
  double letterGrade = 4;
  List<Course> myCourses;
  double GPA = 0;
  static int counter = 0;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCourses = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('GPA CALCULATOR'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                //color: Colors.red.shade200,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Course Name',
                                hintText: 'Please enter course name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            validator: (input) {
                              if (input.length > 0) {
                                return null;
                              } else {
                                return "Please enter a course name";
                              }
                            },
                            onSaved: (input) {
                              courseName = input;
                              setState(() {
                                myCourses.add(Course(
                                    courseName, letterGrade, courseCredit));
                                _setGPA();
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue.shade200, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                      items: courseCreditItems(),
                                      value: courseCredit,
                                      onChanged: (choosenCredit) {
                                        setState(() {
                                          courseCredit = choosenCredit;
                                        });
                                      }),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue.shade200, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<double>(
                                        items: letterGradeItems(),
                                        value: letterGrade,
                                        onChanged: (choosenLetterGrade) {
                                          setState(() {
                                            letterGrade = choosenLetterGrade;
                                          });
                                        }))),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        text: "GPA: ",
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                    TextSpan(
                        text: myCourses.length == 0
                            ? "0.00"
                            : "${GPA.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 25, color: Colors.blue))
                  ]))),
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          top: BorderSide(color: Colors.blueAccent, width: 2),
                          bottom:
                              BorderSide(color: Colors.blueAccent, width: 2))),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  color: Colors.teal.shade100,
                  child: ListView.builder(
                    itemBuilder: createListElements,
                    itemCount: myCourses.length,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> courseCreditItems() {
    List<DropdownMenuItem<int>> credits = [];
    for (int i = 1; i <= 10; i++) {
      credits.add(DropdownMenuItem<int>(
        value: i,
        child: Text('$i kredi'),
      ));
    }
    return credits;
  }

  List<DropdownMenuItem<double>> letterGradeItems() {
    List<DropdownMenuItem<double>> letters = [];

    letters.add(DropdownMenuItem(
      child: Text(
        'AA',
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'BA ',
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'BB',
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'CB',
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'CC',
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'DC',
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'DD',
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        'FF',
        style: TextStyle(fontSize: 20),
      ),
      value: 0.5,
    ));
    return letters;
  }

  Widget createListElements(BuildContext context, int index) {
    counter++;
    debugPrint(counter.toString());
    return Dismissible(
        key: Key(counter.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          setState(() {
            myCourses.removeAt(index);
            _setGPA();
          });
        },
        child: Container(
            height: 45,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Container(
                child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "${myCourses[index].name} with ${myCourses[index].letterGrade} letter grade",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "swipe right to remove",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.red,
                ),
              ],
            ))));
  }

  void _setGPA() {
    double sumOfGPA = 0;
    int divider = 0;

    for (int i = 0; i < myCourses.length; i++) {
      sumOfGPA += myCourses[i].letterGrade * myCourses[i].credit;
      divider += myCourses[i].credit;
    }
    GPA = sumOfGPA / divider;
  }
}

class Course {
  String name;
  double letterGrade;
  int credit;

  Course(this.name, this.letterGrade, this.credit);
}
