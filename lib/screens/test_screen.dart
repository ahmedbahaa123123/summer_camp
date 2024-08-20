import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> _questions = [
    "Do you have a mental illness?", // Question 1 (reordered)
    "How do you handle feedback from coaches or teammates? Do you prefer direct, individual feedback or collective guidance?",
    "Do you prefer being solely responsible for the outcome of your performance, or do you like sharing the responsibility with a team?",
    "Do you enjoy working closely with others, or do you prefer activities where you can focus solely on your own performance?", // Question 4 (reordered)
  ];

  int _currentQuestionIndex = 0;

  void _handleNext() {
    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Color(0xFF1E2021), // Dark background color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question: ${_currentQuestionIndex + 1}/${_questions.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red, // White text color
              ),
            ),
            SizedBox(height: 16),
            Text(
              _questions[_currentQuestionIndex],
              style: TextStyle(
                fontSize: 16,
                color: Colors.red, // White text color
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle "Yes" answer
                    _handleNext();
                  },
                  child: Text('Yes'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                     backgroundColor: Color(0xFFF5851F),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle "No" answer
                    _handleNext();
                  },
                  child: Text('No'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFF5851F),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            if (_currentQuestionIndex == _questions.length - 1)
              ElevatedButton(
                onPressed: () {
                  // Handle submit button press (final question)
                  // Implement your logic here
                },
                child: Text('SUBMIT'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFF5851F),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}