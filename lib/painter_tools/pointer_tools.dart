import 'dart:ui';

import 'package:flutter_pain_prototype/painter_state/painter_state.dart';
import 'package:flutter_pain_prototype/primitives/primitives.dart';
import 'package:uuid/uuid.dart';

abstract class Tool {
  PainterState state;

  Tool(this.state);

  PainterState onTapDown(Offset offset);

  PainterState onPanUpdate(Offset offset);

  PainterState onPanStart(Offset offset);

  PainterState onPanEnd();
}

class PointTool extends Tool {
  PointTool(PainterState state) : super(state);

  @override
  PainterState onTapDown(Offset offset) {
    return state.addPoint(Point.fromOffset(Uuid().v4(), offset));
  }

  @override
  PainterState onPanUpdate(Offset offset) {
    return state.addPoint(Point.fromOffset(Uuid().v4(), offset));
  }

  @override
  PainterState onPanEnd() {
    return state;
  }

  @override
  PainterState onPanStart(Offset offset) {
    return state;
  }
}

class LineTool extends Tool {
  LineTool(PainterState state) : super(state);

  Offset _start;
  Offset _end;

  Line _currentLine;

  @override
  PainterState onPanUpdate(Offset offset) {
    _end = offset;

    return state.removeLine(_currentLine).addLine(_currentLine =
        Line(id: _currentLine?.id ?? Uuid().v4(), start: _start, end: _end));
  }

  @override
  PainterState onTapDown(Offset offset) {
    return state;
  }

  @override
  PainterState onPanEnd() {
    _currentLine = null;
    return state;
  }

  @override
  PainterState onPanStart(Offset offset) {
    _start = offset;
    return state;
  }
}

class HandTool extends Tool {
  HandTool(PainterState state) : super(state);

  Offset _start;
  Offset _end;

  Offset _initial;

  @override
  PainterState onPanEnd() {
    return state;
  }

  @override
  PainterState onPanStart(Offset offset) {
    _start = offset;
    _initial = state.canvasOffset;
    return state;
  }

  @override
  PainterState onPanUpdate(Offset offset) {
    _end = offset;
    return state.canvasTranslate(_initial + (_end - _start));
  }

  @override
  PainterState onTapDown(Offset offset) {
    return state;
  }
}
