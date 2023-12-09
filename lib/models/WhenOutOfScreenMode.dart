/// Enumerates different behaviors for a shape when it reaches the screen edge.
enum WhenOutOfScreenMode {
  /// The shape bounces back in the opposite direction upon reaching the screen edge.
  Reflect,

  /// The shape continues its movement, teleporting to the opposite side of the screen.
  Teleport,

  /// The shape maintains its current movement and continues beyond the screen edge.
  none
}
