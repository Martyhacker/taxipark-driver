import 'package:flutter/material.dart';

import 'components/my_order_box.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              "My orders",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([const MyOrderBox()]))
        ],
      ),
    );
  }
}
