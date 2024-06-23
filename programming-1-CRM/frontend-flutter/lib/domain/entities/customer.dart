import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int? id;
  final String name;

  const Customer({this.id, required this.name});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'] as int?,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Customer copyWith({
    required String name,
  }) {
    return Customer(
      id: id,
      name: name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
