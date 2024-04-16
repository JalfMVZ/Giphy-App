// ignore_for_file: public_member_api_docs

class GifModel {
  GifModel(this.url,
      {this.likes = 0, this.isLiked = false, this.title, this.author});
  final String url;
  int likes;
  bool isLiked;
  final String? title;
  final String? author;

  void incrementLikes() {
    likes++;
  }

  void decrementLikes() {
    likes--;
  }
}
