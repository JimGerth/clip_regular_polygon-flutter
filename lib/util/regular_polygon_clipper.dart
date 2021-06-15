import 'package:flutter/material.dart';

import 'package:clip_regular_polygon/model/regular_polygon.dart';

// Export the [RegularPolygon] type for users of [RegularPolygonClipper]
// as it is needed for the required [regularPolygon] constructor argument.
export 'package:clip_regular_polygon/model/regular_polygon.dart';

/// A [CustomClipper] with the shape of a [RegularPolygon].
///
/// This can be used to clip any [Widget] into the shape
/// of a regular polygon using [ClipPath].
/// ```dart
/// ClipPath(
///   clipper: RegularPolygonClipper(
///     regularPolygon: ...
///   ),
///   child: ...
/// )
/// ```
class RegularPolygonClipper extends CustomClipper<Path> {
  /// Creates a [CustomClipper] with the shape of a [RegularPolygon].
  RegularPolygonClipper({
    required this.regularPolygon,
  });

  /// The [RegularPolygon] describing the shape of the clipper.
  ///
  /// See [RegularPolygon] for more.
  final RegularPolygon regularPolygon;

  // FIXME: This is only true for debugging, so the hexagon
  // gets reclipped on every rebuild. For better performance
  // this should normally return false though.
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
    // The shape of the regular polygon.
    Path polygonPath = regularPolygon.getPath();

    // The bounding size of the polygon path.
    Size polygonSize = polygonPath.getBounds().size;

    // The scale factor to make the polygon fit into the
    // available space.
    double scale;

    if (polygonSize.aspectRatio > size.aspectRatio) {
      // If the polygon is wider than the available space,
      // make the polygons width fit the available width
      // (and scale the height accordingly as well).
      scale = size.width / polygonSize.width;
    } else {
      // If the polygon is taller than the available space,
      // make the polygons height fit the available height
      // (and scale the width accorsingly as well).
      scale = size.height / polygonSize.height;
    }

    // The center point of the polygon path transformed
    // from the unit- to the display coordinate space.
    Offset polygonCenter = polygonPath.getBounds().center * scale;

    return polygonPath.transform(
      (Matrix4.identity()
            // Center the polygon in the available space.
            ..translate(
              size.width / 2 - polygonCenter.dx,
              size.height / 2 - polygonCenter.dy,
            )
            // Scale the polygon using the calculated scale.
            ..scale(
              scale,
              scale,
            ))
          .storage,
    );
  }
}
