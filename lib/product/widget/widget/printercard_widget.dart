import 'package:bluetoothpinterapp/product/constant/icon.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CustomPrinterCardWidget extends StatefulWidget {
  const CustomPrinterCardWidget({
    super.key,
    required this.selectedDevice,
    required this.device,
    required this.cardOnTap,
  });

  final BluetoothDevice? selectedDevice;
  final BluetoothDevice device;
  final Function()? cardOnTap;

  @override
  State<CustomPrinterCardWidget> createState() =>
      _CustomPrinterCardWidgetState();
}

class _CustomPrinterCardWidgetState extends State<CustomPrinterCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: PaddingSizedsUtility.all(
        PaddingSizedsUtility.smallPaddingValue,
      ),
      leading: AppIcons.printOutline.toSvgImg(
        Theme.of(context).colorScheme.primary,
        IconSizedsUtility.normalSize,
        IconSizedsUtility.normalSize,
      ),
      title: Text(widget.device.platformName),
      subtitle: Text(widget.device.remoteId.toString()),
      shape: widget.selectedDevice == widget.device
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                RadiusUtility.circularLowValue,
              ),
            )
          : null,
      onTap: widget.cardOnTap,
    );
  }
}
