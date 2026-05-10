enum Category { health, work, relationships }

extension CategoryExtension on Category {
  String get label {
    switch (this) {
      case Category.health:
        return 'Health';
      case Category.work:
        return 'Work';
      case Category.relationships:
        return 'Relationships';
    }
  }

  static Category fromString(String value) {
    return Category.values.firstWhere(
      (category) => category.toString().split('.').last == value,
      orElse: () => Category.health,
    );
  }

  String toShortString() => toString().split('.').last;
}

class Entry {
  final String id;
  final String title;
  final String content;
  final Category category;
  final DateTime createdDate;

  Entry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdDate,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category.toShortString(),
      'createdDate': createdDate.toIso8601String(),
    };
  }

  // Create Entry from Map (from SQLite)
  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      category: CategoryExtension.fromString(map['category'] as String),
      createdDate: DateTime.parse(map['createdDate'] as String),
    );
  }

  // Copy constructor for editing
  Entry copyWith({
    String? id,
    String? title,
    String? content,
    Category? category,
    DateTime? createdDate,
  }) {
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  String toString() =>
      'Entry(id: $id, title: $title, category: ${category.label}, date: $createdDate)';
}
