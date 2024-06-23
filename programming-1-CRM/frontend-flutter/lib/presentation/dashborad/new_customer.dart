import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/domain/entities/customer.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/auth.dart';
import 'package:winaim/utils/dio.dart';

class NewCustomerScreen extends StatefulWidget {
  const NewCustomerScreen({super.key, this.customer});

  static const path = 'new-customer';

  final Customer? customer;

  @override
  State<NewCustomerScreen> createState() => _NewCustomerScreenState();
}

class _NewCustomerScreenState extends State<NewCustomerScreen> {
  final _controller = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  String? _validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : 'Please enter a valid name';
  }

  Future<void> _onSubmit() async {
    if (_key.currentState!.validate()) {
      try {
        late final Customer customer;
        final token = getToken();
        if (widget.customer == null) {
          customer = Customer(name: _controller.text);

          final response = await dioProvider.post(
            ApiEndpoints.customer,
            options: Options(headers: {'Authorization': 'Token $token'}),
            data: customer.toJson(),
          );

          if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer created'),
              ),
            );
          }
        } else {
          customer = widget.customer!.copyWith(name: _controller.text);

          final response = await dioProvider.put(
            ApiEndpoints.customer,
            options: Options(headers: {'Authorization': 'Token $token'}),
            data: customer.toJson(),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer updated'),
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
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = (widget.customer ?? const Customer(name: '')).name;
    });

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.customer == null ? 'Create new customer' : 'Customer'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              TextFormField(
                controller: _controller,
                validator: _validator,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
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
    );
  }
}
