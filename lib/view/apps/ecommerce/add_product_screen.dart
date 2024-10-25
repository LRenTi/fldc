import 'package:fldc/controller/apps/ecommerce/add_product_controller.dart';
import 'package:fldc/helpers/extensions/string.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/utils/utils.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddProductController controller = Get.put(AddProductController());
  late OutlineInputBorder _outlineInputBorder;

  @override
  void initState() {
    _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );
    // controller = AddProductController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'add_product_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Ecommerce",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Add Product'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-5', child: productImage()),
                    MyFlexItem(sizes: 'lg-7', child: generalInformation()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget generalInformation() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("General Information", fontWeight: 600),
          MySpacing.height(20),
          fields("Product Name", "Shirts", controller.productName),
          MySpacing.height(20),
          category(),
          MySpacing.height(20),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium("Price", fontWeight: 600),
                  MySpacing.height(8),
                  TextField(
                    controller: controller.price,
                    style: MyTextStyle.bodyMedium(fontWeight: 600),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: "Price",
                      prefixIcon: MyContainer.none(
                          margin: MySpacing.right(12),
                          alignment: Alignment.center,
                          color: contentTheme.primary.withAlpha(40),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(12)),
                          child: MyText.labelLarge("\$",
                              color: contentTheme.primary)),
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 47, minWidth: 50, maxWidth: 50),
                      hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
                      border: _outlineInputBorder,
                      focusedBorder: _outlineInputBorder,
                      disabledBorder: _outlineInputBorder,
                      enabledBorder: _outlineInputBorder,
                    ),
                  ),
                ],
              )),
              MySpacing.width(12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium("Price", fontWeight: 600),
                  MySpacing.height(8),
                  TextField(
                    controller: controller.discountPrice,
                    style: MyTextStyle.bodyMedium(fontWeight: 600),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        hintText: "Discount Price",
                        prefixIcon: MyContainer.none(
                            margin: MySpacing.right(12),
                            alignment: Alignment.center,
                            color: contentTheme.primary.withAlpha(40),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8)),
                            child: MyText.labelLarge("\$",
                                color: contentTheme.primary)),
                        prefixIconConstraints: BoxConstraints(
                            maxHeight: 47, minWidth: 50, maxWidth: 50),
                        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
                        border: _outlineInputBorder,
                        focusedBorder: _outlineInputBorder,
                        disabledBorder: _outlineInputBorder,
                        enabledBorder: _outlineInputBorder),
                  ),
                ],
              )),
            ],
          ),
          MySpacing.height(20),
          description(),
          MySpacing.height(20),
          stock(),
          MySpacing.height(20),
          controller.selectStock == StockAvailability.inStock
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    stockType(),
                    MySpacing.height(12),
                    fields(
                        controller.stockType == StockType.fixedStock
                            ? "Fix Quantity"
                            : "Daily Quantity",
                        "123",
                        controller.quantity),
                  ],
                )
              : SizedBox(),
          MySpacing.height(20),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100,
                  child: MyButton.outlined(
                      onPressed: () {},
                      backgroundColor: contentTheme.primary,
                      borderRadiusAll: 8,
                      child: MyText.bodyMedium("Cancel", fontWeight: 600)),
                ),
                MySpacing.width(12),
                SizedBox(
                  width: 100,
                  child: MyButton.block(
                      elevation: 0,
                      borderRadiusAll: 8,
                      onPressed: () {},
                      backgroundColor: contentTheme.primary,
                      child: MyText.bodyMedium(
                        "Save",
                        fontWeight: 600,
                        color: contentTheme.onPrimary,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Description", fontWeight: 600),
        MySpacing.height(8),
        TextField(
          maxLines: 6,
          minLines: 6,
          controller: controller.description,
          style: MyTextStyle.bodyMedium(fontWeight: 600),
          decoration: InputDecoration(
            hintText: "Description",
            hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
            border: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
            disabledBorder: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
          ),
        )
      ],
    );
  }

  Widget fields(String title, hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium(title, fontWeight: 600),
        MySpacing.height(8),
        TextField(
          controller: controller,
          style: MyTextStyle.bodyMedium(fontWeight: 600),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
            border: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
            disabledBorder: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
          ),
        ),
      ],
    );
  }

  Widget category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Select Category's", fontWeight: 600),
        MySpacing.height(12),
        DropdownButtonFormField<ProductCategory>(
          dropdownColor: contentTheme.background,
          menuMaxHeight: 200,
          elevation: 1,
          items: ProductCategory.values
              .map(
                (category) => DropdownMenuItem<ProductCategory>(
                  value: category,
                  child: MyText.labelMedium(category.name.capitalizeWords),
                ),
              )
              .toList(),
          icon: Icon(Icons.expand_more, size: 20),
          decoration: InputDecoration(
            hintText: "Select category",
            hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
            contentPadding: MySpacing.all(16),
            border: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
            disabledBorder: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
          ),
          onChanged: controller.basicValidator.onChanged<Object?>('category'),
        ),
      ],
    );
  }

  Widget stock() {
    return Wrap(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        MyText.bodyMedium("Stock Availability :", fontWeight: 600),
        MySpacing.width(12),
        Wrap(
            spacing: 16,
            children: StockAvailability.values
                .map(
                  (stock) => InkWell(
                    onTap: () => controller.onChangeStock(stock),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<StockAvailability>(
                          value: stock,
                          activeColor: theme.colorScheme.primary,
                          groupValue: controller.selectStock,
                          onChanged: controller.onChangeStock,
                          visualDensity: getCompactDensity,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        MySpacing.width(8),
                        MyText.labelMedium(
                            stock.name == 'inStock'
                                ? "In Stock"
                                : "Out of Stock",
                            fontWeight: 600),
                      ],
                    ),
                  ),
                )
                .toList()),
      ],
    );
  }

  Widget stockType() {
    return Wrap(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        MyText.bodyMedium("Stock Type :", fontWeight: 600),
        MySpacing.width(12),
        Wrap(
            spacing: 16,
            children: StockType.values
                .map(
                  (stockType) => InkWell(
                    onTap: () => controller.onChangeStockType(stockType),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<StockType>(
                          value: stockType,
                          activeColor: theme.colorScheme.primary,
                          groupValue: controller.stockType,
                          onChanged: controller.onChangeStockType,
                          visualDensity: getCompactDensity,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        MySpacing.width(8),
                        MyText.labelMedium(
                            stockType.name == 'fixedStock'
                                ? "Fixed stock"
                                : "Daily Stock",
                            fontWeight: 600)
                      ],
                    ),
                  ),
                )
                .toList()),
      ],
    );
  }

  Widget productImage() {
    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .6),
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Product Image", fontWeight: 600),
          MySpacing.height(20),
          MyContainer.bordered(
            borderRadiusAll: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onTap: controller.pickFiles,
            child: Center(
              heightFactor: 1.5,
              child: Padding(
                padding: MySpacing.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.folder_up),
                    MySpacing.height(12),
                    MyContainer(
                      width: 340,
                      alignment: Alignment.center,
                      paddingAll: 0,
                      child: MyText.titleMedium(
                        "Drop files here or click to upload.",
                        fontWeight: 600,
                        muted: true,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyContainer(
                      alignment: Alignment.center,
                      width: 610,
                      child: MyText.titleMedium(
                        "(This is just a demo dropzone. Selected files are not actually uploaded.)",
                        muted: true,
                        fontWeight: 500,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (controller.files.isNotEmpty) ...[
            MySpacing.height(16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: controller.files
                  .mapIndexed((index, file) => MyContainer.bordered(
                        borderRadiusAll: 8,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        paddingAll: 8,
                        child: SizedBox(
                          width: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                alignment: Alignment.topRight,
                                children: [
                                  MyContainer(
                                    height: 100,
                                    width: 100,
                                    borderRadiusAll: 8,
                                    color:
                                        contentTheme.onBackground.withAlpha(28),
                                    paddingAll: 0,
                                    child: Icon(LucideIcons.file, size: 20),
                                  ),
                                  MyContainer.transparent(
                                      onTap: () => controller.removeFile(file),
                                      paddingAll: 4,
                                      child: Icon(LucideIcons.circle_x,
                                          color: contentTheme.danger)),
                                ],
                              ),
                              MySpacing.height(8),
                              MyText.bodyMedium(file.name, fontWeight: 600),
                              MySpacing.height(4),
                              MyText.bodySmall(
                                Utils.getStorageStringFromByte(
                                    file.bytes?.length ?? 0),
                                fontWeight: 600,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ],
      ),
    );
  }
}
