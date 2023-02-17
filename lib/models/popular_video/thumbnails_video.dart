import 'package:youtube_app/models/popular_video/default_video.dart';

class Thumbnails {
	Default? defaultVideo;
	Default? medium;
	Default? high;
	Default? standard;
	Default? maxres;

	Thumbnails({this.defaultVideo, this.medium, this.high, this.standard, this.maxres});

	Thumbnails.fromJson(Map<String, dynamic> json) {
		defaultVideo = json['default'] != null ? Default.fromJson(json['default']) : null;
		medium = json['medium'] != null ? Default.fromJson(json['medium']) : null;
		high = json['high'] != null ? Default.fromJson(json['high']) : null;
		standard = json['standard'] != null ? Default.fromJson(json['standard']) : null;
		maxres = json['maxres'] != null ? Default.fromJson(json['maxres']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (defaultVideo != null) {
      data['default'] = defaultVideo?.toJson();
    }
		if (medium != null) {
      data['medium'] = medium?.toJson();
    }
		if (high != null) {
      data['high'] = high?.toJson();
    }
		if (standard != null) {
      data['standard'] = standard?.toJson();
    }
		if (maxres != null) {
      data['maxres'] = maxres?.toJson();
    }
		return data;
	}
}