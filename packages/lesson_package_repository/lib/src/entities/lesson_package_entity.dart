import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

class LessonPackageEntity extends Equatable {
  final String packageId;
  final Customer customer;
  final int totalLessonCount;
  final int usedLessonCount;
  final DateTime createdAt;
  final bool isActive;
  final String? note;

  const LessonPackageEntity({
    required this.packageId,
    required this.customer,
    required this.totalLessonCount,
    this.usedLessonCount = 0,
    required this.createdAt,
    this.isActive = true,
    this.note,
  });

  /// Firestore'a yazmak için
  Map<String, dynamic> toDocument() {
    return {
      'packageId': packageId,
      'customer': customer.toEntity().toDocument(),
      'totalLessonCount': totalLessonCount,
      'usedLessonCount': usedLessonCount,
      'createdAt': createdAt,
      'isActive': isActive,
      'note': note,
    };
  }

  /// Firestore'dan okumak için
  static LessonPackageEntity fromDocument(Map<String, dynamic> doc) {
    return LessonPackageEntity(
      packageId: doc['packageId'] as String? ?? '',
      customer: Customer.fromEntity(
        CustomerEntity.fromDocument(doc['customer']),
      ),
      totalLessonCount: doc['totalLessonCount'] as int? ?? 0,
      usedLessonCount: doc['usedLessonCount'] as int? ?? 0,
      createdAt: DateTime.parse(doc['createdAt']),
      isActive: doc['isActive'] as bool? ?? true,
      note: doc['note'] as String?,
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

  @override
  String toString() {
    return '''
LessonPackageEntity(
  packageId: $packageId,
  customer: $customer,
  totalLessonCount: $totalLessonCount,
  usedLessonCount: $usedLessonCount,
  createdAt: $createdAt,
  isActive: $isActive
  note: $note,
)''';
  }
}
