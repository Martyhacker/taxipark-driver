import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/providers/statistics_provider.dart';
import 'package:taxipark_driver/ui/widgets/default_appbar.dart';

import 'components/statistic_box.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticsProvider>().getStatistics();
  }

  @override
  Widget build(BuildContext context) {
    StatisticsProvider provider = context.watch<StatisticsProvider>();
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Статистика'),
      body: provider.isFetching
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                Expanded(
                    child: StatisticBox(
                  title: "Выгода",
                  count: provider.model?.profit ?? 0,
                )),
                Expanded(
                    child: StatisticBox(
                        title: "Все заказы",
                        count: provider.model?.orders?.allOrders ?? 0)),
                Expanded(
                    child: StatisticBox(
                        title: "Заказы в ожидании",
                        count: provider.model?.orders?.waitingOrders ?? 0)),
                Expanded(
                    child: StatisticBox(
                        title: "Выполненные заказы",
                        count: provider.model?.orders?.completedOrders ?? 0)),
              ],
            ),
    );
  }
}
