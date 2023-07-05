import 'package:flutter/material.dart';
import 'network_status_manager.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({Key? key}) : super(key: key);

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> with StateMixin {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    waitForScreen(() {
      _networkChange.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedCrossFade(
        firstChild: Container(
          height: kToolbarHeight * 0.4,
          width: size.width,
          color: Colors.red,
          child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "No connection",
                style: TextStyle(color: Colors.white),
              )),
        ),
        secondChild: const SizedBox(),
        crossFadeState: _networkResult == NetworkResult.off
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(seconds: 1));
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
