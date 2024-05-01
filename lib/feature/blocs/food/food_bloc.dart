import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yummy_app/feature/data/repository/food_repository.dart';
import 'package:yummy_app/feature/model/food.dart';

part 'food_event.dart';

part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository _foodRepository;

  List<Food> _foods = [];

  FoodBloc(this._foodRepository) : super(FoodEmpty()) {
    on<LoadAllFoodEvent>((event, emit) async {
      emit(FoodLoading());
      final response = await _foodRepository.getAll();

      response.fold(
        (failure) =>
            emit(FoodError(message: failure.message, foods: state.foods)),
        (foods) {
          _foods = foods;
          emit(FoodSuccess(foods: foods));
        },
      );
    });

    on<FilterFoodEvent>((event, emit) async {
      final foods = _foods
          .where((element) => element.categories.contains(event.category))
          .toList();
      emit(FoodSuccess(foods: foods));
    });
  }
}
