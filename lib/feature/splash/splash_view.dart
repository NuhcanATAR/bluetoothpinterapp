import 'package:bluetoothpinterapp/feature/splash/splash_viewmodel.dart';
import 'package:bluetoothpinterapp/product/constant/logo.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Padding(
          padding: PaddingSizedsUtility.all(
            130,
          ),
          child: Center(
            child: Container(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.smallPaddingValue,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    RadiusUtility.circularMediumValue,
                  ),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              child:
                  AppLogoConstants.appLogoPrimaryColor.toSvgImg(null, 200, 200),
            ),
          ),
        ),
      ),
    );
  }
}
