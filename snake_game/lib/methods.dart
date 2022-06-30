import 'dart:math';
import 'package:snake_game/shared_preferences.dart';

//snake directions
// ignore: camel_case_types, constant_identifier_names
enum snakeDirections { UP, DOWN, RIGHT, LEFT }

//start location
snakeDirections currentDirection = snakeDirections.RIGHT;
//!map variables
int rowSize = 12;
int totalNumberOfSquares = 168;

int currentScore = 0;
bool gameHasStarted = false;
int highScore = CacheHelper.getData('highScore') ?? 0;
List<int> snakeSize = [0, 1, 2];
int foodPos = 104;

//make snake moving
void moveSnake() {
  switch (currentDirection) {
    case snakeDirections.RIGHT:
      {
        if (snakeSize.last % rowSize == 11) {
          snakeSize.add(snakeSize.last + 1 - rowSize);
        } else {
          snakeSize.add(snakeSize.last + 1);
        }
      }

      break;
    case snakeDirections.LEFT:
      {
        if (snakeSize.last % rowSize == 0) {
          snakeSize.add(snakeSize.last - 1 + rowSize);
        } else {
          snakeSize.add(snakeSize.last - 1);
        }
      }

      break;
    case snakeDirections.UP:
      {
        if (snakeSize.last < rowSize) {
          snakeSize.add(snakeSize.last - rowSize + totalNumberOfSquares);
        } else {
          snakeSize.add(snakeSize.last - rowSize);
        }
      }

      break;
    case snakeDirections.DOWN:
      {
        if (snakeSize.last + rowSize > totalNumberOfSquares) {
          snakeSize.add(snakeSize.last + rowSize - totalNumberOfSquares);
        } else {
          snakeSize.add(snakeSize.last + rowSize);
        }
      }

      break;
    default:
  }
  if (snakeSize.last == foodPos) {
    eatFood();
  } else {
    snakeSize.removeAt(0);
  }
}

//end the game
bool gameOver() {
  if (currentScore > highScore) {
    highScore = currentScore;
    CacheHelper.saveData(key: 'highScore', value: highScore);
  }

  List<int> bodySnake = snakeSize.sublist(
    0,
    snakeSize.length - 1,
  );
  if (bodySnake.contains(snakeSize.last)) {
    return true;
  }
  return false;
}

//eat the food
void eatFood() {
  // playSong();
  currentScore++;
  while (snakeSize.contains(foodPos)) {
    foodPos = Random().nextInt(totalNumberOfSquares);
  }
}
