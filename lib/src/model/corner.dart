/// Different shapes of corners.
///
/// These define how the intersection of
/// two converging lines look like.
enum CornerShape {
  /// The two lines making up the corner
  /// simply meet in a sharp point.
  sharp,

  /// Another shorter line segment is added
  /// in between the two lines making up
  /// the corner.
  bevel,

  /// The corner is rounded off smoothly
  /// by following a circle segment that
  /// is tangential to both lines making
  /// up the corner.
  round,

  /// Similar to [CornerShape.round], but
  /// instead of rounding outward, a circle
  /// segment is cut out of the corner.
  fillet,

  // TODO: Add comment.
  inset,
}

/// A class representing corners of a two dimensional shape.
///
/// A [Corner] has a specific [CornerShape] and an optional
/// [radius], which is only required for some corner shapes.
class Corner {
  /// Create a new [Corner] object.
  ///
  /// The [shape] defaults to [CornerShape.hard].
  ///
  /// The [radius] defaults to zero.
  Corner({
    CornerShape? shape,
    num? radius,
  })  : shape = shape ?? CornerShape.sharp,
        radius = (radius ?? 0).toDouble().clamp(0, 1);

  /// Create a new sharp corner.
  Corner.sharp()
      : this(
          shape: CornerShapae.sharp,
        );

  /// Create a new beveled corner.
  Corner.bevel(num radius)
      : this(
          shape: CornerShape.bevel,
          radius: radius,
        );

  /// Create a new rounded corner.
  Corner.round(num radius)
      : this(
          shape: CornerShape.round,
          radius: radius,
        );

  /// Create a new filleted corner.
  Corner.fillet(num radius)
      : this(
          shape: CornerShape.fillet,
          radius: radius,
        );

  /// Create a new inset corner.
  Corner.inset()
      : this(
          shape: CornerShape.inset,
        );

  /// The shape of the corner.
  ///
  /// See [CornerShape] for more.
  final CornerShape shape;

  /// The radius of the corner.
  ///
  /// This is a decimal percentage factor setting
  /// the corner radius to anywhere between the
  /// minimum and maximum possible radius and is
  /// thus clamped to be between 0 and 1.
  ///
  /// This has no effect with a [shape] of
  /// [CornerShape.sharp] or [CornerShape.inset].
  final double radius;
}
