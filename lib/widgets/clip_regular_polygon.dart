import 'package:flutter/material.dart';

import 'package:clip_regular_polygon/util/regular_polygon_clipper.dart';

// Export the [RegularPolygon] type for users of [ClipRegularPolygon] as
// it is needed for the required [regularPolygon] constructor argument.
export 'package:clip_regular_polygon/model/regular_polygon.dart';

/// A widget that clips its child using a regular polygon.
///
/// The polygon will size itself to use all the available
/// space (analogous to [BoxFit.cover]) and center itself
/// in that area.
///
/// Because of this the [BoxConstraints] for the [child]
/// shall not be [double.infinity] in either direction.
class ClipRegularPolygon extends StatelessWidget {
  /// Creates a clip with the shape of a regular polygon.
  const ClipRegularPolygon({
    Key? key,
    required this.regularPolygon,
    this.child,
  }) : super(key: key);

  /// The regular polygon defining the shape of the clip.
  ///
  /// See [RegularPolygon] for more.
  final RegularPolygon regularPolygon;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RegularPolygonClipper(
        regularPolygon: regularPolygon,
      ),
      child: child,
    );
  }
}
