class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? bio;
  final List<String> skills;
  final List<String> interests;
  final double rating;
  final int completedSwaps;
  final String location;
  final DateTime joinedDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.bio,
    required this.skills,
    required this.interests,
    this.rating = 0.0,
    this.completedSwaps = 0,
    this.location = '',
    required this.joinedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      bio: json['bio'],
      skills: List<String>.from(json['skills'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      completedSwaps: json['completedSwaps'] ?? 0,
      location: json['location'] ?? '',
      joinedDate: DateTime.parse(json['joinedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'bio': bio,
      'skills': skills,
      'interests': interests,
      'rating': rating,
      'completedSwaps': completedSwaps,
      'location': location,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? bio,
    List<String>? skills,
    List<String>? interests,
    double? rating,
    int? completedSwaps,
    String? location,
    DateTime? joinedDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      rating: rating ?? this.rating,
      completedSwaps: completedSwaps ?? this.completedSwaps,
      location: location ?? this.location,
      joinedDate: joinedDate ?? this.joinedDate,
    );
  }
} 