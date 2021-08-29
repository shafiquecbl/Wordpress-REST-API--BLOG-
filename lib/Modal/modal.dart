class Post {
  Post({
    this.title,
    this.content,
    this.image,
    this.author,
    this.category,
    this.date,
    this.link,
  });

  String? title, content, image, date, link, author, category;

  factory Post.fromJSON(Map<String, dynamic> json) => Post(
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      image: json['_links']['wp:featuredmedia'][0]['href'],
      date: json['date'],
      link: json['link'],
      author: json['_links']['author'][0]['href'],
      category: json['_links']['wp:term'][0]['href']);
}

////////////////////////////////////////////////////

class Author {
  Author({
    this.name,
    this.image,
  });

  String? name, image;

  factory Author.fromJSON(Map<String, dynamic> json) => Author(
        name: json['name'],
        image: json['avatar_urls']['96'],
      );
}

////////////////////////////////////////////////////

class PostImage {
  PostImage({
    this.url,
  });

  String? url;

  factory PostImage.fromJSON(Map<dynamic, dynamic> json) => PostImage(
        url: json['guid'] != null ? json['guid']['rendered'] : null,
      );
}

////////////////////////////////////////////////////

class PostCategory {
  PostCategory({
    this.name,
  });

  String? name;

  factory PostCategory.fromJSON(Map<String, dynamic> json) => PostCategory(
        name: json['name'],
      );
}

////////////////////////////////////////////////////

class Category {
  Category({this.name, this.posts});

  String? name, posts;
  factory Category.fromJSON(Map<String, dynamic> json) => Category(
      name: json['name'], posts: json['_links']['wp:post_type'][0]['href']);
}
