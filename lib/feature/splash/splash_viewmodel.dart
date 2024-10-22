import 'package:bluetoothpinterapp/feature/bottom_menu/bottommenu_view.dart';
import 'package:bluetoothpinterapp/feature/splash/splash_view.dart';
import 'package:bluetoothpinterapp/product/core/base/base_state/base_state.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/navigator_router.dart';

abstract class SplashViewModel extends BaseState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      if (!mounted) return;
      CodeNoahNavigatorRouter.pushAndRemoveUntil(
        context,
        const BottomMenuView(),
      );
    });
  }
}
