// ignore_for_file: public_member_api_docs

class GifModel {
  GifModel(this.url, {this.likes = 0, this.isLiked = false});
  final String url;
  int likes;
  bool isLiked;

  void incrementLikes() {
    likes++;
  }

  void decrementLikes() {
    likes--;
  }
}
