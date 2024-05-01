class R {
  static String init = RoutePath.init;
  static String home = RoutePath.home;
  static String cart = '${RoutePath.home}/${RoutePath.cart}';
  static String food = '${RoutePath.home}/${RoutePath.food}';
  static String placedOrder = '$cart/${RoutePath.placedOrder}';
}

class RoutePath {
  static String init = '/';
  static String home = '/home';
  static String cart = 'cart';
  static String placedOrder = 'placedOrder';
  static String food = 'food';
}
