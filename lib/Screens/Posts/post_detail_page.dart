import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:wordpress_app/Http/fetch_data.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/constants.dart';

class PostDetailsPage extends StatelessWidget {
  final Post? post;
  PostDetailsPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[200],
                child: IconButton(
                  icon: Icon(
                    Icons.open_in_browser,
                    size: 20,
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    launch(post!.link.toString());
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[200],
                child: IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 20,
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    Share.share(post!.link.toString(),
                        subject: post!.title.toString());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ListView(
            children: [
              Row(
                children: [
                  categoryName(),
                  Spacer(),
                  Text(
                    convertDate(post!.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                post!.title.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              getAuthor(),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    color: Colors.grey[100], child: getFeaturedImage()),
              ),
              const SizedBox(
                height: 20,
              ),
              Html(
                  data: post!.content,
                  onLinkTap:
                      (String? url, context, Map<String, String> a, element) {
                    launch(url!);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategory() {
    return FutureBuilder(
      future: FetchData().fetchPostCategory(post!.category.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Shimmer.fromColors(
              child: cat('Category'),
              baseColor: Colors.white,
              highlightColor: greyColor as Color);
        PostCategory category = snapshot.data;
        return cat(category.name.toString());
      },
    );
  }

  Widget cat(String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w100,
      ),
    );
  }

  categoryName() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.purple,
                  child: getCategory()),
            ),
          ],
        ),
      ],
    );
  }

  Widget getFeaturedImage() {
    return FutureBuilder(
      future: FetchData().fetchPostImage(post!.image.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Shimmer.fromColors(
              child: imageIcon,
              baseColor: Colors.black,
              highlightColor: greyColor as Color);
        PostImage postImage = snapshot.data;
        return snapshot.data != null
            ? CachedNetworkImage(
                imageUrl: postImage.url.toString(),
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

  Widget getAuthor() {
    return FutureBuilder(
      future: FetchData().fetchPostAuthor(post!.author.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container();
        Author author = snapshot.data;
        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: author.image.toString(),
                  placeholder: (context, string) {
                    return imageIcon;
                  },
                  errorWidget: (context, string, dynamic) {
                    return imageIcon;
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(author.name.toString()),
          ],
        );
      },
    );
  }

  String convertDate(String? date) {
    date =
        '${date.toString().split('T').first} at ${date.toString().split('T').last}';
    return date;
  }
}
