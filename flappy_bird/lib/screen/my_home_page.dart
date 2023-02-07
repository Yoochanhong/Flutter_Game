import 'package:flutter/material.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });
      print(birdY);
      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.01;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                'G A M E  O V E R',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) return true;
    return false;
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment(0, birdY),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.yellow,
                        ),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(gameHasStarted ? '' : 'T A P  T O  P L A Y',
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
