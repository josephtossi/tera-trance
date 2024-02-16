import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tetratrance/ui/tetris_related/piece.dart';
import 'package:tetratrance/ui/tetris_related/pixel.dart';
import 'package:tetratrance/ui/tetris_related/values.dart';


List<List<Tetromino?>> gameBoard =
    List.generate(columnLength, (i) => List.generate(rowLength, (j) => null));

class Tetris extends StatefulWidget {
  @override
  _TetrisState createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  int currentScore = 0;
  bool isGameOver = false;
  bool isPressed = false;

  /// current tetris piece ///
  Piece currentPiece = Piece(type: Tetromino.T);

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = Duration(milliseconds: gameSpeed);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        /// clearing the lines ///
        clearLines();

        /// check for the landing ///
        checkLanding();

        if (isGameOver) {
          timer.cancel();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('game over'),
                    content: Text('lost: $currentScore'),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          gameBoard = List.generate(columnLength,
                              (i) => List.generate(rowLength, (j) => null));
                          isGameOver = false;
                          currentScore = 0;
                          createNewPiece();
                          startGame();
                          Navigator.pop(context);
                        },
                        child: Text('ok'),
                      )
                    ],
                  ));
        }

        /// move current piece down ///
        currentPiece.movePiece(direction: Direction.down);
      });
    });
  }

  bool checkCollision(Direction direction) {
    // loop through all direction index
    for (int i = 0; i < currentPiece.positions.length; i++) {
      // calculate the index of the current piece
      int row = (currentPiece.positions[i] / rowLength).floor();
      int col = (currentPiece.positions[i] % rowLength);

      // directions
      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.left) {
        col--;
      }

      // check for collisions with boundaries
      if (col < 0 || col >= rowLength || row >= columnLength) {
        return true;
      }

      // check for collisions with other landed pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    // if there is no collision return false
    return false;
  }

  checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.positions.length; i++) {
        int row = (currentPiece.positions[i] / rowLength).floor();
        int col = currentPiece.positions[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      /// once landed fill out new piece ///
      createNewPiece();
    }
  }

  createNewPiece() {
    /// create random tetris piece each time ///
    Random random = Random();
    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (gameOver()) {
      isGameOver = true;
    }
  }

  /// movements ///
  moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(direction: Direction.left);
      });
    }
  }

  moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(direction: Direction.right);
      });
    }
  }

  moveDown() {
    if (!checkCollision(Direction.down)) {
      setState(() {
        currentPiece.movePiece(direction: Direction.down);
      });
    }
  }

  rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  /// to clear lines and increment score ///
  clearLines() {
    for (int row = columnLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool gameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff171648), Color(0xff301585)])
      ),
      child: Column(
        children: [
          Container(
            height: height * .14,
            color: Color(0xff171648),
            child: Center(
              child: Text('Score:${currentScore}',style: TextStyle(color: Colors.white,fontSize: 14),),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                rotatePiece();
              },
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  moveDown();
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  moveRight();
                }
                else {
                  moveLeft();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5)
                  ),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xfff4f5ff), Color(0xff7158f3)]),
                    width: 4,
                  ),
                ),
                margin: EdgeInsets.all(.5),
                child: Center(
                  child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rowLength * columnLength,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rowLength),
                      itemBuilder: (context, index) {
                        int row = (index / rowLength).floor();
                        int col = index % rowLength;

                        if (currentPiece.positions.contains(index)) {
                          return Pixel(
                            color: tetrominoColors[currentPiece.type]!,
                            child: Container(),
                          );
                        } else if (gameBoard[row][col] != null) {
                          final Tetromino? tetroType = gameBoard[row][col];
                          return Pixel(
                            color: tetrominoColors[tetroType]!,
                            child: Container(),
                          );
                        } else {
                          return Pixel(
                            color: Colors.transparent,
                            child: Container(),
                          );
                        }
                      }),
                ),
              ),
            ),
          ),
          Container(
            height: height * .12,
            width: width,
            color: Color(0xff301585),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onLongPressStart: (_) async {
                      isPressed = true;
                      do {
                        moveLeft();
                        await Future.delayed(Duration(milliseconds: 100));
                      } while (isPressed);
                    },
                    onLongPressEnd: (_) => setState(() => isPressed = false),
                    onTap: () {
                      moveLeft();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff7158f3),
                      ),
                      height: height * .1,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chevron_left_outlined,color: Colors.white,),
                            Text('Move Left',style: TextStyle(color: Colors.white,fontSize: 10),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      rotatePiece();
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff7158f3),
                      ),
                      height: height * .1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.rotate_left_rounded,color: Colors.white,),
                            Text('Rotate',style: TextStyle(color: Colors.white,fontSize: 10),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onLongPressStart: (_) async {
                      isPressed = true;
                      do {
                        moveRight();
                        await Future.delayed(Duration(milliseconds: 100));
                      } while (isPressed);
                    },
                    onLongPressEnd: (_) => setState(() => isPressed = false),
                    onTap: () {
                      moveRight();
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff7158f3),
                      ),
                      height: height * .1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chevron_right_outlined,color: Colors.white,),
                            Text('Move Right',style: TextStyle(color: Colors.white,fontSize: 10),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

