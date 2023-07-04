class FavoritePhotoModel {
  FavoritePhotoModel(
      {this.favoriteId,
      required this.photoId,
      required this.smallImgUrl,
      required this.originalImgUrl});
  final int? favoriteId;
  final int photoId;
  final String smallImgUrl;
  final String originalImgUrl;
  factory FavoritePhotoModel.fromMap(Map<String, dynamic> map) {
    return FavoritePhotoModel(
      favoriteId: map['favoriteId']?.toInt() ?? 0,
      photoId: map['photoId'] ?? '',
      smallImgUrl: map['smallImgUrl'] ?? '',
      originalImgUrl: map['originalImgUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favoriteId': favoriteId,
      'photoId': photoId,
      'smallImgUrl': smallImgUrl,
      'originalImgUrl': originalImgUrl
    };
  }
}
