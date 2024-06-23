import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/data/data.dart';
import 'package:winaim/domain/entities/customer.dart';
import 'package:winaim/domain/entities/sale.dart';
import 'package:winaim/domain/enums/sale_stages.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/auth.dart';
import 'package:winaim/utils/dio.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key, this.sale});

  static const path = 'new-sale';

  final Sale? sale;

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  final _noteController = TextEditingController();
  final _startDateController = TextEditingController();
  Customer? _selectedCustomer;
  DateTime? _selectedDate;
  SaleStages _stage = SaleStages.co;
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _noteController.dispose();
    _startDateController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  String? _validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : 'Please enter a valid value';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _startDateController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  Future<void> _onSubmit() async {
    if (_key.currentState!.validate()) {
      try {
        late final Sale sale;
        final token = getToken();
        if (widget.sale == null) {
          sale = Sale(
            startDate: _selectedDate!,
            stage: _stage,
            note: _noteController.text,
            salesman: 0,
            customer: _selectedCustomer!.id!,
          );

          final response = await dioProvider.post(
            ApiEndpoints.sale,
            options: Options(headers: {'Authorization': 'Token $token'}),
            data: sale.toJson(),
          );

          if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sale created'),
              ),
            );
          }
        } else {
          sale = widget.sale!.copyWith(
            startDate: _selectedDate!,
            stage: _stage,
            note: _noteController.text,
            customer: _selectedCustomer!.id,
          );

          final response = await dioProvider.put(
            ApiEndpoints.sale,
            options: Options(headers: {'Authorization': 'Token $token'}),
            data: sale.toJson(),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sale updated'),
              ),
            );
          }
        }
        context.pop<bool>(true);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorry, something went wrong !'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    if (widget.sale != null) {
      _stage = widget.sale!.stage;
      _selectedDate = widget.sale!.startDate;
      _selectedCustomer =
          customers.value.firstWhere((e) => e.id == widget.sale!.customer);

      _noteController.text = widget.sale!.note;
      _startDateController.text =
          widget.sale!.startDate.toIso8601String().split('T').first;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sale == null ? 'Create new sale' : 'Sale'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                        label: Text('Start Date'),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: _validator,
                      readOnly: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<SaleStages>(
                  value: _stage,
                  decoration: const InputDecoration(
                    label: Text('Stage'),
                  ),
                  items: SaleStages.values.map((SaleStages stage) {
                    return DropdownMenuItem<SaleStages>(
                      value: stage,
                      child: Text(stage.getName()),
                    );
                  }).toList(),
                  onChanged: (SaleStages? newStage) {
                    setState(() {
                      _stage = newStage!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    label: Text('Note'),
                  ),
                  validator: _validator,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Customer>(
                  value: _selectedCustomer,
                  decoration: const InputDecoration(
                    labelText: 'Customer',
                  ),
                  items: customers.value.map((Customer customer) {
                    return DropdownMenuItem<Customer>(
                      value: customer,
                      child: Text(customer.name),
                    );
                  }).toList(),
                  validator: (value) {
                    return value != null ? null : 'Please select a customer';
                  },
                  onChanged: (Customer? newCustomer) {
                    setState(() {
                      _selectedCustomer = newCustomer;
                    });
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
