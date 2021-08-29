import 'package:flutter/material.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Widget/loading.dart';

import 'components/Post Cell/post_cell.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String? search = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onSaved: (value) {
              setState(() {
                search = value;
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
            'Latest Posts',
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
                    FetchData().fetchPosts();
                  });
                },
                child: PostList(
                  search: search,
                )),
          ),
        ],
      ),
    );
  }
}

class PostList extends StatefulWidget {
  final String? search;
  PostList({@required this.search});
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String? categoryName, imageUrl;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.search == ''
          ? FetchData().fetchPosts()
          : FetchData().fetchPostsBySearchQuery(widget.search.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShowLoading();
        return ListView.separated(
            shrinkWrap: true,
            cacheExtent: (200 * snapshot.data.length).toDouble(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PostCellWidget(
                post: snapshot.data[index],
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            });
      },
    );
  }
}
