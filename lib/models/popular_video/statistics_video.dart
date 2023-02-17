class Statistics {
	String? viewCount;
	String? likeCount;
	String? favoriteCount;
	String? commentCount;

	Statistics({this.viewCount, this.likeCount, this.favoriteCount, this.commentCount});

	Statistics.fromJson(Map<String, dynamic> json) {
		viewCount = json['viewCount'];
		likeCount = json['likeCount'];
		favoriteCount = json['favoriteCount'];
		commentCount = json['commentCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['viewCount'] = viewCount;
		data['likeCount'] = likeCount;
		data['favoriteCount'] = favoriteCount;
		data['commentCount'] = commentCount;
		return data;
	}
}