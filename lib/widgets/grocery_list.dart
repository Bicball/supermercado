import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supermercado/data/categories.dart';
import 'package:supermercado/models/category.dart';
import 'dart:convert';
import 'package:supermercado/models/grocery_item.dart';
import '../widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('bicdev-flutter-market-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> _loadedItems = [];

    for(final item in listData.entries){
      final category = categories.entries.firstWhere((catItem) => catItem.value.title == item.value['category']).value;
      _loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
      ),);
    }
    setState(() {
      _groceryItems = _loadedItems;
    });
  }

  void _addItem() async{
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Lista'),
        actions: [
          IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: _groceryItems[index].category.color,
          ),
          trailing: Text(
            _groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}