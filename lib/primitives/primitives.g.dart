// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primitives.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) {
  return Point(
    x: (json['x'] as num).toDouble(),
    y: (json['y'] as num).toDouble(),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
    };

Line _$LineFromJson(Map<String, dynamic> json) {
  return Line(
    start: Line._offsetFromJson(json['start'] as Map<String, dynamic>),
    end: Line._offsetFromJson(json['end'] as Map<String, dynamic>),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$LineToJson(Line instance) => <String, dynamic>{
      'id': instance.id,
      'start': Line._offsetToJson(instance.start),
      'end': Line._offsetToJson(instance.end),
    };
