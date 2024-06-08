import 'dart:convert';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/enums/post_type.dart';

class Post {

  String id;
  String ownerId;
  String profileName;
  String profileImgUrl;
  String caption;

  PostType type;
  String mediaUrl ;
  String thumbnailUrl;
  int createdTime;
  int modifiedTime;
  Position? position;
  String location;

  List<String> likedProfiles;

  String referenceId;

  List<String> commentIds;

  Post({
    this.id = "",
    this.ownerId = "",
    this.profileName = "",
    this.profileImgUrl = "",
    this.caption = "",
    this.type = PostType.caption,
    this.mediaUrl = "",
    this.thumbnailUrl = "",
    this.createdTime = 0,
    this.modifiedTime = 0,
    this.position,
    this.location = "",
    this.likedProfiles = const [],
    this.commentIds = const [],
    this.referenceId = "",});


  @override
  String toString() {
    return 'Post{id: $id, ownerId: $ownerId, profileName: $profileName, profileImgUrl: $profileImgUrl, caption: $caption, type: $type, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, createdTime: $createdTime, modifiedTime: $modifiedTime, position: $position, location: $location, likedProfiles: $likedProfiles, referenceId: $referenceId, commentIds: $commentIds}';
  }

  Post.fromJSON(data) :
        id = data["id"] ?? "",
        ownerId = data["ownerId"] ?? "",
        profileName = data["profileName"] ?? "",
        profileImgUrl = data["profileImgUrl"] ?? "",
        caption = data["caption"] ?? "",
        type = EnumToString.fromString(PostType.values, data["type"] ?? PostType.caption.name) ?? PostType.caption,
        mediaUrl = data["mediaUrl"] ?? "",
        thumbnailUrl = data["thumbnailUrl"] ?? "",
        createdTime = data["createdTime"] ?? 0,
        modifiedTime = data["modifiedTime"] ?? 0,
        position = AppUtilities.jsonToPosition(data["position"]),
        location = data["location"] ?? "",
        likedProfiles = List.from(data["likedProfiles"] ?? []),
        commentIds = List.from(data["commentIds"] ?? []),
        referenceId = data["referenceId"] ?? "";

  Map<String, dynamic> toJSON()=>{
    'id': id,
    'ownerId': ownerId,
    'profileName': profileName,
    'profileImgUrl': profileImgUrl,
    'caption': caption,
    'type': type.name,
    'mediaUrl': mediaUrl,
    'thumbnailUrl': thumbnailUrl,
    'createdTime': createdTime,
    'modifiedTime': modifiedTime,
    'position': jsonEncode(position),
    'location': location,
    'likedProfiles': likedProfiles,
    'commentIds': commentIds,
    'referenceId': referenceId,
  };

  Post.createClone(Post post) :
    id = post.id,
    ownerId = post.ownerId,
    profileName = post.profileName,
    profileImgUrl = post.profileImgUrl,
    caption = post.caption,
    type = post.type,
    mediaUrl = post.mediaUrl,
    thumbnailUrl = post.thumbnailUrl,
    createdTime = post.createdTime,
    modifiedTime = post.modifiedTime,
    position = post.position,
    location = post.location,
    likedProfiles = post.likedProfiles,
    commentIds = post.commentIds,
    referenceId = post.referenceId;

}
