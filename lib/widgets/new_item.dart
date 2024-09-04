import 'package:flutter/material.dart';

import '../data/categories.dart';

class NewItem extends StatefulWidget{
  const NewItem ({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem>{
  final _formKey = GlobalKey<FormState>();

  void _saveItem (){
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 2 ||
                      value.trim().length > 50) {
                    return 'Deve ter entre 2 e 50 caracteres';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child:
                    TextFormField(
                      decoration: const InputDecoration(
                      label: Text('Quantidade'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0){
                          return 'Deve ser maior que 0';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(child: DropdownButtonFormField(items: [
                    for (final category in categories.entries)
                      DropdownMenuItem(
                          value: category.value, //Poderia ser category.key
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6),
                              Text(category.value.title),
                            ]
                          )
                      )
                  ], onChanged: (value) {}
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {_formKey.currentState!.reset();},
                    child: const Text('Resetar'),
                  ),
                  ElevatedButton(onPressed: _saveItem,
                      child: const Text('Adicionar'),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}