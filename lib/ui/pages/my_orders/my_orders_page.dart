import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/providers/order_provider.dart';
import 'package:taxipark_driver/core/constants/constants.dart';

import 'components/my_order_box.dart';

// ignore: constant_identifier_names
enum OrderStatus { ALL, COMPLETED, WAITING }

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  bool isLoading = false;
  final _controller = ScrollController();
  OrderStatus orderStatus = OrderStatus.ALL;
  String title = '';
  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    context.read<OrderProvider>().reset();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments as MyOrdersPageArgs;
      setState(() {
        switch (args.orderStatus) {
          case OrderStatus.ALL:
            title = 'Все заказы';
            break;
          case OrderStatus.COMPLETED:
            title = 'Выполненные заказы';
            break;
          case OrderStatus.WAITING:
            title = 'Заказы в ожидании';
            break;
          default:
            title = 'Заказы';
            break;
        }
      });
      if (args.orderStatus != OrderStatus.ALL) {
        orderStatus = args.orderStatus;
        context.read<OrderProvider>().query = {"status": orderStatus.name};
      }
      _controller.addListener(() {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (!isTop) {
            context.read<OrderProvider>().fetchOrders();
          }
        }
      });
      context.read<OrderProvider>().fetchOrders();
      setState(() => isLoading = false);
    });
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
          if (!isLoading)
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

class MyOrdersPageArgs {
  final OrderStatus orderStatus;
  const MyOrdersPageArgs({required this.orderStatus});
}
