import 'package:flutter/foundation.dart';

class Sentiment {
  final String sentiment;
  final  sentScore;
  Sentiment({@required this.sentiment, @required this.sentScore});

  factory Sentiment.fromJson(Map<String, dynamic> json) {
    return Sentiment(
        sentiment: json['sentiment'], sentScore: json['sentScore']);
  }
}
