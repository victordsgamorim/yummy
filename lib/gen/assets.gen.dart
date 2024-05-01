/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationGen {
  const $AssetsAnimationGen();

  /// File path: assets/animation/cook.json
  String get cook => 'assets/animation/cook.json';

  /// List of all assets
  List<String> get values => [cook];
}

class $AssetsFixtureGen {
  const $AssetsFixtureGen();

  /// File path: assets/fixture/food_fixture.json
  String get foodFixture => 'assets/fixture/food_fixture.json';

  /// List of all assets
  List<String> get values => [foodFixture];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Foodpacker.otf
  String get foodpacker => 'assets/fonts/Foodpacker.otf';

  /// File path: assets/fonts/Lexend-Bold.ttf
  String get lexendBold => 'assets/fonts/Lexend-Bold.ttf';

  /// File path: assets/fonts/Lexend-Regular.ttf
  String get lexendRegular => 'assets/fonts/Lexend-Regular.ttf';

  /// List of all assets
  List<String> get values => [foodpacker, lexendBold, lexendRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_burger.png
  AssetGenImage get icBurger =>
      const AssetGenImage('assets/icons/ic_burger.png');

  /// File path: assets/icons/ic_pizza.png
  AssetGenImage get icPizza => const AssetGenImage('assets/icons/ic_pizza.png');

  /// File path: assets/icons/ic_stake.png
  AssetGenImage get icStake => const AssetGenImage('assets/icons/ic_stake.png');

  /// File path: assets/icons/ic_vegan.png
  AssetGenImage get icVegan => const AssetGenImage('assets/icons/ic_vegan.png');

  /// List of all assets
  List<AssetGenImage> get values => [icBurger, icPizza, icStake, icVegan];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/map.png
  AssetGenImage get map => const AssetGenImage('assets/images/map.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, map];
}

class Assets {
  Assets._();

  static const $AssetsAnimationGen animation = $AssetsAnimationGen();
  static const $AssetsFixtureGen fixture = $AssetsFixtureGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
