import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_online_painter/primitives/primitives.dart';
import 'package:json_annotation/json_annotation.dart';

part 'painter_state.g.dart';

@immutable
@CopyWith()
@JsonSerializable(nullable: false,explicitToJson: true)
class PainterState {
  List<Primitive> get primitives {
    return [...points, ...lines].map((e) => e.translate(canvasOffset)).toList()
      ..sort((a, b) {
        if (a != null && b != null) {
          return primitivesLayers[a.id] - primitivesLayers[b.id];
        }
        return 0;
      });
  }

  @CopyWithField(immutable: true)
  final Map<String, int> primitivesLayers;

  final List<Point> points;
  final List<Line> lines;

  @CopyWithField(immutable: true)
  final String id;

  @JsonKey(ignore: true)
  final Offset canvasOffset;

  PainterState({
    this.id,
    this.canvasOffset = const Offset(0, 0),
    this.points = const <Point>[],
    this.lines = const <Line>[],
    Map<String, int> primitivesLayers
  }): primitivesLayers = primitivesLayers ?? {};

  canvasTranslate(Offset offset) {
    return copyWith(canvasOffset: offset ?? Offset(0, 0));
  }

  addPoint(Point point) {
    primitivesLayers[point.id] = DateTime.now().millisecondsSinceEpoch;
    return copyWith(points: [...this.points, point.translate(-canvasOffset)]);
  }

  addLine(Line line) {
    primitivesLayers[line.id] = DateTime.now().millisecondsSinceEpoch;
    return copyWith(lines: [...this.lines, line.translate(-canvasOffset)]);
  }

  removeLine(Line line) {
    primitivesLayers.remove(line?.id);
    return copyWith(
        lines: [...this.lines.where((element) => element?.id != line?.id)]);
  }

  factory PainterState.fromJson(Map<String, dynamic> json) => _$PainterStateFromJson(json);
  Map<String, dynamic> toJson() => _$PainterStateToJson(this);
}
