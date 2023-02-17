class Player {
	String? embedHtml;

	Player({this.embedHtml});

	Player.fromJson(Map<String, dynamic> json) {
		embedHtml = json['embedHtml'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['embedHtml'] = embedHtml;
		return data;
	}
}