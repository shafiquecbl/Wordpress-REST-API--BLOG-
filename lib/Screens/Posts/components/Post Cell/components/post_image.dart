import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/constants.dart';

class PostImageWidget extends StatelessWidget {
  final String? url;
  const PostImageWidget({@required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FetchData().fetchPostImage(url.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Shimmer.fromColors(
              child: imageIcon,
              baseColor: Colors.grey,
              highlightColor: Colors.blue);
        PostImage postImage = snapshot.data;
        return postImage.url != null
            ? CachedNetworkImage(
                imageUrl: postImage.url.toString(),
                fit: BoxFit.cover,
                placeholder: (context, string) {
                  return imageIcon;
                },
                errorWidget: (context, string, dynamic) {
                  return imageIcon;
                },
              )
            : imageIcon;
      },
    );
  }
}
