import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Modal/modal.dart';

class PostCategoryWidget extends StatelessWidget {
  final String? url;
  const PostCategoryWidget({@required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FetchData().fetchPostCategory(url.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.blue[100] as Color,
              child: postCategory('Category'));
        PostCategory postCat = snapshot.data;
        return postCategory(postCat.name.toString());
      },
    );
  }

  postCategory(String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w100,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
