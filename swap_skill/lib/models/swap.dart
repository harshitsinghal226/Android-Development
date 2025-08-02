enum SwapStatus {
  pending,
  accepted,
  inProgress,
  completed,
  cancelled,
}

class Swap {
  final String id;
  final String requesterId;
  final String requesterName;
  final String? requesterProfileImage;
  final String offeredSkillId;
  final String offeredSkillTitle;
  final String requestedSkillId;
  final String requestedSkillTitle;
  final String ownerId;
  final String ownerName;
  final String? ownerProfileImage;
  final SwapStatus status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final String? message;
  final double? rating;

  Swap({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    this.requesterProfileImage,
    required this.offeredSkillId,
    required this.offeredSkillTitle,
    required this.requestedSkillId,
    required this.requestedSkillTitle,
    required this.ownerId,
    required this.ownerName,
    this.ownerProfileImage,
    this.status = SwapStatus.pending,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
    this.message,
    this.rating,
  });

  factory Swap.fromJson(Map<String, dynamic> json) {
    return Swap(
      id: json['id'],
      requesterId: json['requesterId'],
      requesterName: json['requesterName'],
      requesterProfileImage: json['requesterProfileImage'],
      offeredSkillId: json['offeredSkillId'],
      offeredSkillTitle: json['offeredSkillTitle'],
      requestedSkillId: json['requestedSkillId'],
      requestedSkillTitle: json['requestedSkillTitle'],
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      ownerProfileImage: json['ownerProfileImage'],
      status: SwapStatus.values.firstWhere(
        (e) => e.toString() == 'SwapStatus.${json['status']}',
        orElse: () => SwapStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      acceptedAt: json['acceptedAt'] != null 
          ? DateTime.parse(json['acceptedAt']) 
          : null,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
      message: json['message'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'requesterName': requesterName,
      'requesterProfileImage': requesterProfileImage,
      'offeredSkillId': offeredSkillId,
      'offeredSkillTitle': offeredSkillTitle,
      'requestedSkillId': requestedSkillId,
      'requestedSkillTitle': requestedSkillTitle,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerProfileImage': ownerProfileImage,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'message': message,
      'rating': rating,
    };
  }

  Swap copyWith({
    String? id,
    String? requesterId,
    String? requesterName,
    String? requesterProfileImage,
    String? offeredSkillId,
    String? offeredSkillTitle,
    String? requestedSkillId,
    String? requestedSkillTitle,
    String? ownerId,
    String? ownerName,
    String? ownerProfileImage,
    SwapStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? completedAt,
    String? message,
    double? rating,
  }) {
    return Swap(
      id: id ?? this.id,
      requesterId: requesterId ?? this.requesterId,
      requesterName: requesterName ?? this.requesterName,
      requesterProfileImage: requesterProfileImage ?? this.requesterProfileImage,
      offeredSkillId: offeredSkillId ?? this.offeredSkillId,
      offeredSkillTitle: offeredSkillTitle ?? this.offeredSkillTitle,
      requestedSkillId: requestedSkillId ?? this.requestedSkillId,
      requestedSkillTitle: requestedSkillTitle ?? this.requestedSkillTitle,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      ownerProfileImage: ownerProfileImage ?? this.ownerProfileImage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      completedAt: completedAt ?? this.completedAt,
      message: message ?? this.message,
      rating: rating ?? this.rating,
    );
  }
} 