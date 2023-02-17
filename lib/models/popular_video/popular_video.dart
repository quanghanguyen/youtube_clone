import 'package:flutter/material.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/models/popular_video/page_info_video.dart';

// @JsonSerializable()
class PopularVideo {
  // @JsonKey(name: 'kind')
  // late String kind;

  // @JsonKey(name: 'etag')
  // late String tag;

  // @JsonKey(name: 'items')
  // late List<Video> items;

  // @JsonKey(name: 'nextPageToken')
  // String? nextPageToken;

  // PopularVideo();

  // factory PopularVideo.fromJson(Map<String, dynamic> json => 
  //   _$VideoResponseFromJson(json);
  // )

  String? kind;
	String? etag;
	late List<Items> items;
	String? nextPageToken;
	PageInfo? pageInfo;

	PopularVideo({this.kind, this.etag, required this.items, this.nextPageToken, this.pageInfo});

	PopularVideo.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		if (json['items'] != null) {
			items = <Items>[];
			json['items'].forEach((v) { items.add(Items.fromJson(v)); });
		}
		nextPageToken = json['nextPageToken'];
		pageInfo = json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
		data['nextPageToken'] = nextPageToken;
		if (pageInfo != null) {
      data['pageInfo'] = pageInfo?.toJson();
    }
		return data;
	}
}
