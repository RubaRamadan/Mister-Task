import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const User({required this.id, required this.email, required this.firstName, required this.lastName, required this.avatar});

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }){
    return User(
        id: id??this.id,
        email:email??this.email,
        firstName: firstName??this.firstName,
        lastName: lastName??this.lastName,
        avatar: avatar??this.avatar
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'email':email,
      'first_name':firstName,
      'last_name':lastName,
      'avatar':avatar,
    };
  }

  factory User.fromMap( Map<String,dynamic> map){
    return User(id: map['id'],email: map['email'], firstName: map['first_name'], lastName: map['last_name'],
        avatar: map['avatar']);
  }

  @override
  List<Object?> get props => [id,email,firstName,lastName,avatar];

}