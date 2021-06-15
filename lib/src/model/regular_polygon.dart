import 'dart:math';
import 'dart:ui';

import 'package:clip_regular_polygon/model/corner.dart';
import 'package:clip_regular_polygon/util/extensions.dart';

// Export the Corner type to users of the RegularPolygon
// class, as it is needed for a constructor argument.
export 'package:clip_regular_polygon/model/corner.dart';

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
    Corner? corners,
  })  : assert(sides >= 3),
        rotation = (rotation ?? 0 % 360).toDouble(),
        corners = corners ?? Corner();

  /// Create a [RegularPolygon] with three sides.
  RegularPolygon.triangle({
    num? rotation,
    Corner? corners,
  }) : this(
          sides: 3,
          rotation: rotation,
          corners: corners,
        );

  /// Create a [RegularPolygon] with four sides.
  RegularPolygon.square({
    num? rotation,
    Corner? corners,
  }) : this(
          sides: 4,
          rotation: rotation,
          corners: corners,
        );

  /// Create a [RegularPolygon] with five sides.
  RegularPolygon.pentagon({
    num? rotation,
    Corner? corners,
  }) : this(
          sides: 5,
          rotation: rotation,
          corners: corners,
        );

  /// Create a [RegularPolygon] with six sides.
  RegularPolygon.hexagon({
    num? rotation,
    Corner? corners,
  }) : this(
          sides: 6,
          rotation: rotation,
          corners: corners,
        );

  /// Create a [RegularPolygon] with eight sides.
  RegularPolygon.octagon({
    num? rotation,
    Corner? corners,
  }) : this(
          sides: 8,
          rotation: rotation,
          corners: corners,
        );

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

  /// The corners of the polygon.
  ///
  /// See the [Corner] class for more.
  final Corner corners;

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
    // Return the appropriate path for the corner shape.
    switch (corners.shape) {
      case CornerShape.sharp:
        return _normalPath;
      case CornerShape.bevel:
        return _bevelPath;
      case CornerShape.round:
        return _roundPath;
      case CornerShape.fillet:
        return _filletPath;
      case CornerShape.inset:
        return _getInsetPath();
    }
  }

  /// Each regular polygon can be described as a set of
  /// equilateral triangles rotationally symmetrically
  /// arranged around a center.
  /// The angle of the corner of all of those similar
  /// triangles on the point where they meet in the
  /// center of the polygon is this [innerAngle].
  late final double _innerAngle = (() => (360 / sides).toRadians())();

  late final double _magicAngle = (() => _innerAngle / 2)();

  // Multiply the maximum possible radius by the [Corner.radius] factor.
  late final double _radius = (() => cos(_magicAngle) * corners.radius)();

  late final List<double> _cornerAngles = (() => List.generate(
        sides,
        (index) => index * _innerAngle + rotation.toRadians() - 90.toRadians(),
      ))();

  late final List<Offset> _cornerPoints = (() => _cornerAngles
      .map(
        (angle) => Offset.fromDirection(angle),
      )
      .toList())();

  late final List<Offset> _secondaryPoints = (() => _cornerAngles.expand(
        (angle) {
          Offset primaryPoint = Offset.fromDirection(
            angle,
            1 - (_radius / cos(_magicAngle)),
          );
          return [
            primaryPoint +
                Offset.fromDirection(
                  angle - _magicAngle,
                  _radius,
                ),
            primaryPoint +
                Offset.fromDirection(
                  angle + _magicAngle,
                  _radius,
                ),
          ];
        },
      ).toList())();

  // The path of this polygon with sharp corners.
  late final Path _normalPath = (() => Path()
    ..addPolygon(
      _cornerPoints,
      true,
    ))();

  // The path of this polygon with beveled corners.
  late final Path _bevelPath = (() => Path()
    ..addPolygon(
      _secondaryPoints,
      true,
    ))();

  // The path of this polygon with rounded corners.
  late final Path _roundPath = _getArcPath(
    clockwise: true,
  );

  // The path of this polygon with filleted corners.
  late final Path _filletPath = _getArcPath(
    clockwise: false,
  );

  // Return the path of this polygon with arced corners.
  //
  // Set [clockwise] to determine in which direction the
  // corners should arc.
  Path _getArcPath({
    required bool clockwise,
  }) {
    // Create new Path and move to first point.
    Path path = Path()
      ..moveTo(
        _secondaryPoints.first.dx,
        _secondaryPoints.first.dy,
      );

    // Draw arcs and lines between the secondary points of the
    // polygon in an alternating manner.
    for (int i = 0; i < _secondaryPoints.length - 1; i += 2) {
      path.arcToPoint(
        _secondaryPoints[i + 1],
        radius: Radius.circular(_radius),
        clockwise: clockwise,
      );

      path.lineTo(
        _secondaryPoints[(i + 2) % _secondaryPoints.length].dx,
        _secondaryPoints[(i + 2) % _secondaryPoints.length].dy,
      );
    }

    // Return the closed polygon created by these sub-paths.
    return path;
  }

  // The path of this polygon with inset corners.
  //
  // TODO: The math is still off.
  Path _getInsetPath() => Path()
    ..addPolygon(
      _cornerAngles.expand(
        (angle) {
          Offset primaryPoint = Offset.fromDirection(
            angle,
            1 - (_radius / cos(_magicAngle)),
          );
          return [
            primaryPoint +
                Offset.fromDirection(
                  angle - _magicAngle,
                  _radius,
                ),
            primaryPoint,
            primaryPoint +
                Offset.fromDirection(
                  angle + _magicAngle,
                  _radius,
                ),
          ];
        },
      ).toList(),
      true,
    );
}
