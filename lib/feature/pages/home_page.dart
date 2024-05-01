import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yummy_app/core/route/route_path.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/core/utils/extensions/iterable_extension.dart';
import 'package:yummy_app/core/utils/extensions/num_extension.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/blocs/food/food_bloc.dart';
import 'package:yummy_app/feature/model/food.dart';
import 'package:yummy_app/feature/model/order.dart';
import 'package:yummy_app/feature/pages/components/badge.dart';
import 'package:yummy_app/feature/pages/components/custom_button.dart';
import 'package:yummy_app/feature/pages/components/food_item.dart';
import 'package:yummy_app/feature/pages/components/incrementer.dart';
import 'package:yummy_app/feature/pages/components/logo.dart';
import 'package:yummy_app/feature/pages/components/scaffold_gradient_background.dart';

typedef MenuCategory = ({IconData icon, FoodCategory category});

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FoodBloc _foodBloc;
  late final CartBloc _cartBloc;

  @override
  void initState() {
    _foodBloc = context.bloc<FoodBloc>()..add(LoadAllFoodEvent());
    _cartBloc = context.bloc<CartBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _CustomSliverAppBar(
              min: kToolbarHeight + context.viewPadding.top,
              title: const Text("Hey, Customer 👋"),
              actions: [
                BlocBuilder<CartBloc, CartState>(
                  bloc: _cartBloc,
                  builder: (context, state) {
                    return CustomBadge(
                      quantity: state.orders
                          .fold(0, (sum, order) => sum! + order.quantity),
                      child: IconButton(
                        onPressed: () {
                          context.go(R.cart);
                        },
                        icon: Icon(
                          FontAwesomeIcons.cartShopping,
                          color:
                              context.theme.appBarTheme.actionsIconTheme?.color,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _CustomSliverTabMenu(
              icons: [
                (
                  icon: FontAwesomeIcons.burger,
                  category: FoodCategory.fastFood
                ),
                (icon: FontAwesomeIcons.leaf, category: FoodCategory.salad),
                (icon: FontAwesomeIcons.fish, category: FoodCategory.seaFood),
              ],
              onTap: (category) {
                _foodBloc.add(FilterFoodEvent(category));
              },
            ),
          ),
          SliverConstrainedCrossAxis(
            maxExtent: breakpoint,
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: padding * 2),
              sliver: BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final food = state.foods[index];
                      return FoodItem(
                        food: food,
                        onTap: () {

                          context.go(R.food, extra: food);
                        },
                        trailing: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  final foundOrder = _cartBloc.state.orders
                                      .firstWhereOrNull(
                                          (element) => element.food == food);

                                  return _ModalBottomSheet(
                                    initQuantity: foundOrder?.quantity,
                                    food: food,
                                    onOrderAdd: (order) {
                                      if (foundOrder != null) {
                                        _cartBloc.add(UpdateOrderEvent(
                                          order: order,
                                          increment: order.quantity,
                                        ));
                                      } else {
                                        _cartBloc.add(AddOrderToCartEvent(order));
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      );
                    },
                    childCount: state.foods.length,
                  ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _foodBloc.close();
    _cartBloc.close();
    super.dispose();
  }
}

class _CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double min;
  final double max;
  final Widget? title;
  final List<Widget>? actions;

  _CustomSliverAppBar({
    this.min = kToolbarHeight,
    this.max = 200,
    this.title,
    this.actions,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / max;
    final opacity = (2.5 * percent).clamp(0, 1).toDouble();
    return Container(
      height: max,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: context.colorScheme.surface.withOpacity(opacity),
      child: Stack(
        children: [
          Opacity(
            opacity: 1 - opacity,
            child: SafeArea(
                top: true,
                bottom: false,
                child: Container(
                  height: kToolbarHeight,
                  alignment: Alignment.centerLeft,
                  child: const Logo(),
                )),
          ),
          if (title != null)
            Positioned(
              bottom: 0,
              left: 8,
              child: Container(
                height: kToolbarHeight,
                alignment: Alignment.center,
                child: _buildText(context, percent: percent),
              ),
            ),
          if (actions != null)
            Positioned(
              right: 0,
              child: SafeArea(
                top: true,
                bottom: false,
                child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...actions!.map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: action,
                          ),
                        )
                      ],
                    )),
              ),
            )
        ],
      ),
    );
  }

  Widget? _buildText(BuildContext context, {double percent = 0}) {
    double maxFontSize = 32;
    double minFontSize = 22;
    double maxScaleSize = 1;
    double minScaleSize = .6875;
    if (title is Text) {
      final text = title as Text;
      final style = text.style ?? context.theme.textTheme.titleLarge;
      return Text(
        text.data!,
        style: style!.copyWith(
          fontSize: (maxFontSize * (1 - percent)).clamp(
            minFontSize,
            maxFontSize,
          ),
        ),
      );
    }
    return Transform.scale(
      scale: (maxScaleSize - percent).clamp(minScaleSize, maxScaleSize),
      child: title,
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _CustomSliverTabMenu extends SliverPersistentHeaderDelegate {
  final Function(FoodCategory category) onTap;
  final List<MenuCategory> icons;

  _CustomSliverTabMenu({
    required this.icons,
    required this.onTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: context.colorScheme.surface.withOpacity(overlapsContent ? 1 : 0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final icon = icons[index];
          return GestureDetector(
            onTap: () => onTap(icon.category),
            child: Center(
              child: SizedBox(
                height: 70,
                width: 70,
                child: Container(
                  padding: const EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    border: Border.all(
                        color: context.colorScheme.onPrimaryContainer,
                        width: 4),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(icon.icon),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 5);
        },
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _ModalBottomSheet extends StatefulWidget {
  final Food food;
  final Function(Order order)? onOrderAdd;
  final int? initQuantity;

  const _ModalBottomSheet({
    required this.food,
    this.onOrderAdd,
    this.initQuantity,
  });

  @override
  State<_ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<_ModalBottomSheet> {
  late final ValueNotifier<int> _quantityNotifier;

  @override
  void initState() {
    _quantityNotifier = ValueNotifier(widget.initQuantity ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (context.querySize.height * .3).clamp(200, 250),
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.food.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontSize: 24),
                ),
              ),
              Incrementer(
                initValue: widget.initQuantity,
                onIncrement: (value) {
                  _quantityNotifier.value = value;
                },
              ),
              ValueListenableBuilder(
                valueListenable: _quantityNotifier,
                builder: (_, int value, __) {
                  final price = widget.food.price * value;
                  return CustomElevatedButton(
                    enable: value > 0,
                    onTap: () {
                      if (widget.onOrderAdd != null) {
                        widget.onOrderAdd!(Order(
                            food: widget.food, quantity: value, total: price));
                        Navigator.of(context).pop();
                      }
                    },
                    label: 'Add for ${price.toCurrency}',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityNotifier.dispose();
    super.dispose();
  }
}
