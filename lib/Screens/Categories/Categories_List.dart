import 'package:flutter/material.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/Widget/loading.dart';
import 'components/category_cell.dart';

class CategoriesListPage extends StatefulWidget {
  @override
  _CategoriesListPageState createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Categories',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    FetchData().fetchCategories();
                  });
                },
                child: CategoryList()),
          ),
        ],
      ),
    ));
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FetchData().fetchCategories().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShowLoading();
        return GridView.builder(
          itemCount: snapshot.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.5),
          itemBuilder: (BuildContext context, int index) {
            Category category = snapshot.data[index];
            return CategoryCell(category: category);
          },
        );
      },
    );
  }
}
