import 'package:flutter/material.dart';
import 'package:wordpress_app/Modal/modal.dart';

class CategoryCell extends StatelessWidget {
  final PostCategory? category;
  const CategoryCell({@required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white, backgroundColor: Colors.blueAccent[100]),
        onPressed: () {
          // navigator(context, PostsByCategory(category: category));
        },
        child: Center(
          child: Text('${category!.name}'),
        ),
      ),
    );
  }
}
