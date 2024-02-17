import 'package:flutter/material.dart';

// int rowLength = 10;
// int columnLength = 15;

int rowLength = 10;
int columnLength = 17;

int gameSpeed = 400;

Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xffFF5733),
  Tetromino.J: Color(0xff4CAF50),
  Tetromino.I: Color(0xffFFEB3B),
  Tetromino.O: Color(0xff03A9F4),
  Tetromino.S: Color(0xffFFC107),
  Tetromino.Z: Color(0xff9C27B0),
  Tetromino.T: Color(0xffFF5722),
};

enum Tetromino { L, J, I, O, S, Z, T }

enum Direction { left, right, down }
