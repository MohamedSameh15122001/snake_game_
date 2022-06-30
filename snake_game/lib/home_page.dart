// ignore_for_file: camel_case_types, constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/map/pixel_of_food.dart';
import 'package:snake_game/map/pixel_of_head.dart';
import 'package:snake_game/map/pixels_of_map.dart';
import 'package:snake_game/map/pixels_of_snake.dart';
import 'package:snake_game/methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 200), ((timer) {
      setState(() {
        moveSnake();

        if (gameOver()) {
          timer.cancel();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Game Over'),
                  content: Text('Your Score is ${currentScore.toString()}'),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        newGame();
                      },
                      color: Colors.red,
                      child: const Text('Cancel'),
                    )
                  ],
                );
              });
        }
      });
    }));
  }

  void newGame() {
    setState(() {
      snakeSize = [0, 1, 2];
      currentScore = 0;
      foodPos = 104;
      currentDirection = snakeDirections.RIGHT;
      gameHasStarted = false;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  // audioPlayer.onPlayerStateChanged.listen((state) {
  //   setState(() {
  //     isPlaying = state == PlayerState.playing;
  //   });
  // });
  // audioPlayer.onDurationChanged.listen((newDuration) {
  //   duration = newDuration;
  // });
  // audioPlayer.onPositionChanged.listen((newPosition) {
  //   position = newPosition;
  // });
  // }

  // final audioPlayer = AudioPlayer();

  // bool isPlaying = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // String path = 'assets/audio/eat.mp3';
  // audioPlayer.setSourceUrl('assets/audio/eat/mp3');
  // Future playSong() async {
  //   final player = AudioCache(prefix: 'assets/audio/');
  //   final url = await player.load('eat.mp3');
  //   await audioPlayer.setSourceUrl(
  //     url.path,
  //   );
  //   audioPlayer.setSourceDeviceFile(url.path);
  //   await audioPlayer.play(source);
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
              currentDirection != snakeDirections.UP) {
            currentDirection = snakeDirections.DOWN;
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
              currentDirection != snakeDirections.DOWN) {
            currentDirection = snakeDirections.UP;
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) &&
              currentDirection != snakeDirections.RIGHT) {
            currentDirection = snakeDirections.LEFT;
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
              currentDirection != snakeDirections.LEFT) {
            currentDirection = snakeDirections.RIGHT;
          }
        },
        child: SizedBox(
          width: screenWidth > 428 ? 428 : screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          currentScore.toString(),
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'High Score',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          highScore.toString(),
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0 &&
                        currentDirection != snakeDirections.UP) {
                      currentDirection = snakeDirections.DOWN;
                    }
                    if (details.delta.dy < 0 &&
                        currentDirection != snakeDirections.DOWN) {
                      currentDirection = snakeDirections.UP;
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0 &&
                        currentDirection != snakeDirections.LEFT) {
                      currentDirection = snakeDirections.RIGHT;
                    }
                    if (details.delta.dx < 0 &&
                        currentDirection != snakeDirections.RIGHT) {
                      currentDirection = snakeDirections.LEFT;
                    }
                  },
                  child: GridView.builder(
                    itemCount: totalNumberOfSquares,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowSize,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (snakeSize.last == index) {
                        return const PixelOfHead();
                      } else if (index == foodPos) {
                        return const PixelOfFood();
                      } else if (snakeSize.contains(index)) {
                        return const PixelOfSnake();
                      }
                      {
                        return const PixelOfMap();
                      }
                    },
                  ),
                ),
              ),
              gameHasStarted
                  ? const Text('You Can Swipe Or Press To Play')
                  : Container(),
              gameHasStarted
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (currentDirection != snakeDirections.RIGHT) {
                                currentDirection = snakeDirections.LEFT;
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                            ),
                            iconSize: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (currentDirection !=
                                      snakeDirections.DOWN) {
                                    currentDirection = snakeDirections.UP;
                                  }
                                },
                                icon: const Icon(Icons.arrow_upward_rounded),
                                iconSize: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (currentDirection != snakeDirections.UP) {
                                    currentDirection = snakeDirections.DOWN;
                                  }
                                },
                                icon: const Icon(Icons.arrow_downward_rounded),
                                iconSize: 50,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              if (currentDirection != snakeDirections.LEFT) {
                                currentDirection = snakeDirections.RIGHT;
                              }
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
                            iconSize: 50,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: MaterialButton(
                          onPressed: gameHasStarted ? null : startGame,
                          color: gameHasStarted ? Colors.grey : Colors.red,
                          child: const Text(
                            'PLAY',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
