import 'package:flutter/material.dart';
import 'package:summer_camp/screens/signUp_screen.dart';
import 'package:summer_camp/screens/test_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _questions = [
    "Do you have a mental illness?",
    "Are you interested in soccer?",
    "Would you watch a baseball game?",
    "Do you play tennis?",
  ];

  int _currentQuestionIndex = 0;
  int _noAnswersCount = 0;
  bool _showVideo = false;

  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=PMpZukqYpH4")!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _handleAnswer(bool isYes) {
    if (_currentQuestionIndex == 0 && isYes) {
      _showDialog("You'll play Individual Sports");
      _removeAllQuestions();
      _showVideoPlayer();
    } else if (_currentQuestionIndex == 0 && !isYes) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      if (!isYes) _noAnswersCount++;
      _currentQuestionIndex++;

      if (_currentQuestionIndex == _questions.length || _noAnswersCount >= 2) {
        _showDialog("You'll play Team Sports");
        _removeAllQuestions();
        _showVideoPlayer();
      } else if (_currentQuestionIndex < _questions.length) {
        setState(() {});
      }
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Align(
            alignment: Alignment.centerLeft,
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _removeAllQuestions() {
    setState(() {
      _currentQuestionIndex = _questions.length;
    });
  }

  void _showVideoPlayer() {
    setState(() {
      _showVideo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 32, 33),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 22, 23),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30), // Increased space at the top
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Hi, ${widget.username}!',
                        style: const TextStyle(
                          fontSize: 28, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20, // Increased space between text and container
                    ),
                    Container(
                      height: 80, // Increased height of the container
                      width: 180, // Increased width of the container
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adjusted padding
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 229, 255, 0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 229, 255, 0),
                          width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            child: const Text("Instructions",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("1. Login/Signup/Google Sign-In"),
                                          SizedBox(height: 15,),
                                          Text("2. Answer some questions"),
                                          SizedBox(height: 15,),
                                          Text("3. You will get the preferred sport"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Increased space between rows
                if (_currentQuestionIndex < _questions.length)
                  ElevatedButton(
                    child: Text("Test YourSelf->"),
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => QuizScreen())),
                  ),
                const SizedBox(height: 30), // Increased space at the bottom
                if (_showVideo)
                  YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQuestionDialog(String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(question),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleAnswer(true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleAnswer(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}