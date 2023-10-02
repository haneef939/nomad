import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? description;
  final String? userId;
  final String? fullName;
  final likes;
  final String? postId;
  final DateTime? datePublished;
  final String? postUrl;
  final String? profImage;

  const Post(
      { this.description,
       this.userId,
       this.fullName,
       this.likes,
       this.postId,
       this.datePublished,
       this.postUrl,
       this.profImage,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      userId: snapshot["userId"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      fullName: snapshot["fullName"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage']
    );
  }

   Map<String, dynamic> toJson() => {
        "description": description,
        "userId": userId,
        "likes": likes,
        "fullName": fullName,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
