import 'package:flutter/material.dart';
import 'constants.dart';
import 'eligibility_sceen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isButtonInActive;
  String selectedStream = 'CSE';
  final List<String> subjectName = <String>[];
  final List<int> percentageText = <int>[];
  final List<int> percentage = <int>[];
  int eligiblePercentageCounter;

  void getData() {
    eligiblePercentageCounter = 0;

    if (selectedStream == 'CSE') {
      subjectName.clear();
      subjectName.add('math');
      subjectName.add('phy');
      subjectName.add('che');
    } else if (selectedStream == 'ECE') {
      subjectName.clear();
      subjectName.add('phy');
      subjectName.add('che');
      subjectName.add('math');
    } else {
      subjectName.clear();
    }

    for (int i = 0; i < subjectName.length; i++) {
      percentageText.add(0);
      percentage.add(0);
    }
  }

  DropdownButton getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String selectedStream in streamList) {
      var newItem = DropdownMenuItem(
        child: Text(selectedStream),
        value: selectedStream,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedStream,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          percentageText.clear();
          selectedStream = value;
          getData();
          isButtonInActive = true;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    eligiblePercentageCounter = 0;
    isButtonInActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Eligibility Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.tealAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Subject',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                getDropDownButton(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(16.0),
              itemCount: subjectName.length,
              itemBuilder: (BuildContext context, int index) {
                String subject = subjectName[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        )),
                    height: 150.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            subject.toUpperCase(),
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.yellow),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '${percentageText[index].toString()}%',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbColor: Color(0xFFEB1555),
                            overlayColor: Color(0x29EB1555),
                            activeTrackColor: Color(0xFF8D8E98),
                            inactiveTrackColor: Colors.white30,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30.0),
                          ),
                          child: Slider(
                            value: percentageText[index].toDouble(),
                            min: 0.0,
                            max: 100.0,
                            onChanged: (double newValue) {
                              setState(() {
                                percentageText[index] = newValue.round();
                              });
                            },
                            onChangeEnd: (double endValue) {
                              setState(() {
                                percentage[index] = endValue.round();
                                isButtonInActive = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 80.0,
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text('Check Eligibity'),
              onPressed: isButtonInActive
                  ? null
                  : () {
                      eligiblePercentageCounter = 0;
                      setState(() {
                        for (int i = 0; i < percentage.length; i++) {
                          if (percentage[i] >= 60.0) {
                            eligiblePercentageCounter++;
                          }
                        }
                        print(eligiblePercentageCounter);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EligibilityScreen(
                                  scorePercentage: eligiblePercentageCounter,
                                  selectedStream: selectedStream,
                                )),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
}
