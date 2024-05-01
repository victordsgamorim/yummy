import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:yummy_app/core/route/route.dart';
import 'package:yummy_app/core/theme/theme.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/blocs/food/food_bloc.dart';
import 'package:yummy_app/feature/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<FoodBloc>()),
        BlocProvider(create: (context) => GetIt.I<CartBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: const MaterialTheme().light(),
        title: 'Yummy',
        routerConfig: router,
      ),
    );
  }
}
