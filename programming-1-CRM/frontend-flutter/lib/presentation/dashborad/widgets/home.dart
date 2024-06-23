part of '../dashboard.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total number of sales opertunities',
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ValueListenableBuilder(
            valueListenable: sales,
            builder: (context, value, child) => Text(value.length.toString(),
                style: Theme.of(context).textTheme.displayMedium),
          ),
        ],
      ),
    );
  }
}
