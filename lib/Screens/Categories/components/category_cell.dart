import 'package:flutter/material.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/Screens/Categories/Posts%20By%20Category/post_by_category.dart';
import 'package:wordpress_app/Widget/navigator.dart';

class CategoryCell extends StatelessWidget {
  final Category? category;
  const CategoryCell({@required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white, backgroundColor: Colors.blueAccent[100]),
        onPressed: () {
          rootNavigator(context, PostsByCategory(category: category));
        },
        child: Center(
          child: Text(category!.name.toString()),
        ),
      ),
    );
  }
}
