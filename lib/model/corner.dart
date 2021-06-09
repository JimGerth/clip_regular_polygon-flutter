/// Different shapes of corners.
///
/// These define how the intersection of
/// two converging lines look like.
enum CornerShape {
  /// The two lines making up the corner
  /// simply meet in a sharp point.
  sharp,

  // TODO: Add comment.
  bevel,

  /// The corner is rounded off smoothly
  /// by following a circle segment that
  /// is tangential to both lines making
  /// up the corner.
  round,

  // TODO: Add comment.
  fillet,

  // TODO: Add comment.
  inset,
}
