import 'package:flutter/material.dart';

class CircularProgressScreen extends StatefulWidget {
  @override
  _CircularProgressScreenState createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startTask();
  }

  void _startTask() async {
    // Simulating a 15-second task that updates progress every second
    for (int i = 1; i <= 15; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _progress = i / 15; // Update the progress based on the task completion
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Progress Indicator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              '${(_progress * 100).toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
