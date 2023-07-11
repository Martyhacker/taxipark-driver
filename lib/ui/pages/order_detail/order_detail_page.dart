import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/models/order_model.dart';
import 'package:taxipark_driver/core/api/providers/order_provider.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/utils/telephony_util.dart';
import 'package:taxipark_driver/ui/widgets/default_appbar.dart';
import 'package:taxipark_driver/ui/widgets/main_button.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchOrder.call();
    });
  }

  _fetchOrder() {
    var args =
        ModalRoute.of(context)?.settings.arguments as OrderDetailPageArgs;
    if (args.model.id != null) {
      context.read<OrderProvider>().fetchOneOrder(
          id: args.model.id!,
          onSuccess: () {
            setState(() => isLoading = false);
          });
    }
  }

  _onCancelled() {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text("Вы отменили этот заказ!")));
    context.read<OrderProvider>().reset();
    context.read<OrderProvider>().fetchOrders();
    Navigator.pop(context);
  }

  _onAccepted() {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text("Задача успешно выполнена!")));
    setState(() => isLoading = true);
    _fetchOrder.call();
  }

  _onError() {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(const SnackBar(content: Text("Error occured")));
  }

  _cancelOrder() {
    if (context.read<OrderProvider>().order == null &&
        context.read<OrderProvider>().order?.id == null) return;
    context.read<OrderProvider>().changeStatus(
        id: context.read<OrderProvider>().order!.id!,
        status: "CANCELLED(DRIVER)",
        onSuccess: _onCancelled,
        onError: _onError);
  }

  _acceptOrder() {
    if (context.read<OrderProvider>().order == null &&
        context.read<OrderProvider>().order?.id == null) return;
    context.read<OrderProvider>().changeStatus(
        id: context.read<OrderProvider>().order!.id!,
        status: "ACCEPTED",
        onSuccess: _onAccepted,
        onError: _onError);
  }

  _finishOrder() {
    if (context.read<OrderProvider>().order == null &&
        context.read<OrderProvider>().order?.id == null) return;
    context.read<OrderProvider>().changeStatus(
        id: context.read<OrderProvider>().order!.id!,
        status: "COMPLETED",
        onSuccess: _onAccepted,
        onError: _onError);
  }

  _startCounter() {
    if (context.read<OrderProvider>().order == null &&
        context.read<OrderProvider>().order?.id == null) return;
    context.read<OrderProvider>().changeOrder(
        id: context.read<OrderProvider>().order!.id!,
        body: {"counter_start_time": "start"},
        onSuccess: _onAccepted,
        onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    OrderModel? model = context.watch<OrderProvider>().order;
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Подробности'),
      bottomNavigationBar: model == null
          ? null
          : BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    if (model.acceptedTime == null)
                      Expanded(
                          child: MainButton(
                              padding: const EdgeInsets.all(10),
                              buttonColor: Colors.red,
                              onTap: () {
                                _cancelOrder.call();
                              },
                              text: "Отмена")),
                    if (model.acceptedTime == null)
                      Expanded(
                          child: MainButton(
                              padding: const EdgeInsets.all(10),
                              onTap: () {
                                _acceptOrder.call();
                              },
                              text: "Принимать")),
                    if (model.acceptedTime != null &&
                        model.counterStartTime == null)
                      Expanded(
                          child: MainButton(
                              padding: const EdgeInsets.all(10),
                              onTap: () {
                                _startCounter.call();
                              },
                              text: "Bключить счётчик")),
                    if (model.acceptedTime != null &&
                        model.endedTime == null &&
                        model.counterStartTime != null)
                      Expanded(
                          child: MainButton(
                              buttonColor: Colors.green,
                              padding: const EdgeInsets.all(10),
                              onTap: () {
                                _finishOrder.call();
                              },
                              text: "Завершить")),
                  ],
                ),
              ),
            ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (model == null)
              ? const SizedBox()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if ((model.start?.isNotEmpty ?? false) &&
                          model.start != null)
                        ListTile(
                          leading: SvgPicture.asset(IconAssets.gps),
                          title: Text(model.start ?? ""),
                        ),
                      if ((model.destination?.isNotEmpty ?? false) &&
                          model.destination != null)
                        ListTile(
                          leading: SvgPicture.asset(IconAssets.gps),
                          title: Text(model.destination ?? ""),
                        ),
                      if (model.startLat != null &&
                          model.startLon != null &&
                          model.destLat != null &&
                          model.destLon != null)
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.orderDetailMap);
                          },
                          leading: const Icon(Icons.map, color: Palette.black),
                          title: const Text("Клиент выбрал точки на карте"),
                          subtitle: const Text("Нажмите, чтобы открыть карту"),
                        ),
                      ListTile(
                        leading: const Icon(Icons.local_taxi_outlined,
                            color: Palette.black),
                        title: Text(model.orderType ?? ""),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person, color: Palette.black),
                        title: Text(model.username ?? ""),
                      ),
                      ListTile(
                        onTap: () async {
                          if (model.phone?.isNotEmpty ?? false) {
                            await TelephonyUtil.call(model.phone!);
                          }
                        },
                        leading: const Icon(Icons.phone, color: Palette.black),
                        title: Text(model.phone ?? ""),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class OrderDetailPageArgs {
  final OrderModel model;
  const OrderDetailPageArgs({required this.model});
}
