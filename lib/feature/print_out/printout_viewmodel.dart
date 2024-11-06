// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bluetoothpinterapp/feature/print_out/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/event.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/mixin.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/feature/print_out/printout_view.dart';
import 'package:bluetoothpinterapp/feature/printers/bloc/cubit.dart';
// import 'package:bluetoothpinterapp/product/constant/logo.dart';
import 'package:bluetoothpinterapp/product/core/base/base_state/base_state.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:bluetoothpinterapp/product/model/product_model.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';

abstract class PrintOutViewModel extends BaseState<PrintOutView>
    with PrintOutBlocMixin {
  final formPrintOutKey = GlobalKey<FormState>();
  final formProductAddKey = GlobalKey<FormState>();

  StreamSubscription<List<ScanResult>>? subscription;

  late TextEditingController titleController = TextEditingController();
  late TextEditingController explanationController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController productPriceController = TextEditingController();

  Future<void> connectToDevice(
    BuildContext context,
    String selectedDeviceId,
    String title,
    String explanation,
    List<ProductModel> productList,
  ) async {
    try {
      await FlutterBluePlus.adapterState
          .where((state) => state == BluetoothAdapterState.on)
          .first;

      await FlutterBluePlus.startScan(
        withServices: [],
        withNames: [],
        timeout: const Duration(seconds: 15),
      );

      subscription = FlutterBluePlus.onScanResults.listen((results) async {
        if (results.isNotEmpty) {
          try {
            final r = results.firstWhere(
              (result) => result.device.remoteId.str == selectedDeviceId,
              orElse: () => throw StateError(
                'Device with ID $selectedDeviceId not found.',
              ),
            );

            final device = r.device;
            if (kDebugMode) {
              print('Connecting to ${device.platformName}...');
            }

            await device.connect().timeout(const Duration(seconds: 10));

            final services = await device.discoverServices();
            BluetoothService? targetService;
            BluetoothCharacteristic? targetCharacteristic;

            for (final BluetoothService service in services) {
              for (final BluetoothCharacteristic characteristic
                  in service.characteristics) {
                if (characteristic.properties.write) {
                  targetService = service;
                  targetCharacteristic = characteristic;
                  break;
                }
              }
              if (targetService != null && targetCharacteristic != null) {
                break;
              }
            }

            if (targetService != null && targetCharacteristic != null) {
              if (!context.mounted) return;
              await CodeNoahDialogs(context).showFlush(
                type: SnackType.success,
                message: 'Yazıcıya bağlanılıyor...',
              );
              await _printReceiptBuying(
                targetCharacteristic,
                title,
                explanation,
                productList,
              );

              await subscription?.cancel();

              await device.disconnect();
            } else {
              if (!context.mounted) return;
              await CodeNoahDialogs(context).showFlush(
                type: SnackType.warning,
                message: 'Uygun yazıcı bulunamadı',
              );
              await device.disconnect();
            }
          } catch (e) {
            if (!context.mounted) return;
            logger.e('hata: $e');
            return;
          }
        }
      });

      await FlutterBluePlus.isScanning.where((val) => val == false).first;

      await subscription?.cancel();
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      printersBottomModel(context, dynamicViewExtensions);
      await CodeNoahDialogs(context).showFlush(
        type: SnackType.error,
        message: 'Hata oluştu: $e',
      );
    }
  }

  Future<void> _printReceiptBuying(
    BluetoothCharacteristic characteristic,
    String title,
    String explanation,
    List<ProductModel> productList,
  ) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.feed(1);

    bytes += generator.text(
      convertSpecialCharacters('FLUTTER'),
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        width: PosTextSize.size1,
        height: PosTextSize.size2,
      ),
    );

    bytes += generator.text(
      convertSpecialCharacters('YAZICI UYGULAMASI'),
      styles: const PosStyles(
        align: PosAlign.center,
        bold: false,
        width: PosTextSize.size1,
        height: PosTextSize.size1,
      ),
    );

    bytes += generator.feed(1);
    final String formattedDate =
        DateFormat('dd.MM.yyyy').format(DateTime.now());
    bytes += generator.row([
      PosColumn(
        text: convertSpecialCharacters('TARİH:'),
        width: 6,
        styles: const PosStyles(bold: false),
      ),
      PosColumn(
        text: formattedDate,
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: convertSpecialCharacters('SAAT:'),
        width: 6,
        styles: const PosStyles(bold: false),
      ),
      PosColumn(
        text: DateFormat('HH:mm').format(DateTime.now()),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);

    bytes += generator.feed(1);

    // title
    bytes += generator.row([
      PosColumn(
        text: convertSpecialCharacters('BASLIK'),
        width: 6,
        styles: const PosStyles(bold: true),
      ),
      PosColumn(
        text: convertSpecialCharacters(title),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);

    // explanation
    bytes += generator.row([
      PosColumn(
        text: convertSpecialCharacters('ACIKLAMA'),
        width: 6,
        styles: const PosStyles(bold: true),
      ),
      PosColumn(
        text: convertSpecialCharacters(explanation),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);

    // products
    if (productList.isNotEmpty) {
      bytes += generator.hr(ch: '-');
      bytes += generator.row([
        PosColumn(
          text: convertSpecialCharacters('Ürün Adı'),
          width: 6,
          styles: const PosStyles(bold: true),
        ),
        PosColumn(
          text: convertSpecialCharacters(
            'Fiyat (TL)',
          ),
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
          ),
        ),
      ]);
      for (final model in productList) {
        bytes += generator.row([
          PosColumn(
            text: convertSpecialCharacters(model.title),
            width: 6,
            styles: const PosStyles(bold: true),
          ),
          PosColumn(
            text: convertSpecialCharacters(
              model.price.toString(),
            ),
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            ),
          ),
        ]);
      }
      bytes += generator.hr(ch: '-');
    }

    bytes += generator.feed(1);

    // logo
    // TODO: You can use it to insert images in the output
    // final ByteData data =
    //     await rootBundle.load(AppLogoConstants.appLogoSecondPrimaryColor.toPng);
    // final Uint8List imageBytes = data.buffer.asUint8List();
    // final img.Image? logo = img.decodeImage(imageBytes);
    // if (logo != null) {
    //   final img.Image resizedLogo = img.copyResize(logo, width: 200);
    //   bytes += generator.imageRaster(resizedLogo);
    // }

    bytes += generator.feed(1);

    bytes += generator.cut();

    try {
      for (final chunk in chunkBytes(bytes, 20)) {
        await characteristic.write(chunk);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error writing to characteristic: $e');
      }
      throw Exception('Failed to write the characteristic');
    }
  }

  Future<void> printOutFunc(
    PrintOutState printOutState,
    PrintersState state,
  ) async {
    if (printOutState.title.isNotEmpty &&
        printOutState.explanation.isNotEmpty) {
      if (state is PrintersLoaded) {
        await connectToDevice(
          context,
          state.selectedDeviceId,
          printOutState.title,
          printOutState.explanation,
          printOutState.productList,
        );
      }
    } else {
      await CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: 'Lütfen Gerekli Alanları Doldurun.',
      );
    }
  }

  void productAddFunc() {
    CodeNoahDialogs(context).showCreatorAlert(
      'Ürün Ekle',
      dynamicViewExtensions,
      () {
        context.read<PrintOutBloc>().add(
              PrintOutProductAddFuncEvent(
                productNameController,
                productPriceController,
                context,
              ),
            );
      },
      'KAYDET',
      productNameController,
      productPriceController,
      'Ürün Adı',
      'Ürün Fiyat',
      false,
    );
  }
}
