import '../models/grocery_item.dart';
import '../data/categories.dart';
import '../models/category.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Leite',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Banana',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Frango',
      quantity: 1,
      category: categories[Categories.meat]!),
];