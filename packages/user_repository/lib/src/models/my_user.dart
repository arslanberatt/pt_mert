import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;

  const MyUser({required this.id, required this.email, required this.name});

  static final empty = MyUser(id: '', email: '', name: '');

  MyUser copyWith({String? id, String? email, String? name}) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(id: id, email: email, name: name);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(id: entity.id, email: entity.email, name: entity.name);
  }

  bool get isEmpty => this == MyUser.empty;
  bool get isNotEmpty => this != MyUser.empty;

  @override
  List<Object?> get props => [id, email, name];
}
