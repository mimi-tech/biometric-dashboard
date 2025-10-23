import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  const JournalEntry({
    required this.date,
    required this.mood,
    required this.note,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      date: DateTime.parse(json['date'] as String),
      mood: json['mood'] as int,
      note: json['note'] as String,
    );
  }

  final DateTime date;
  final int mood; // 1-5 scale
  final String note;

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String().split('T')[0],
      'mood': mood,
      'note': note,
    };
  }

  @override
  List<Object?> get props => [date, mood, note];
}
