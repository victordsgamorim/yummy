extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) item) {
    try {
      return firstWhere(item);
    } catch (e) {
      return null;
    }
  }


  Iterable<T> replaceWhere(bool Function(T element) condition, T replacement) sync* {
    for (var element in this) {
      if (condition(element)) {
        yield replacement;
      } else {
        yield element;
      }
    }
  }
}
