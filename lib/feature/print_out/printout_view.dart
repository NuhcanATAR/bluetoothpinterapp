import 'package:bluetoothpinterapp/feature/print_out/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/event.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/feature/print_out/printout_viewmodel.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/button_control.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:bluetoothpinterapp/product/widget/button_widget.dart';
import 'package:bluetoothpinterapp/product/widget/text_widget/body_medium_text.dart';
import 'package:bluetoothpinterapp/product/widget/widget/normaltextfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrintOutView extends StatefulWidget {
  const PrintOutView({super.key});

  @override
  State<PrintOutView> createState() => _PrintOutViewState();
}

class _PrintOutViewState extends PrintOutViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        centerTitle: true,
        title: const BodyMediumBlackBoldText(
          text: 'Çıktı Al',
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocConsumer<PrintOutBloc, PrintOutState>(
        listener: (context, state) {
          productRemoveListener(context, state);
        },
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: ListView(
                children: <Widget>[
                  // title
                  buildTitleWidget,
                  // explanation
                  buildExplanationWidget,
                  // product form
                  buildProductFormWidget(state),
                  // print button
                  buildPrintButtonWidget,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // title
  Widget get buildTitleWidget => NormalTextFieldWidget(
        controller: titleController,
        hintText: 'Başlık',
        explanationStatus: false,
        onChanged: (String value) {
          context.read<PrintOutBloc>().add(TitleEvent(value));
        },
        isValidator: true,
        enabled: true,
        isLabelText: false,
        dynamicViewExtensions: dynamicViewExtensions,
      );

  // explanation
  Widget get buildExplanationWidget => NormalTextFieldWidget(
        controller: explanationController,
        hintText: 'Açıklama',
        explanationStatus: false,
        onChanged: (String value) {
          context.read<PrintOutBloc>().add(ExplanationEvent(value));
        },
        isValidator: true,
        enabled: true,
        isLabelText: false,
        dynamicViewExtensions: dynamicViewExtensions,
      );

  // product form
  Widget buildProductFormWidget(PrintOutState state) => Column(
        children: <Widget>[
          // product add button
          CustomButtonWidget(
            dynamicViewExtensions: dynamicViewExtensions,
            text: 'Ürün Ekle',
            func: () {
              CodeNoahDialogs(context).showCreatorAlert(
                'Ürün Ekle',
                dynamicViewExtensions,
                () {},
                'KAYDET',
                productNameController,
                productPriceController,
                'Ürün Adı',
                'Ürün Fiyat',
                false,
              );
            },
            btnStatus: ButtonTypes.borderPrimaryColorButton,
          ),
          // product list
          state.productList.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    final model = state.productList[index];
                    return Padding(
                      padding: PaddingSizedsUtility.vertical(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            context
                                .read<PrintOutBloc>()
                                .add(RemoveProductEvent(index));
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: IconSizedsUtility.mediumSize,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        title: BodyMediumBlackBoldText(
                          text: model.title,
                          textAlign: TextAlign.left,
                        ),
                        trailing: BodyMediumBlackText(
                          text: '${model.price}₺',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    );
                  },
                ),
        ],
      );

  // print button
  Widget get buildPrintButtonWidget => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: 'YAZDIR',
        func: () {},
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
