import 'package:flutter/material.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/Screens/Categories/Posts%20By%20Category/posts_list.dart';

class PostsByCategory extends StatefulWidget {
  final Category? category;
  PostsByCategory({@required this.category});
  @override
  _PostsByCategoryState createState() => _PostsByCategoryState();
}

class _PostsByCategoryState extends State<PostsByCategory> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData.fallback(),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.category!.name.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: body());
  }

  Widget body() {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onSaved: (value) {
              setState(() {
                search = value.toString();
              });
            },
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                search = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search for articles',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Releated Posts',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
                  // FetchData().fetchPosts(search);
                });
              },
              child:
                  PostsByCategoryList(url: widget.category!.posts.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
