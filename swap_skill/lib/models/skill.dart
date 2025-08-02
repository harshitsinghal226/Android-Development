class Skill {
  final String id;
  final String title;
  final String description;
  final String category;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final double userRating;
  final List<String> tags;
  final String difficulty;
  final int estimatedHours;
  final String location;
  final bool isAvailable;
  final DateTime createdAt;
  final List<String> images;

  Skill({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    this.userRating = 0.0,
    required this.tags,
    required this.difficulty,
    required this.estimatedHours,
    this.location = '',
    this.isAvailable = true,
    required this.createdAt,
    this.images = const [],
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      userId: json['userId'],
      userName: json['userName'],
      userProfileImage: json['userProfileImage'],
      userRating: (json['userRating'] ?? 0.0).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      difficulty: json['difficulty'],
      estimatedHours: json['estimatedHours'],
      location: json['location'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'userRating': userRating,
      'tags': tags,
      'difficulty': difficulty,
      'estimatedHours': estimatedHours,
      'location': location,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
      'images': images,
    };
  }

  Skill copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? userId,
    String? userName,
    String? userProfileImage,
    double? userRating,
    List<String>? tags,
    String? difficulty,
    int? estimatedHours,
    String? location,
    bool? isAvailable,
    DateTime? createdAt,
    List<String>? images,
  }) {
    return Skill(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      userRating: userRating ?? this.userRating,
      tags: tags ?? this.tags,
      difficulty: difficulty ?? this.difficulty,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      location: location ?? this.location,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
    );
  }
} 