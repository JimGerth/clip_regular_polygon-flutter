import 'dart:ui';

// TODO: Add comment.
class RegularPolygon {
  /// Create a new [RegularPolygon].
  RegularPolygon({
    required this.sides,
    num? rotation,
  }) : rotation = (rotation ?? 0 % 360).toDouble();

  /// Create a [RegularPolygon] with three sides.
  RegularPolygon.triangle({
    num? rotation,
  }) : this(
          sides: 3,
          rotation: rotation,
        );

  /// Create a [RegularPolygon] with four sides.
  RegularPolygon.square({
    num? rotation,
  }) : this(
          sides: 4,
          rotation: rotation,
        );

  /// Create a [RegularPolygon] with five sides.
  RegularPolygon.pentagon({
    num? rotation,
  }) : this(
          sides: 5,
          rotation: rotation,
        );

  /// Create a [RegularPolygon] with six sides.
  RegularPolygon.hexagon({
    num? rotation,
  }) : this(
          sides: 6,
          rotation: rotation,
        );

  /// Create a [RegularPolygon] with eight sides.
  RegularPolygon.octagon({
    num? rotation,
  }) : this(
          sides: 8,
          rotation: rotation,
        );

  /// The numer of sides of the polygon.
  ///
  /// As this class represents regular polygons, the
  /// number of sides equals the number of vertices.
  final int sides;

  /// The rotation of the polygon in degrees.
  ///
  /// This rotation is a rotational offset to the
  /// default orientation of the polygon.
  /// The polygon is rotated [rotation] degrees
  /// around its center counterclockwise.
  final double rotation;

  /// The angle between two sides of the polygon.
  double get innerAngle => 360 / sides;
}
