import 'dart:math';
import 'package:flutter/material.dart';
import 'package:year_countdown/life.dart';

class Grid extends StatefulWidget {
  Grid({Key key, @required this.life}) : super(key: key);

  final Life life;

  // 网格的颜色
  static List<int> colors = [
    0xFFFFFFFF,
    0xAAD4DFE6,
    0xAA8EC0E4,
    0xAACADBE9,
    0xAA6AAFE6,
    0xAAA5DFF9,
    0xAAFEEE7D,
    0xAAFAB1CE,
    0xAAFFDA8E
  ];

  static BorderSide _borderThin =
      new BorderSide(width: 0.5, color: Color(0xFFE0E3DA));
  static BorderSide _borderBold =
      new BorderSide(width: 1.0, color: Color(0xFFE0E3DA));

  Border generateBorder(int x, int y) {
    BorderSide leftBorder = _borderThin;
    BorderSide topBorder = _borderThin;
    BorderSide rightBorder = _borderThin;
    BorderSide bottomBorder = _borderThin;

    if (x == 0) {
      topBorder = _borderBold;
    } else if (x == this.life.life / 30 - 1) {
      bottomBorder = _borderBold;
    }

    if (y == 0) {
      leftBorder = _borderBold;
    } else if (y == 29) {
      rightBorder = _borderBold;
    }

    return new Border(
      left: leftBorder,
      top: topBorder,
      right: rightBorder,
      bottom: bottomBorder,
    );
  }

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    //宽 一行30格
    final width = (MediaQuery.of(context).size.width - 2) / 30;
    var rng = new Random();

    // 当前行格子详情
    List<Widget> rowDetail(rowIndex) {
      List<Widget> result = new List<Widget>();
      int pastDays = widget.life.pastDays();
      int days = rowIndex * 30;
      for (int i = 0; i < 30; i++) {
        int currentDays = days + i;
        if (currentDays > widget.life.life) {
          break;
        }
        result.add(Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              border: widget.generateBorder(rowIndex, i),
              color: currentDays < pastDays
                  ? Color(0xFF5E5E5F)
                  : currentDays == pastDays
                      ? Colors.red
                      : currentDays < pastDays + 10
                          ? Colors.white
                          : Color(Grid.colors[
                              rng.nextInt(18) > 8 ? 0 : rng.nextInt(9)])),
        ));
      }
      return result;
    }

    // 所有行数
    List<Widget> rowList() {
      List<Widget> result = new List<Widget>();
      for (int i = 0; i < widget.life.life / 30; i++) {
        result.add(Row(
          children: rowDetail(i),
        ));
      }
      return result;
    }

    return Column(
      children: rowList(),
    );
  }
}
