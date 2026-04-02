class BannerItem {
  String id;
  String imgUrl;

  BannerItem(this.id, this.imgUrl);

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(json["id"], json["imgUrl"]);
  }
}
