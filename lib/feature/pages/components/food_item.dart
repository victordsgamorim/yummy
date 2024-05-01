import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/core/utils/extensions/num_extension.dart';
import 'package:yummy_app/feature/model/food.dart';
import 'package:yummy_app/feature/pages/components/custom_button.dart';

class FoodItem extends StatefulWidget {
  final Food food;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool animated;

  const FoodItem({
    super.key,
    required this.food,
    this.onTap,
    this.trailing,
    this.animated = true,
  });

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  late final CacheManager _cacheManager;

  @override
  void initState() {
    _cacheManager = CacheManager(
      Config(
        'cacheImageKey',
        stalePeriod: const Duration(days: 15),
        maxNrOfCacheObjects: 50,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        context.theme.listTileTheme.titleTextStyle ?? const TextStyle();
    return Card(
      elevation: 0,
      surfaceTintColor: context.colorScheme.primaryContainer,
      child: ListTile(
        onTap: widget.onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: 80,
            child: widget.animated
                ? Hero(
                    tag: widget.food,
                    child: _cachedImage(),
                  )
                : _cachedImage(),
          ),
        ),
        title: Text(
          widget.food.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titleStyle.copyWith(
              color: context.colorScheme.onPrimaryContainer),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.food.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Price: ${widget.food.price.toCurrency}',
                style: titleStyle.copyWith(
                    color: context.colorScheme.onPrimaryContainer),
              ),
            )
          ],
        ),
        trailing: widget.trailing,
      ),
    );
  }

  CachedNetworkImage _cachedImage() {
    return CachedNetworkImage(
      cacheManager: _cacheManager,
      key: UniqueKey(),
      imageUrl: widget.food.url ?? '',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }
}
