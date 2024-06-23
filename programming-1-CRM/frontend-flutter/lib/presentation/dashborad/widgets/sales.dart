part of '../dashboard.dart';

class SalesWidget extends StatelessWidget {
  const SalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sales,
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
                title: Text('Sale ID: ${item.id}'),
                subtitle: Text(
                    'Customer: ${item.customer}, Stage: ${item.stage.getName()}'),
                onTap: () {
                  context
                      .push<bool>(
                    '${DashboardScreen.path}/${NewSaleScreen.path}',
                    extra: item,
                  )
                      .then((value) {
                    if (value == true) {
                      _getSales(context);
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
      final respose = await dioProvider.delete(
        ApiEndpoints.sale,
        options: Options(headers: {'Authorization': 'Token $token'}),
        data: jsonEncode({'id': id}),
      );
      if (respose.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sale deleted'),
          ),
        );
      }

      _getSales(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
  }

  void _getSales(BuildContext context) async {
    try {
      await getSales();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
  }
}
