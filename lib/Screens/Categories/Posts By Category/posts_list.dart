import 'package:flutter/material.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/Screens/Posts/components/Post%20Cell/post_cell.dart';
import 'package:wordpress_app/Widget/loading.dart';

class PostsByCategoryList extends StatefulWidget {
  final String? url;
  const PostsByCategoryList({@required this.url});

  @override
  _PostsByCategoryListState createState() => _PostsByCategoryListState();
}

class _PostsByCategoryListState extends State<PostsByCategoryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FetchData().fetchPostByCategories(widget.url.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ShowLoading();
        if (snapshot.data.length == 0)
          return Center(
            child: Text('No Posts available'),
          );
        return ListView.separated(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Post post = snapshot.data[index];
            return postsList(post);
          },
          separatorBuilder: (context, index) => Divider(),
        );
      },
    );
  }

  postsList(Post post) {
    return PostCellWidget(
      post: post,
    );
  }
}
