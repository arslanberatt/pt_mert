import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

// ignore: must_be_immutable
class Customer extends Equatable {
  String customerId;
  String name;
  String phone;
  DateTime createdAt;
  int trainingCount;
  DateTime? lastTrainingDate;
  String? note;
  bool isActive;

  Customer({
    required this.customerId,
    required this.name,
    required this.phone,
    required this.createdAt,
    this.trainingCount = 0,
    this.lastTrainingDate,
    this.note,
    this.isActive = true,
  });

  Customer copyWith({
    String? customerId,
    String? name,
    String? phone,
    DateTime? createdAt,
    int? trainingCount,
    DateTime? lastTrainingDate,
    String? note,
    bool? isActive,
  }) {
    return Customer(
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      trainingCount: trainingCount ?? this.trainingCount,
      lastTrainingDate: lastTrainingDate ?? this.lastTrainingDate,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
    );
  }

  static final empty = Customer(
    customerId: '',
    name: '',
    phone: '',
    createdAt: DateTime.now(),
    trainingCount: 0,
    lastTrainingDate: null,
    note: '',
    isActive: true,
  );

  bool get isEmpty => this == Customer.empty;
  bool get isNotEmpty => this != Customer.empty;

  CustomerEntity toEntity() {
    return CustomerEntity(
      customerId: customerId,
      name: name,
      phone: phone,
      createdAt: createdAt,
      trainingCount: trainingCount,
      lastTrainingDate: lastTrainingDate,
      note: note,
      isActive: isActive,
    );
  }

  static Customer fromEntity(CustomerEntity entity) {
    return Customer(
      customerId: entity.customerId,
      name: entity.name,
      phone: entity.phone,
      createdAt: entity.createdAt,
      trainingCount: entity.trainingCount,
      lastTrainingDate: entity.lastTrainingDate,
      note: entity.note,
      isActive: entity.isActive,
    );
  }

  @override
  List<Object?> get props => [
    customerId,
    name,
    phone,
    createdAt,
    trainingCount,
    lastTrainingDate,
    note,
    isActive,
  ];

  @override
  String toString() {
    return ''' Customer: {
      customerId: $customerId
      name: $name
      phone: $phone
      createdAt: $createdAt
      trainingCount: $trainingCount
      lastTrainingDate: $lastTrainingDate
      note: $note
      isActive: $isActive
    }''';
  }
}
