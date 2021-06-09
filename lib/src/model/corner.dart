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
