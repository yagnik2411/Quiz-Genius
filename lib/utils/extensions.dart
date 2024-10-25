/// An extension on the String class to provide custom string manipulation methods.
/// This allows for easy capitalization of strings in different formats without modifying the original `String` class.

extension StringExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.inCaps).join(" ");
}
