import 'package:bluetoothpinterapp/product/constant/image.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/button_control.dart';
import 'package:bluetoothpinterapp/product/extension/dynamic_extensions.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:bluetoothpinterapp/product/widget/button_widget.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/body_medium_text.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/title_large_text.dart';
import 'package:flutter/material.dart';

class CustomResponseWidget extends StatelessWidget {
  const CustomResponseWidget({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
  });

  final AppImages img;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingSizedsUtility.all(
        PaddingSizedsUtility.normalPaddingValue,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // img
              img.toSvgImg(
                null,
                0,
                160,
              ),
              // title
              Padding(
                padding: PaddingSizedsUtility.top(
                  PaddingSizedsUtility.hightPaddingValue,
                ),
                child: TitleLargeBlackBoldText(
                  text: title,
                  textAlign: TextAlign.center,
                ),
              ),
              // sub title
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
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
    );
  }
}

class CustomLoadingResponseWidget extends StatelessWidget {
  const CustomLoadingResponseWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingSizedsUtility.all(
        PaddingSizedsUtility.normalPaddingValue,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),

            // title
            Padding(
              padding: PaddingSizedsUtility.top(
                PaddingSizedsUtility.hightPaddingValue,
              ),
              child: TitleLargeBlackBoldText(
                text: title,
                textAlign: TextAlign.center,
              ),
            ),
            // sub title
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: BodyMediumBlackText(
                text: subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSecondResponseWidget extends StatelessWidget {
  const CustomSecondResponseWidget({
    super.key,
    required this.titleText,
    required this.listOneText,
    required this.listSecondText,
    required this.btnText,
    required this.dynamicViewExtensions,
    required this.img,
    required this.func,
  });

  final String titleText;
  final String listOneText;
  final String listSecondText;
  final String btnText;
  final DynamicViewExtensions dynamicViewExtensions;
  final Widget img;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: img,
          ),
          Padding(
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.mediumPaddingValue,
            ),
            child: TitleLargeBlackBoldText(
              text: titleText,
              textAlign: TextAlign.center,
            ),
          ),
          // options
          Padding(
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.hightPaddingValue,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: IconSizedsUtility.mediumSecondSize,
                ),
                Expanded(
                  child: Padding(
                    padding: PaddingSizedsUtility.left(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: BodyMediumBlackText(
                      text: listOneText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.hightPaddingValue,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: IconSizedsUtility.mediumSecondSize,
                ),
                Expanded(
                  child: Padding(
                    padding: PaddingSizedsUtility.left(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: BodyMediumBlackText(
                      text: listSecondText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // button
          Padding(
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.mediumPaddingValue,
            ),
            child: CustomButtonWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              text: btnText,
              func: func,
              btnStatus: ButtonTypes.primaryColorButton,
            ),
          ),
        ],
      ),
    );
  }
}
