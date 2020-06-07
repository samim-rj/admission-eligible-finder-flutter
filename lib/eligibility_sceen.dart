import 'package:flutter/material.dart';

class EligibilityScreen extends StatefulWidget {
  EligibilityScreen({this.scorePercentage, this.selectedStream});
  final scorePercentage;
  final String selectedStream;
  @override
  _EligibilityScreenState createState() => _EligibilityScreenState();
}

class _EligibilityScreenState extends State<EligibilityScreen> {
  int scorePercentage;
  String selectedStream;

  @override
  void initState() {
    scorePercentage = widget.scorePercentage;
    selectedStream = widget.selectedStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: scorePercentage == 3
                  ? AssetImage('images/tick.jpg')
                  : AssetImage('images/cross.jpg'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                (scorePercentage == 3)
                    ? 'you are eligible to apply in $selectedStream'
                    : 'you are not eligible to apply in $selectedStream',
                style: TextStyle(
                    fontSize: 40.0,
                    color: (scorePercentage == 3) ? Colors.green : Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
