import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wordpress_app/Modal/modal.dart';
import 'package:wordpress_app/constants.dart';

class FetchData {
  String postsUrl = "$websiteUrl/wp-json/wp/v2/posts?per_page=15";
  String categoriesUrl = "$websiteUrl/wp-json/wp/v2/categories";

  Future fetchPosts() async {
    final response = await http
        .get(Uri.parse(postsUrl), headers: {"Accept": "application/json"});
    List<Post> convertedData = (json.decode(response.body) as List)
        .map((e) => Post.fromJSON(e))
        .toList();

    return convertedData;
  }

  Future fetchPostAuthor(String authorUrl) async {
    final response = await http
        .get(Uri.parse(authorUrl), headers: {"Accept": "application/json"});
    var convertedData = jsonDecode(response.body);

    Author author = Author.fromJSON(convertedData);

    return author;
  }

  Future fetchPostImage(String imageURL) async {
    final response = await http
        .get(Uri.parse(imageURL), headers: {"Accept": "application/json"});
    var convertedData = jsonDecode(response.body);

    PostImage postImage = PostImage.fromJSON(convertedData);

    return postImage;
  }

  Future fetchPostCategory(String categoryUrl) async {
    final response = await http
        .get(Uri.parse(categoryUrl), headers: {"Accept": "application/json"});

    var convertedData = jsonDecode(response.body);
    PostCategory postCategory = PostCategory.fromJSON(convertedData[0]);

    return postCategory;
  }

  Future<List> fetchCategories() async {
    final response = await http
        .get(Uri.parse(categoriesUrl), headers: {"Accept": "application/json"});
    List<Category> convertedData = (json.decode(response.body) as List)
        .map((e) => Category.fromJSON(e))
        .toList();

    return convertedData;
  }

  Future<List> fetchPostByCategories(String url) async {
    final response = await http.get(Uri.parse('$url&per_page=50'),
        headers: {"Accept": "application/json"});
    List<Post> convertedData = (json.decode(response.body) as List)
        .map((e) => Post.fromJSON(e))
        .toList();

    return convertedData;
  }

  Future fetchPostsBySearchQuery(String search) async {
    final response = await http.get(
        Uri.parse(
            '$websiteUrl/wp-json/wp/v2/posts?per_page=50&search=\'$search\''),
        headers: {"Accept": "application/json"});
    List<Post> convertedData = (json.decode(response.body) as List)
        .map((e) => Post.fromJSON(e))
        .toList();

    return convertedData;
  }
}
