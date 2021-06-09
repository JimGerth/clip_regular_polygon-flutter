import 'dart:math';
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

  /// Return the shape of the polygon as a [Path].
  ///
  /// The generated polygon will have [sides] sides
  /// and corners and will be rotated by [rotation]
  /// degrees.
  ///
  /// The generated polygon will be of unit size,
  /// meaning the distance from the center to any
  /// corner vertex will be of length 1.
  Path getPath() {
    // Generate the angles at which the vertices of
    // the polygon should be positioned.
    final List<double> angles = List.generate(
      // The number of sides equals the number of
      // vertices.
      sides,
      // Each angle is [innerAngle] big and offset
      // from zero degrees by [rotation].
      (index) => index * innerAngle + rotation,
    );

    // Calculate the position of the vertices as an
    // offset of unit length 1 from the origin
    // outwards in the directions defined by [angles].
    final List<Offset> vertices = angles
        .map(
          // Convert angles from degrees to radians
          // as expected by [Offset.fromDirection].
          (angle) => angle * pi / 180,
        )
        .map(
          (angle) => Offset.fromDirection(angle),
        )
        .toList();

    // Return the closed polygon created by these
    // vertices.
    return Path()..addPolygon(vertices, true);
  }
}
