import 'package:fdag/utils/device/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This is the UI class that consumes the provider and
/// displays the connectivity status to the user.
class CheckNetwork extends ConsumerWidget {
  const CheckNetwork({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStatus = ref.watch(connectivityProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Network Status')),
      body: Center(
        child: FutureBuilder<bool>(
          future: ref.read(connectivityProvider.notifier).isDeviceConnected(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data == true) {
              return Text('Device is connected to the internet');
            } else {
              return Text('No internet connection');
            }
          },
        ),
      ),
    );
  }
}
