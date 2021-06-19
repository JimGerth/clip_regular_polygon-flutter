import 'dart:ui';

/// A class representing an abstract regular polygon.
///
/// A regular polygon is an equiangular and equilateral
/// two dimensional shape.
///
/// This class defines convex regular polygons, meaning
/// all sides connect adjacent corners (as opposed to a
/// "star" regular polygon).
///
/// A [RegularPolygon] is definded by its number of
/// [sides] (which also is the number of its corners),
/// and by a [rotation] around its own center.
///
/// It does not have a position or scale!
class RegularPolygon {
  /// Create a new [RegularPolygon].
  ///
  /// The number of [sides] has to be at least 3.
  ///
  /// The [rotation] defaults to 0 degrees.
  RegularPolygon({
    required this.sides,
    num? rotation,
  })  : assert(sides >= 3),
        rotation = (rotation ?? 0 % 360).toDouble();

  /// The numer of sides of the polygon.
  ///
  /// As this class represents regular polygons, the
  /// number of sides equals the number of vertices.
  ///
  /// This has to be at least 3 to create a triangle.
  final int sides;

  /// The rotation of the polygon in degrees.
  ///
  /// This rotation is a rotational offset to the
  /// default orientation of the polygon.
  /// The polygon is rotated [rotation] degrees
  /// around its center.
  final double rotation;

  /// The angle between two sides of the polygon.
  double get innerAngle => 360 / sides;
}
