import 'package:youtube_app/models/popular_video/player_video.dart';
import 'package:youtube_app/models/popular_video/snippet_video.dart';
import 'package:youtube_app/models/popular_video/statistics_video.dart';

class Items {
	String? kind;
	String? etag;
	String? id;
	Snippet? snippet;
	Statistics? statistics;
	Player? player;

	Items({this.kind, this.etag, this.id, this.snippet, this.statistics, this.player});

	Items.fromJson(Map<String, dynamic> json) {
		kind = json['kind'];
		etag = json['etag'];
		// id = json['id'];
    if (json['id'] is String) {
    id = json['id'] as String;
  } else {
    id = (json['id'] as Map<String, dynamic>)['videoId'] as String;
  }
		snippet = json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
		statistics = json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null;
		player = json['player'] != null ? Player.fromJson(json['player']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['kind'] = kind;
		data['etag'] = etag;
		data['id'] = id;
		if (snippet != null) {
      data['snippet'] = snippet?.toJson();
    }
		if (statistics != null) {
      data['statistics'] = statistics?.toJson();
    }
		if (player != null) {
      data['player'] = player?.toJson();
    }
		return data;
	}
}