import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yummy_app/core/route/route_path.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/core/utils/extensions/num_extension.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/model/order.dart';
import 'package:yummy_app/feature/model/placed_order.dart';
import 'package:yummy_app/feature/pages/components/cart_section.dart';
import 'package:yummy_app/feature/pages/components/confirm_animation.dart';
import 'package:yummy_app/feature/pages/components/custom_button.dart';
import 'package:yummy_app/feature/pages/components/food_item.dart';
import 'package:yummy_app/feature/pages/components/incrementer.dart';
import 'package:yummy_app/feature/pages/components/scaffold_gradient_background.dart';
import 'package:yummy_app/gen/assets.gen.dart';

typedef DeliveryItem = ({String label, String expectedTime});

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DeliveryType _deliveryType = DeliveryType.standard;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final total = (state.orders.fold(
            0.0,
            (sum, order) => (sum + order.total),
          ));
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    centerTitle: false,
                    title: const Text('Your order'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.bloc<CartBloc>().add(RemoveOrdersEvent());
                        },
                        icon: const Icon(FontAwesomeIcons.trash),
                      )
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: padding, bottom: 150.0),
                    sliver: SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: padding),
                      sliver: SliverConstrainedCrossAxis(
                        maxExtent: breakpoint,
                        sliver: MultiSliver(
                          children: [
                            if (state.placedOrders.isNotEmpty)
                              CartSection(
                                title: 'Placed orders',
                                child: _CartPlacedOrder(
                                    placedOrders: state.placedOrders),
                              ),
                            const SizedBox(height: padding),
                            CartSection(
                              title: 'Delivery',
                              child: _CartDelivery(
                                initValue: _deliveryType,
                                types: DeliveryType.values,
                                onChanged: (type) {
                                  _deliveryType = type;
                                },
                              ),
                            ),
                            const SizedBox(height: padding),
                            CartSection(
                              hasBorder: false,
                              title: 'Basket',
                              child: _CartBasket(orders: state.orders),
                            ),
                            const SizedBox(height: padding),
                            CartSection(
                              title: 'Credit and Vouchers',
                              child: _CartCredit(
                                labels: const [
                                  'Add voucher code/gift card',
                                  'View credit and vouchers',
                                ],
                                onTap: (index) {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: context.viewPadding.bottom + padding,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: breakpoint),
                    child: CustomElevatedButton(
                      enable: state.orders.isNotEmpty,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Confirming Order',
                                  style: context.theme.textTheme.titleLarge,
                                ),
                                content: ConfirmAnimation(
                                  whenCompleted: (completed) {
                                    if (completed) {
                                      Future.delayed(
                                          const Duration(milliseconds: 300), () {
                                        Navigator.of(context).pop();

                                        final placedOrder = PlacedOrder(
                                          orders: state.orders,
                                          deliveryType: _deliveryType,
                                          total: total,
                                        );
                                        context
                                            .bloc<CartBloc>()
                                            .add(AddPlacedOrderEvent(
                                              placedOrder,
                                            ));
                                        context.go(R.placedOrder,
                                            extra: placedOrder);
                                      });
                                    }
                                  },
                                ),
                              );
                            });
                      },
                      label: 'Checkout ${total.toCurrency}',
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class _CartPlacedOrder extends StatefulWidget {
  final List<PlacedOrder> placedOrders;

  const _CartPlacedOrder({super.key, required this.placedOrders});

  @override
  State<_CartPlacedOrder> createState() => _CartPlacedOrderState();
}

class _CartPlacedOrderState extends State<_CartPlacedOrder> {
  @override
  Widget build(BuildContext context) {
    return CartSeparatedList(
      itemCount: widget.placedOrders.length,
      itemBuilder: (context, index) {
        final placedOrder = widget.placedOrders[index];
        return ListTile(
          title: Text(placedOrder.deliveryType.name),
          subtitle: Text(
              '${placedOrder.total.toCurrency} - ${placedOrder.deliveryType.expectedTime}'),
          trailing: Lottie.asset(
            Assets.animation.cook,
          ),
          onTap: () {
            context.go(R.placedOrder, extra: placedOrder);
          },
        );
      },
    );
  }
}

class _CartDelivery extends StatefulWidget {
  final DeliveryType? initValue;
  final List<DeliveryType> types;
  final Function(DeliveryType type)? onChanged;

  const _CartDelivery({required this.types, this.initValue, this.onChanged});

  @override
  State<_CartDelivery> createState() => _CartDeliveryState();
}

class _CartDeliveryState extends State<_CartDelivery> {
  DeliveryType? _type;
  int _selectedIndex = 0;

  @override
  void initState() {
    _type = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleTheme =
        context.theme.listTileTheme.titleTextStyle ?? const TextStyle();
    final color = context.colorScheme.onPrimaryContainer;
    return CartSeparatedList(
      itemCount: widget.types.length,
      itemBuilder: (context, index) {
        final type = widget.types[index];
        return RadioListTile(
          title: Text(
            type.name,
            style: titleTheme.copyWith(color: color),
          ),
          subtitle: Text(type.expectedTime),
          value: index,
          groupValue: _selectedIndex,
          onChanged: (int? value) {
            setState(() {
              _selectedIndex = value!;
              if (widget.onChanged != null) widget.onChanged!(type);
            });
          },
        );
      },
    );
  }
}

class _CartBasket extends StatelessWidget {
  final List<Order> orders;

  const _CartBasket({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return FoodItem(
          animated: false,
          food: order.food,
          trailing: Incrementer(
            initValue: order.quantity,
            onIncrement: (value) {
              context
                  .bloc<CartBloc>()
                  .add(UpdateOrderEvent(order: order, increment: value));
            },
          ),
        );
      },
    );
  }
}

class _CartCredit extends StatelessWidget {
  final List<String> labels;
  final Function(int index) onTap;

  const _CartCredit({
    required this.labels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CartSeparatedList(
      itemCount: labels.length,
      itemBuilder: (context, index) {
        final label = labels[index];
        return ListTile(
          title: Text(label),
          onTap: () {
            onTap(index);
          },
        );
      },
    );
  }
}
