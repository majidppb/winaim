part of '../dashboard.dart';

class CustomersWidget extends StatelessWidget {
  const CustomersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: customers,
      builder: (context, values, child) {
        return ListView(
          children: values.map((item) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  IconButton(
                    onPressed: () {
                      _delete(context, item.id!);
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(item.name),
                subtitle: Text('ID: ${item.id}'),
                onTap: () {
                  context
                      .push<bool>(
                    '${DashboardScreen.path}/${NewCustomerScreen.path}',
                    extra: item,
                  )
                      .then((value) {
                    if (value == true) {
                      _getCustomers(context);
                    }
                  });
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, int id) async {
    try {
      final token = getToken();
      final response = await dioProvider.delete(
        ApiEndpoints.customer,
        options: Options(headers: {'Authorization': 'Token $token'}),
        data: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Customer deleted'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
    await getSales();
    _getCustomers(context);
  }

  void _getCustomers(BuildContext context) async {
    try {
      await getCustomers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
  }
}
