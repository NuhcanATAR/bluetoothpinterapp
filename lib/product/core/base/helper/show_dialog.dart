// ignore_for_file: deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/event.dart';
import 'package:bluetoothpinterapp/product/constant/icon.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/button_control.dart';
import 'package:bluetoothpinterapp/product/extension/dynamic_extensions.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/body_medium_text.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/title_large_text.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/title_medium_text.dart';
import 'package:bluetoothpinterapp/product/widget/widget/normaltextfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/button_widget.dart';

enum SnackType {
  success(Color(0xFF5150FF), "Başarılı", Icons.check_circle),
  warning(Color(0xffFD9D42), "Uyarı", Icons.warning_rounded),
  error(Color(0xffB42318), "Hatalı", Icons.error);

  final Color color;
  final String message;
  final IconData icon;
  const SnackType(this.color, this.message, this.icon);
}

class CodeNoahDialogs {
  final BuildContext context;

  CodeNoahDialogs(this.context);

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnack(SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _onFlushPressed(Flushbar? flushbar, bool showing) async {
    if (showing) {
      await flushbar?.dismiss(true);
      return;
    } else {
      return;
    }
  }

  Future<void> showFlush({String? message, required SnackType type}) async {
    Flushbar? flushbar;
    bool showing = false;
    flushbar = Flushbar(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      icon: Icon(type.icon, color: type.color, size: 42),
      borderRadius: BorderRadius.circular(10),
      messageText: Text(
        message ?? type.message,
        style: TextStyle(color: ColorUtility.black),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(4, 4),
          blurRadius: 12,
        ),
      ],
      isDismissible: true,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: ColorUtility.white,
      mainButton: IconButton(
        onPressed: () async => await _onFlushPressed(flushbar, showing),
        icon: const Icon(Icons.clear),
      ),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.IS_APPEARING ||
            status == FlushbarStatus.SHOWING) {
          showing = true;
        } else {
          showing = false;
        }
      },
    );

    await flushbar.show(context);
  }

  void showModalBottom(
    Widget child, {
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    showModalBottomSheet(
      context: context,
      barrierColor: barrierColor ?? Colors.transparent,
      builder: (context) => child,
      backgroundColor: backgroundColor ?? Colors.transparent,
    );
  }

  Future<T?> showAlert<T extends Object?>(Widget child) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const CircularProgressIndicator(
          color: Colors.white,
        ),
        content: child,
      ),
    );
  }

  Future<T?> showWarningAlert<T extends Object?>(
    AppIcons icon,
    Color color,
    String title,
    DynamicViewExtensions dynamicViewExtensions,
    Function()? funcOne,
    Function()? funcSecond,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: icon.toSvgImg(
          color,
          IconSizedsUtility.largeSize,
          IconSizedsUtility.largeSize,
        ),
        content: TitleLargeBlackBoldText(
          text: title,
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            height: dynamicViewExtensions.dynamicHeight(
              context,
              0.08,
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: "TAMAM",
                    func: funcOne,
                    btnStatus: ButtonTypes.primaryColorButton,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: "KAPAT",
                    func: funcSecond,
                    btnStatus: ButtonTypes.borderPrimaryColorButton,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<T?> showLoadingAlert<T extends Object?>(
    AppIcons icon,
    String title,
    String subTitle,
    DynamicViewExtensions dynamicViewExtensions,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: icon.toSvgImg(
          null,
          IconSizedsUtility.hugeSize,
          IconSizedsUtility.hugeSize,
        ),
        content: SizedBox(
          height: dynamicViewExtensions.dynamicHeight(context, 0.11),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: PaddingSizedsUtility.bottom(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: TitleLargeBlackBoldText(
                    text: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: PaddingSizedsUtility.bottom(
                    PaddingSizedsUtility.smallPaddingValue,
                  ),
                  child: BodyMediumBlackText(
                    text: subTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: const [
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }

  Future<T?> showCreatorAlert<T extends Object?>(
    String title,
    DynamicViewExtensions dynamicViewExtensions,
    Function()? funcOne,
    String btnText,
    TextEditingController controller,
    TextEditingController secondController,
    String hintText,
    String secondHintText,
    bool explanationStatus,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.hightPaddingValue,
        ),
        contentPadding: PaddingSizedsUtility.horizontal(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.outline,
                  size: IconSizedsUtility.normalSize,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TitleMediumBlackBoldText(
                text: title,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: dynamicViewExtensions.dynamicHeight(context, 0.2),
          child: Column(
            children: <Widget>[
              NormalTextFieldWidget(
                controller: controller,
                hintText: hintText,
                explanationStatus: explanationStatus,
                onChanged: (value) {
                  context.read<PrintOutBloc>().add(ProductTitleEvent(value));
                },
                isValidator: true,
                enabled: true,
                isLabelText: false,
                dynamicViewExtensions: dynamicViewExtensions,
              ),
              NumberTextFieldWidget(
                controller: secondController,
                hintText: secondHintText,
                onChanged: (value) {
                  context.read<PrintOutBloc>().add(ProductPriceEvent(value));
                },
                isLabelText: false,
                dynamicViewExtensions: dynamicViewExtensions,
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            height: dynamicViewExtensions.dynamicHeight(
              context,
              0.08,
            ),
            child: GestureDetector(
              onTap: funcOne,
              child: CustomButtonWidget(
                dynamicViewExtensions: dynamicViewExtensions,
                text: btnText,
                func: funcOne,
                btnStatus: ButtonTypes.primaryColorButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
