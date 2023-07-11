import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/providers/order_provider.dart';
import 'package:taxipark_driver/core/constants/constants.dart';

import 'components/my_order_box.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          context.read<OrderProvider>().fetchOrders();
        }
      }
    });
    context.read<OrderProvider>().reset();
    context.read<OrderProvider>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = context.watch<OrderProvider>().orders;
    int count = context.watch<OrderProvider>().count;
    bool isFetching = context.watch<OrderProvider>().isFetching;
    return Scaffold(
      body: CustomScrollView(
        physics: kPhysics,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_circle_left_outlined,
                    color: Colors.black)),
            centerTitle: true,
            title: const Text(
              "Заказы",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            if (isFetching) {
              return const Center(child: CircularProgressIndicator());
            }
            if (index == count) {
              return const SizedBox();
            }
            return OrderBox(model: orders[index]);
          }, childCount: orders.length + 1))
        ],
      ),
    );
  }
}
