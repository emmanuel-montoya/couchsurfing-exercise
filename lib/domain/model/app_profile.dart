
import 'package:geolocator/geolocator.dart';

class AppProfile {

  String id;
  String name;
  String aboutMe;
  String photoUrl;
  double reviewStars =  10.0;
  bool isActive;
  String address;
  String phoneNumber;

  List<String>? followers;
  List<String>? following;
  List<String>? posts;
  List<String>? comments;
  List<String>? reports;
  Position? position;

  AppProfile({
    this.id = "",
    this.name = "",
    this.address = "",
    this.phoneNumber = "",
    this.photoUrl = "",
    this.aboutMe = "",
    this.reviewStars = 10.0,
    this.isActive = false,
  });


  @override
  String toString() {
    return 'AppProfile{id: $id, name: $name, aboutMe: $aboutMe, photoUrl: $photoUrl, reviewStars: $reviewStars, isActive: $isActive, address: $address, phoneNumber: $phoneNumber, followers: $followers, following: $following, posts: $posts, comments: $comments, reports: $reports, position: $position}';
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic> {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'aboutMe': aboutMe,
      'reviewStars': reviewStars,
      'isActive': isActive,
      'following': following,
      'followers': followers,
      'posts': posts,
      'comments': comments,
      'reports': reports,
    };
  }

  AppProfile.fromJSON(data) :
        id = data["id"] ?? "",
        name = data["name"] ?? "",
        photoUrl = data["photoUrl"] ?? "",
        aboutMe = data["aboutMe"] ?? "",
        reviewStars = data["reviewStars"] ?? 10,
        isActive = data["isActive"] ?? true,
        address = data["address"] ?? '',
        phoneNumber = data["phoneNumber"] ?? '',
        following = data["following"]?.cast<String>() ?? [],
        followers = data["followers"]?.cast<String>() ?? [],
        posts = data["posts"]?.cast<String>() ?? [],
        comments = data["comments"]?.cast<String>() ?? [],
        reports = data["reports"]?.cast<String>() ?? [];

}
