import 'package:flutter/material.dart';
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/Screens/Posts/post_detail_page.dart';
import 'package:wordpress_app/Widget/navigator.dart';
import 'components/post_category.dart';
import 'components/post_image.dart';

class PostCellWidget extends StatelessWidget {
  final Post? post;
  PostCellWidget({
    @required this.post,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        rootNavigator(context, PostDetailsPage(post: post));
      },
      child: Container(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[100],
                width: 120,
                height: 75,
                child: PostImageWidget(
                  url: post!.image,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post!.title.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 3.8,
                            ),
                            height: 28,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Colors.purple,
                            child: PostCategoryWidget(url: post!.category),
                          ),
                        ),
                        Text(
                          convertDate(post!.date),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        )
                      ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDate(String? date) {
    date =
        '${date.toString().split('T').first} at ${date.toString().split('T').last}';
    return date;
  }
}
