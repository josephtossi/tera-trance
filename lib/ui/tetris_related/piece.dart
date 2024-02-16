import 'package:flutter/material.dart';
import 'package:tetratrance/ui/tetris.dart';
import 'package:tetratrance/ui/tetris_related/values.dart';


class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> positions = [];

  Color getColor() {
    return tetrominoColors[type] ?? Colors.white;
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.I:
        positions = [-4, -5, -6, -7];
        break;
      case Tetromino.J:
        positions = [-25, -15, -5, -6];
        break;
      case Tetromino.L:
        positions = [-26, -16, -6, -5];
        break;
      case Tetromino.O:
        positions = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        positions = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        positions = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        positions = [-26, -16, -6, -15];
        break;
      default:
        break;
    }
  }

  void movePiece({required Direction direction}) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += rowLength;
        }
        break;
      case Direction.right:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += 1;
        }
        break;
      case Direction.left:
        for (int i = 0; i < positions.length; i++) {
          positions[i] -= 1;
        }
        break;
      default:
        break;
    }
  }

  int rotationState = 1;

  rotatePiece() {
    List<int> newPosition = [];
    switch (type) {
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + 2,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + 2 * rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] - 2,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - 2 * rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + rowLength - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - rowLength - 1,
              positions[1],
              positions[1] - 1,
              positions[1] + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] + rowLength + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + rowLength + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[1] - rowLength + 1,
              positions[1],
              positions[1] + 1,
              positions[1] - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
              positions[1] + rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[0] - rowLength,
              positions[0],
              positions[0] + 1,
              positions[0] + rowLength + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
              positions[1] + rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[0] - rowLength,
              positions[0],
              positions[0] + 1,
              positions[0] + rowLength + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[0] + rowLength -2,
              positions[1],
              positions[2] + rowLength - 1,
              positions[3] + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[0] - rowLength + 2,
              positions[1],
              positions[2] - rowLength + 1,
              positions[3] - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[0] + rowLength - 2,
              positions[1],
              positions[2] + rowLength - 1,
              positions[3] + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[0] - rowLength + 2,
              positions[1],
              positions[2] - rowLength + 1,
              positions[3] - 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              positions[2] - rowLength,
              positions[2],
              positions[2] + 1,
              positions[2] + rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              positions[1] - rowLength,
              positions[1] - 1,
              positions[1],
              positions[1] + rowLength,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              positions[2] - rowLength ,
              positions[2] - 1,
              positions[2],
              positions[2] + 1,
            ];
            if(peicePositionIsValid(newPosition)){
              positions = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
      default:
        break;
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }else{
      return true;
    }
  }

  bool peicePositionIsValid(List piecePosition){
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for(int pos in piecePosition){
      if(!positionIsValid(pos)){
        return false;
      }
      int col = pos % rowLength;

      if(col == 0){
        firstColOccupied = true;
      }
      if(col == rowLength - 1){
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
