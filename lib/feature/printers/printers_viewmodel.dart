import 'package:bluetoothpinterapp/feature/printers/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/printers/printers_view.dart';
import 'package:bluetoothpinterapp/product/core/base/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class PrintersViewModel extends BaseState<PrintersView> {
  List<BluetoothDevice> devices = [];
  bool scanning = false;
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    context.read<PrintersCubit>().checkPermissions().then((_) {
      startScan();
    });
  }

  Future<void> startScan() async {
    await FlutterBluePlus.stopScan();

    if (mounted) {
      setState(() {
        devices.clear();
        scanning = true;
        selectedDevice = null;
      });
    }

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
      androidUsesFineLocation: true,
    );

    FlutterBluePlus.scanResults.listen((results) {
      for (final ScanResult result in results) {
        if (!devices.contains(result.device)) {
          if (mounted) {
            setState(() {
              devices.add(result.device);
            });
          }
        }
      }
    }).onError((error) {
      logger.e('Scan error: $error');
    });

    await Future.delayed(const Duration(seconds: 10));
    await FlutterBluePlus.stopScan();
    if (mounted) {
      setState(() {
        scanning = false;
      });
    }
  }

  Future<void> refreshDevices() async {
    await startScan();
  }
}
