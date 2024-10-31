// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

part '../bloc/event.dart';
part '../bloc/state.dart';

class PrintersCubit extends HydratedBloc<PrintersEvent, PrintersState> {
  Logger logger = Logger();

  PrintersCubit() : super(PrintersInitial()) {
    on<PrinterSelected>((event, emit) {
      emit(
        PrintersLoaded(
          selectedDeviceId: event.selectedDevice.remoteId.toString(),
          selectedDeviceName: event.selectedDevice.platformName,
        ),
      );
    });
  }

  @override
  PrintersState fromJson(Map<String, dynamic> json) {
    try {
      final deviceId = json['selectedDeviceId'] as String?;
      final deviceName = json['selectedDeviceName'] as String?;
      if (deviceId != null && deviceName != null) {
        return PrintersLoaded(
          selectedDeviceId: deviceId,
          selectedDeviceName: deviceName,
        );
      }
      return PrintersInitial();
    } catch (_) {
      return PrintersInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(PrintersState state) {
    if (state is PrintersLoaded) {
      return {
        'selectedDeviceId': state.selectedDeviceId,
        'selectedDeviceName': state.selectedDeviceName,
      };
    }
    return null;
  }

  void selectPrinter(BluetoothDevice selectedDevice) {
    emit(
      PrintersLoaded(
        selectedDeviceId: selectedDevice.remoteId.toString(),
        selectedDeviceName: selectedDevice.platformName,
      ),
    );
  }

  Future<void> checkPermissions() async {
    final bluetoothScanStatus = await Permission.bluetoothScan.status;
    if (!bluetoothScanStatus.isGranted) {
      final result = await Permission.bluetoothScan.request();
      if (!result.isGranted) {
        logger.e('Bluetooth tarama izni verilmedi');
      }
    }

    final bluetoothConnectStatus = await Permission.bluetoothConnect.status;
    if (!bluetoothConnectStatus.isGranted) {
      final result = await Permission.bluetoothConnect.request();
      if (!result.isGranted) {
        logger.e('Bluetooth bağlantı izni verilmedi');
      }
    }

    final locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      final result = await Permission.location.request();
      if (!result.isGranted) {
        logger.e(
          'Konum izni verilmedi. Uygulama konum hizmetlerini kullanamayacak',
        );
      }
    }
  }
}
