import 'dart:math';

/// An extension to convert degrees to radians.
///
/// This is an extension on the [num] type, so
/// it can be used on [int]s and [double]s.
extension ToRadians on num {
  /// Return this value interpreted as degrees,
  /// converted into radians.
  double toRadians() => this * pi / 180;
}
