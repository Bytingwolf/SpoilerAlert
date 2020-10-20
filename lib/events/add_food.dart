import 'package:spoiler_alert/models/food.dart';
import 'food_event.dart';

class AddFood extends FoodEvent {
  Food newFood;

  AddFood(Food food) {
    newFood = food;
  }
}
