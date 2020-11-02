import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'primitives.g.dart';

abstract class Primitive {
  final String id;

  Primitive(this.id);

  Primitive translate(Offset offset);
}

@immutable
@JsonSerializable(nullable: false)
class Point extends Primitive {
  final double x;
  final double y;

  Point({this.x, this.y, @required String id}) : super(id);

  factory Point.fromOffset(String id, Offset offset) {
    return Point(id: id, x: offset.dx, y: offset.dy);
  }

  toOffset() {
    return Offset(x, y);
  }

  @override
  Primitive translate(Offset offset) {
    return Point.fromOffset(id, this.toOffset() + offset);
  }

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  Map<String, dynamic> toJson() => _$PointToJson(this);
}

@immutable
@JsonSerializable(nullable: false)
class Line extends Primitive {
  @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
  final Offset start;
  @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
  final Offset end;

  Line({this.start, this.end, @required String id}) : super(id);

  @override
  Primitive translate(Offset offset) {
    return Line(id: id, start: start + offset, end: end + offset);
  }

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);

  Map<String, dynamic> toJson() => _$LineToJson(this);

  static Map<String, dynamic> _offsetToJson(Offset offset) {
    return {
      'x': offset.dx,
      'y': offset.dy,
    };
  }

  static Offset _offsetFromJson(Map<String, dynamic> json) {
    return Offset(json['x'], json['y']);
  }
}
