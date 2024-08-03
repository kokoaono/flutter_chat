class MessageData {
  String? id;
  String? text;
  String? sender;

  MessageData({this.id, this.text, this.sender});

  MessageData.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'];
    data['text'];
    return data;
  }
}
