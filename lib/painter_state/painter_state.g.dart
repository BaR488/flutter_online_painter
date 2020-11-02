// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PainterStateCopyWith on PainterState {
  PainterState copyWith({
    Offset canvasOffset,
    List<Line> lines,
    List<Point> points,
  }) {
    return PainterState(
      canvasOffset: canvasOffset ?? this.canvasOffset,
      id: id,
      lines: lines ?? this.lines,
      points: points ?? this.points,
      primitivesLayers: primitivesLayers,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PainterState _$PainterStateFromJson(Map<String, dynamic> json) {
  return PainterState(
    id: json['id'] as String,
    points: (json['points'] as List)
        .map((e) => Point.fromJson(e as Map<String, dynamic>))
        .toList(),
    lines: (json['lines'] as List)
        .map((e) => Line.fromJson(e as Map<String, dynamic>))
        .toList(),
    primitivesLayers: Map<String, int>.from(json['primitivesLayers'] as Map),
  );
}

Map<String, dynamic> _$PainterStateToJson(PainterState instance) =>
    <String, dynamic>{
      'primitivesLayers': instance.primitivesLayers,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'lines': instance.lines.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
