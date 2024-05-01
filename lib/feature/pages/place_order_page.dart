import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yummy_app/core/route/route_path.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/core/utils/extensions/num_extension.dart';
import 'package:yummy_app/feature/model/placed_order.dart';
import 'package:yummy_app/feature/pages/components/scaffold_gradient_background.dart';
import 'package:yummy_app/gen/assets.gen.dart';

class PlacedOrderPage extends StatelessWidget {
  final PlacedOrder order;

  const PlacedOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          centerTitle: false,
          title: Text('Placed Order'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(padding),
          sliver: SliverConstrainedCrossAxis(
            maxExtent: breakpoint,
            sliver: MultiSliver(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.images.map.path),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Lottie.asset(
                        Assets.animation.cook,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Order placed, currently preparing'),
                        subtitle: Text(
                            'Estimated wait time: ${order.deliveryType.expectedTime}.'),
                      ),
                    )
                  ],
                ),
                Divider(color: context.theme.colorScheme.onPrimaryContainer),
                SliverToBoxAdapter(
                  child: Stepper(
                    physics: const NeverScrollableScrollPhysics(),
                    controlsBuilder: (context, details) {
                      return Container();
                    },
                    currentStep: 1,
                    steps: [
                      const Step(
                          state: StepState.complete,
                          title: Text('Accepted'),
                          content: Text(''),
                          isActive: true),
                      Step(
                          state: StepState.indexed,
                          title: const Text('Preparing'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: order.orders.length,
                                  itemBuilder: (context, index) {
                                    final placedOrder = order.orders[index];
                                    return ListTile(
                                      title: Text(placedOrder.food.name),
                                      subtitle: Text(
                                          '${placedOrder.food.price.toCurrency} X${placedOrder.quantity}'),
                                    );
                                  }),
                              Divider(
                                  color: context.colorScheme.onPrimaryContainer),
                              Text('Total: ${order.total.toCurrency}')
                            ],
                          ),
                          isActive: true),
                      Step(
                        state: StepState.indexed,
                        title: Text('Delivered'),
                        content: Text(''),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
