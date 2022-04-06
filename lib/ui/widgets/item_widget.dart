import 'package:app/domain/kanban/model/item.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final ItemEO? item;

  const ItemWidget({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: makeListTile(item),
      ),
    );
  }

  ListTile makeListTile(ItemEO? item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item == null
              ? 'null'
              : item.title.value.fold(
                  (l) => '',
                  (r) => r,
                ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          item == null
              ? 'null'
              : item.description.value.fold(
                  (l) => 'no Description',
                  (r) => r,
                ),
        ),
        trailing: const Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      );
}
