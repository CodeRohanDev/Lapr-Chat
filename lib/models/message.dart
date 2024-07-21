class MessageModel {
  String senderId;
  String text;
  int timestamp;
  String type;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.type,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      senderId: data['senderId'],
      text: data['text'],
      timestamp: data['timestamp'],
      type: data['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'type': type,
    };
  }
}
