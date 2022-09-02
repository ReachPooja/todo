import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id = '',
    this.email = '',
    this.name = '',
    this.profileUrl = '',
  });

  final String id;
  final String email;
  final String name;
  final String profileUrl;

  static const empty = User();
  bool get isEmpty => this == empty;

  @override
  List<Object> get props => [id, email, name, profileUrl];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }
}
