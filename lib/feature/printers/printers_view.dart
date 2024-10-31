// ignore_for_file: unused_local_variable

import 'package:bluetoothpinterapp/feature/printers/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/printers/printers_viewmodel.dart';
import 'package:bluetoothpinterapp/product/constant/image.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/button_control.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:bluetoothpinterapp/product/widget/button_widget.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/body_medium_text.dart';
import 'package:bluetoothpinterapp/product/widget/widget/printercard_widget.dart';
import 'package:bluetoothpinterapp/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class PrintersView extends StatefulWidget {
  const PrintersView({super.key});

  @override
  State<PrintersView> createState() => _PrintersViewState();
}

class _PrintersViewState extends PrintersViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        centerTitle: true,
        title: const BodyMediumBlackBoldText(
          text: 'Yazıcılar',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: BlocBuilder<PrintersCubit, PrintersState>(
          builder: (context, state) {
            BluetoothDevice? selectedDevice;

            if (state is PrintersLoaded) {
              final selectDeviceId = state.selectedDeviceId;
              final selectDeviceName = state.selectedDeviceName;

              final List<BluetoothDevice> deviceisNameDevices = devices
                  .where((model) => model.platformName.isNotEmpty)
                  .toList();

              final List<BluetoothDevice> filteredDevices = deviceisNameDevices
                  .where(
                    (device) =>
                        device.remoteId.toString() == selectDeviceId &&
                        device.platformName == selectDeviceName,
                  )
                  .toList();

              selectedDevice =
                  filteredDevices.isNotEmpty ? filteredDevices.first : null;
            }

            return scanning
                ? const CustomLoadingResponseWidget(
                    title: 'Yazıcılar Aranıyor',
                    subTitle: 'Lütfen Bekleyiniz',
                  )
                : devices.isEmpty
                    ? buildDevicesEmptyWidget
                    : buildDevicesListWidget;
          },
        ),
      ),
    );
  }

  // devices empty
  Widget get buildDevicesEmptyWidget => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxHeight < 500) {
            return const SizedBox();
          } else {
            return CustomSecondResponseWidget(
              titleText: 'Yazıcı Bulunamadı!',
              listOneText: 'Bluetooth bağlantınızı kontrol ediniz.',
              listSecondText: 'Yazıcınızı kontrol ediniz.',
              btnText: 'TEKRAR DENE',
              dynamicViewExtensions: dynamicViewExtensions,
              img: AppImages.notFound.toPngImg(300, 300),
              func: refreshDevices,
            );
          }
        },
      );

  // devices list
  Widget get buildDevicesListWidget => Column(
        children: <Widget>[
          // body
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshDevices,
              child: ListView.builder(
                itemCount: devices
                    .where((device) => device.platformName.isNotEmpty)
                    .length,
                itemBuilder: (context, index) {
                  final BluetoothDevice device = devices
                      .where((device) => device.platformName.isNotEmpty)
                      .toList()[index];
                  return CustomPrinterCardWidget(
                    selectedDevice: selectedDevice,
                    device: device,
                    cardOnTap: () {
                      setState(() {
                        selectedDevice = device;
                      });
                      context
                          .read<PrintersCubit>()
                          .add(PrinterSelected(device));
                    },
                  );
                },
              ),
            ),
          ),
          // footer button
          CustomButtonWidget(
            dynamicViewExtensions: dynamicViewExtensions,
            text: 'YAZICIYI KAYDET',
            func: () {
              if (selectedDevice != null) {
                context
                    .read<PrintersCubit>()
                    .add(PrinterSelected(selectedDevice!));
                CodeNoahDialogs(context).showFlush(
                  type: SnackType.success,
                  message: 'Yazıcı kaydedildi.',
                );
              } else {
                CodeNoahDialogs(context).showFlush(
                  type: SnackType.warning,
                  message:
                      'Yazıcı seçimi esnasında bir hata oluştu lütfen daha sonra tekrar deneyiniz!',
                );
              }
            },
            btnStatus: ButtonTypes.primaryColorButton,
          ),
        ],
      );
}
