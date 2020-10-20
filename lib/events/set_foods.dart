import 'package:spoiler_alert/models/food.dart';
import 'food_event.dart';

class SetFoods extends FoodEvent {
  List<Food> foodList;

  SetFoods(List<Food> foods) {
    foodList = foods;
  }
}
