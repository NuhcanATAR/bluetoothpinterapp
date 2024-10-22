import 'package:bluetoothpinterapp/feature/bottom_menu/bottommenu_viewmodel.dart';
import 'package:bluetoothpinterapp/product/constant/icon.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/bottom_menucontrol.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class BottomMenuView extends StatefulWidget {
  const BottomMenuView({
    super.key,
    this.startView,
  });

  final BottomMenuViews? startView;

  @override
  State<BottomMenuView> createState() => _BottomMenuViewState();
}

class _BottomMenuViewState extends BottomMenuViewModel {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: viewList[selectView],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        indicatorColor: Colors.transparent,
        selectedIndex: selectView,
        height: 80,
        onDestinationSelected: menuClickChange,
        destinations: <Widget>[
          // selling buying
          NavigationDestination(
            selectedIcon: AppIcons.printOutline.toSvgImg(
              Theme.of(context).colorScheme.primary,
              IconSizedsUtility.normalSize,
              IconSizedsUtility.normalSize,
            ),
            icon: AppIcons.printOutline.toSvgImg(
              Theme.of(context).colorScheme.outline,
              IconSizedsUtility.normalSize,
              IconSizedsUtility.normalSize,
            ),
            label: '',
          ),
          // search
          NavigationDestination(
            selectedIcon: AppIcons.formOutline.toSvgImg(
              Theme.of(context).colorScheme.primary,
              IconSizedsUtility.normalSize,
              IconSizedsUtility.normalSize,
            ),
            icon: AppIcons.formOutline.toSvgImg(
              Theme.of(context).colorScheme.outline,
              IconSizedsUtility.normalSize,
              IconSizedsUtility.normalSize,
            ),
            label: '',
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
