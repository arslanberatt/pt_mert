import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class LessonPackage extends Equatable {
  final String packageId;
  final Customer customer;
  final int totalLessonCount;
  final int usedLessonCount;
  final DateTime createdAt;
  final bool isActive;
  final String? note;

  const LessonPackage({
    required this.packageId,
    required this.customer,
    required this.totalLessonCount,
    this.usedLessonCount = 0,
    required this.createdAt,
    this.isActive = true,
    this.note,
  });

  LessonPackage copyWith({
    String? packageId,
    Customer? customer,
    int? totalLessonCount,
    int? usedLessonCount,
    DateTime? createdAt,
    bool? isActive,
    String? note,
  }) {
    return LessonPackage(
      packageId: packageId ?? this.packageId,
      customer: customer ?? this.customer,
      totalLessonCount: totalLessonCount ?? this.totalLessonCount,
      usedLessonCount: usedLessonCount ?? this.usedLessonCount,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      note: note ?? this.note,
    );
  }

  static final empty = LessonPackage(
    packageId: '',
    customer: Customer.empty,
    totalLessonCount: 0,
    usedLessonCount: 0,
    createdAt: DateTime.now(),
    isActive: true,
    note: '',
  );

  bool get isEmpty => this == LessonPackage.empty;
  bool get isNotEmpty => this != LessonPackage.empty;

  LessonPackageEntity toEntity() {
    return LessonPackageEntity(
      packageId: packageId,
      customer: customer,
      totalLessonCount: totalLessonCount,
      usedLessonCount: usedLessonCount,
      createdAt: createdAt,
      isActive: isActive,
      note: note,
    );
  }

  static LessonPackage fromEntity(LessonPackageEntity entity) {
    return LessonPackage(
      packageId: entity.packageId,
      customer: entity.customer,
      totalLessonCount: entity.totalLessonCount,
      usedLessonCount: entity.usedLessonCount,
      createdAt: entity.createdAt,
      isActive: entity.isActive,
      note: entity.note,
    );
  }

  @override
  List<Object?> get props => [
    packageId,
    customer,
    totalLessonCount,
    usedLessonCount,
    createdAt,
    isActive,
    note,
  ];
}
