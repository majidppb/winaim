import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:winaim/domain/enums/sale_stages.dart';

class Sale extends Equatable {
  final int? id;
  final DateTime startDate;
  final SaleStages stage;
  final String note;
  final int salesman;
  final int customer;

  const Sale({
    this.id,
    required this.startDate,
    required this.stage,
    required this.note,
    required this.salesman,
    required this.customer,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json['id'] as int?,
        startDate: DateTime.parse(json['start_date'] as String),
        stage: SaleStages.fromString(json['stage'] as String),
        note: json['note'] as String,
        salesman: json['salesman'] as int,
        customer: json['customer'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'start_date': DateFormat('yyyy-MM-dd').format(startDate),
        'stage': stage.name,
        'note': note,
        'customer': customer,
      };

  Sale copyWith({
    DateTime? startDate,
    SaleStages? stage,
    String? note,
    int? customer,
  }) {
    return Sale(
      id: id,
      startDate: startDate ?? this.startDate,
      stage: stage ?? this.stage,
      note: note ?? this.note,
      salesman: salesman,
      customer: customer ?? this.customer,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, startDate, stage, note, salesman, customer];
}
