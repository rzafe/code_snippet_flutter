
extension StringExt on String? {
  String toUpperSafe({String fallback = ""}) {
    final value = this?.trim();
    if (value == null || value.isEmpty) {
      return fallback.toUpperCase();
    }
    return value.toUpperCase();
  }

  String toLowerSafe({String fallback = ""}) {
    final value = this?.trim();
    if (value == null || value.isEmpty) {
      return fallback.toLowerCase();
    }
    return value.toLowerCase();
  }

  String toTextSafe({String fallback = ""}) {
    final value = this?.trim();
    if (value == null || value.isEmpty) {
      return fallback;
    }
    return value;
  }
}