import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/core/utils/extensions/num_extension.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/model/food.dart';
import 'package:yummy_app/feature/model/order.dart';
import 'package:yummy_app/feature/pages/components/custom_button.dart';
import 'package:yummy_app/feature/pages/components/incrementer.dart';
import 'package:yummy_app/feature/pages/components/scaffold_gradient_background.dart';

class FoodPage extends StatefulWidget {
  final Food food;

  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late final ValueNotifier<int> _quantityNotifier;

  @override
  void initState() {
    _quantityNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              title: Text(widget.food.name),
            ),
            SliverConstrainedCrossAxis(
              maxExtent: breakpoint,
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Hero(
                        tag: widget.food,
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: widget.food.url ?? '',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(padding),
                    sliver: MultiSliver(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(padding),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              border: Border.all(
                                  color:
                                      context.colorScheme.onPrimaryContainer)),
                          child: Text(
                            'Price: ${widget.food.price.toCurrency}',
                            style: context.theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: padding),
                      Text(
                        widget.food.description,
                        style: context.theme.textTheme.bodyMedium
                            ?.copyWith(fontSize: 16),
                      ),
                      Incrementer(
                        initValue: 0,
                        onIncrement: (value) {
                          _quantityNotifier.value = value;
                        },
                      )
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
            bottom: context.viewPadding.bottom + padding,
            child: ValueListenableBuilder(
              valueListenable: _quantityNotifier,
              builder: (context, value, child) {
                final total = value * widget.food.price;
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: breakpoint),
                  child: CustomElevatedButton(
                    enable: true,
                    onTap: () {
                      context.bloc<CartBloc>().add(
                            AddOrderToCartEvent(
                              Order(
                                  food: widget.food,
                                  quantity: value,
                                  total: total),
                            ),
                          );

                      context.pop();
                    },
                    label: 'Add for $total',
                  ),
                );
              },
            ))
      ],
    ));
  }
}
