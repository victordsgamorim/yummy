import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy_app/core/route/route_path.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/blocs/food/food_bloc.dart';
import 'package:yummy_app/feature/model/food.dart';
import 'package:yummy_app/feature/model/placed_order.dart';
import 'package:yummy_app/feature/pages/cart_page.dart';
import 'package:yummy_app/feature/pages/food_page.dart';
import 'package:yummy_app/feature/pages/home_page.dart';
import 'package:yummy_app/feature/pages/place_order_page.dart';
import 'package:yummy_app/feature/pages/splash_page.dart';

GoRouter router = GoRouter(
  // initialLocation: kIsWeb ? RoutePath.home : RoutePath.init,
  initialLocation: RoutePath.home,
  routes: [
    GoRoute(
      path: RoutePath.init,
      builder: (context, state) => const SplashPage(),
    ),
    CupertinoTransitionGoRouter(
      name: 'Home',
      path: RoutePath.home,
      builder: (_) => const HomePage(),
      routes: [
        CupertinoTransitionGoRouter(
          name: 'Food',
          path: RoutePath.food,
          builder: (state) => FoodPage(food: state.extra as Food),
        ),
        CupertinoTransitionGoRouter(
            name: 'Cart',
            path: RoutePath.cart,
            builder: (GoRouterState s) => const CartPage(),
            routes: [
              CupertinoTransitionGoRouter(
                name: 'Placed Order',
                path: RoutePath.placedOrder,
                builder: (state) =>
                    PlacedOrderPage(order: state.extra as PlacedOrder),
              )
            ]),
      ],
    ),
  ],
);

class CupertinoTransitionGoRouter extends GoRoute {
  CupertinoTransitionGoRouter({
    super.name,
    required super.path,
    required Widget Function(GoRouterState s) builder,
    List<GoRoute> super.routes = const [],
  }) : super(
          pageBuilder: (context, state) => CupertinoPage(child: builder(state)),
        );
}
