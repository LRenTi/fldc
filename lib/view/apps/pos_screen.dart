import 'package:fldc/controller/apps/pos_controller.dart';
import 'package:fldc/helpers/extensions/double_extension.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_dashed_divider.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/shopping_cart_data.dart';
import 'package:fldc/model/shopping_product_data.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late PosController controller;

  @override
  void initState() {
    controller = Get.put(PosController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'pos_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("POS", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'POS'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  contentPadding: false,
                  children: [
                    MyFlexItem(
                      sizes: 'lg-3.5',
                      child: MyContainer(
                          height: 815,
                          borderRadiusAll: 12,
                          paddingAll: 24,
                          child: Column(
                            children: [
                              TextFormField(
                                maxLines: 1,
                                style: MyTextStyle.bodyMedium(),
                                decoration: InputDecoration(
                                  hintText: "search",
                                  hintStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: focusedInputBorder,
                                  contentPadding: MySpacing.all(20),
                                  prefixIcon:
                                      Icon(LucideIcons.search, size: 20),
                                ),
                              ),
                              MySpacing.height(20),
                              Expanded(child: buildHomeDetail()),
                            ],
                          )),
                    ),
                    MyFlexItem(sizes: 'lg-4.5', child: buildCart()),
                    MyFlexItem(
                      sizes: 'lg-4',
                      child: MyContainer(
                        paddingAll: 24,
                        borderRadiusAll: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.titleMedium('Cart', fontWeight: 600),
                            MySpacing.height(12),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                buildCartList(),
                                MySpacing.height(32),
                                billingWidget()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCart() {
    return MyContainer(
      borderRadiusAll: 12,
      paddingAll: 24,
      child: ListView(
        shrinkWrap: true,
        children: [
          MyText.titleMedium('Product View', fontWeight: 600),
          MySpacing.height(20),
          if (controller.shoppingProduct != null)
            MyContainer(
              paddingAll: 0,
              borderRadiusAll: 12,
              height: 250,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(controller.shoppingProduct!.image,
                  fit: BoxFit.cover),
            ),
          MySpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.shoppingProduct != null)
                    MyText.titleMedium(controller.shoppingProduct!.name,
                        textAlign: TextAlign.start, fontWeight: 700),
                  if (controller.shoppingProduct != null)
                    MyText.titleMedium("\$${controller.shoppingProduct!.price}",
                        fontWeight: 600),
                ],
              ),
              Column(
                children: [
                  MyContainer(
                    borderRadiusAll: 12,
                    padding: MySpacing.xy(10, 8),
                    color: theme.colorScheme.primary,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.star,
                              color: theme.colorScheme.onPrimary, size: 14),
                          MySpacing.width(6),
                          if (controller.shoppingProduct != null)
                            MyText.labelLarge(
                                controller.shoppingProduct!.rating.toString(),
                                fontWeight: 600,
                                color: theme.colorScheme.onSecondary),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          MySpacing.height(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodySmall(controller.dummyTexts[1],
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              MySpacing.height(20),
              Row(
                children: [
                  MyText.bodyMedium('Size : ', fontSize: 16, fontWeight: 600),
                  MySpacing.width(12),
                  buildSelectSize()
                ],
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Stack(
                    children: [
                      MyContainer(
                        color: theme.colorScheme.primaryContainer,
                        paddingAll: 8,
                        borderRadiusAll: 8,
                        child: Icon(LucideIcons.shopping_bag,
                            color: theme.colorScheme.primary, size: 24),
                      ),
                      Positioned(
                        right: 4,
                        child: MyContainer.rounded(
                          color: theme.colorScheme.primary,
                          paddingAll: 4,
                          child: MyText.bodySmall("1",
                              color: theme.colorScheme.onPrimary,
                              fontSize: 8,
                              fontWeight: 700),
                        ),
                      )
                    ],
                  ),
                  MySpacing.width(20),
                  Expanded(
                    child: MyButton.block(
                      splashColor: theme.colorScheme.onPrimary.withAlpha(40),
                      backgroundColor: theme.colorScheme.primary,
                      elevation: 0,
                      borderRadiusAll: 12,
                      onPressed: () {},
                      child: MyText.bodyLarge('Add to Cart',
                          fontWeight: 600, color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              MySpacing.height(20),
              MyText.bodyLarge('Related', fontWeight: 600),
              MySpacing.height(12),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: buildProductList()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProductList() {
    List<Widget> list = [];

    for (ShoppingProduct product in controller.shopping) {
      list.add(MyContainer(
        borderRadiusAll: 12,
        paddingAll: 0,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyContainer(
              paddingAll: 0,
              borderRadiusAll: 12,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Image(
                      image: AssetImage(product.image),
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: InkWell(
                        onTap: () {},
                        child: Icon(Icons.favorite_outline, size: 20)),
                  ),
                ],
              ),
            ),
            MySpacing.height(8),
            MyText.labelLarge(product.name,
                overflow: TextOverflow.ellipsis, fontWeight: 600),
            MySpacing.height(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.labelLarge('\$${product.price}', fontWeight: 700),
                MyContainer.bordered(
                  paddingAll: 2,
                  borderRadiusAll: 4,
                  onTap: () {},
                  child: Icon(LucideIcons.plus, size: 12),
                ),
              ],
            ),
          ],
        ),
      ));
      list.add(MySpacing.width(20));
    }

    return Row(children: list);
  }

  Widget buildSelectSize() {
    final sizes = ['S', 'M', 'L', 'XL'];
    final sizeValues = [1, 2, 3, 4];

    return Wrap(
      spacing: 12,
      children: List.generate(sizes.length, (index) {
        var size = sizes[index];
        var sizeValue = sizeValues[index];
        bool isSelected = controller.selectSize == sizeValue;

        return MyContainer.rounded(
          paddingAll: 8,
          width: 36,
          height: 36,
          onTap: () => controller.onSelectSize(sizeValue),
          bordered: !isSelected,
          borderColor: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          color: isSelected ? theme.colorScheme.primary : null,
          child: Center(
            child: MyText.bodySmall(size,
                fontWeight: 600,
                color: isSelected
                    ? theme.colorScheme.onSecondary
                    : theme.colorScheme.onSurface),
          ),
        );
      }),
    );
  }

  Widget buildCartList() {
    List<Widget> list = [];

    for (ShoppingCart cart in controller.shoppingCart) {
      bool increaseAble = controller.increaseAble(cart);
      bool decreaseAble = controller.decreaseAble(cart);
      list.add(MySpacing.height(20));
      list.add(Row(
        children: [
          MyContainer(
            paddingAll: 0,
            borderRadiusAll: 12,
            height: 80,
            width: 80,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child:
                Image(fit: BoxFit.cover, image: AssetImage(cart.product.image)),
          ),
          MySpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium(cart.product.name,
                    overflow: TextOverflow.ellipsis, fontWeight: 700),
                MySpacing.height(8),
                MyText.bodyMedium('\$${cart.product.price}', fontWeight: 700),
                MySpacing.height(8),
                MyText.bodySmall('Size : ${cart.selectedSize}',
                    overflow: TextOverflow.ellipsis, fontWeight: 600),
              ],
            ),
          ),
          MySpacing.width(20),
          Column(
            children: [
              MyContainer(
                onTap: () => controller.increment(cart),
                bordered: increaseAble,
                paddingAll: 4,
                borderRadiusAll: 6,
                border: Border.all(color: theme.colorScheme.primary),
                color: increaseAble
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withAlpha(200),
                child: Icon(
                  LucideIcons.plus,
                  size: 12,
                  color: increaseAble
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onPrimary,
                ),
              ),
              MySpacing.height(8),
              MyText.bodyMedium(cart.quantity.toString(), fontWeight: 700),
              MySpacing.height(8),
              MyContainer(
                onTap: () => controller.decrement(cart),
                paddingAll: 4,
                borderRadiusAll: 6,
                bordered: decreaseAble,
                border:
                    Border.all(color: theme.colorScheme.primary.withAlpha(120)),
                color: decreaseAble
                    ? theme.colorScheme.primary.withAlpha(28)
                    : theme.colorScheme.onSurface.withAlpha(200),
                child: Icon(LucideIcons.minus,
                    size: 12,
                    color: decreaseAble
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onPrimary),
              ),
            ],
          ),
        ],
      ));
    }
    return Column(children: list);
  }

  Widget billingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium('Billing Information', muted: true, fontWeight: 700),
        MySpacing.height(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.bodyMedium('Order Total', fontWeight: 600),
            MyText.bodyMedium('\$${controller.order.precise}', fontWeight: 700),
          ],
        ),
        MySpacing.height(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.bodyMedium('Tax', fontWeight: 600),
            MyText.bodyMedium('\$${controller.tax.precise}', fontWeight: 700),
          ],
        ),
        MySpacing.height(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.bodyMedium('Offer', fontWeight: 600),
            MyText.bodyMedium('- \$${controller.offer.precise}',
                fontWeight: 700),
          ],
        ),
        MySpacing.height(12),
        Row(
          children: [
            Expanded(
              child: MyDashedDivider(
                  dashSpace: 4,
                  dashWidth: 8,
                  color: theme.colorScheme.onSurface.withAlpha(180),
                  height: 1.2),
            )
          ],
        ),
        MySpacing.height(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.bodyMedium('Grand Total', fontWeight: 700),
            MyText.bodyMedium('\$${controller.total.precise}', fontWeight: 800),
          ],
        ),
        MySpacing.height(20),
        MyButton.block(
            onPressed: () {},
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            padding: MySpacing.xy(12, 20),
            borderRadiusAll: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText.bodyMedium('Checkout',
                    fontWeight: 600, color: theme.colorScheme.onPrimary),
              ],
            )),
      ],
    );
  }

  Widget buildHomeDetail() {
    return ListView.separated(
      itemCount: controller.shopping.length,
      shrinkWrap: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => controller.onChangeProduct(controller.shopping[index]),
          child: Row(
            children: [
              MyContainer(
                paddingAll: 0,
                borderRadiusAll: 12,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(controller.shopping[index].image,
                    height: 100, width: 100, fit: BoxFit.cover),
              ),
              MySpacing.width(12),
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: MyText.bodyMedium(
                              controller.shopping[index].name,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: 600)),
                      MyText.bodySmall(controller.dummyTexts[1],
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      MyText.labelLarge('\$${controller.shopping[index].price}',
                          fontWeight: 700),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyContainer(
                            borderRadiusAll: 4,
                            padding: MySpacing.xy(8, 4),
                            color: theme.colorScheme.primary,
                            child: Row(
                              children: [
                                Icon(LucideIcons.star,
                                    color: theme.colorScheme.onPrimary,
                                    size: 12),
                                MySpacing.width(4),
                                MyText.bodySmall(
                                    "${controller.shopping[index].rating}",
                                    fontWeight: 600,
                                    color: theme.colorScheme.onPrimary),
                              ],
                            ),
                          ),
                          MyContainer.bordered(
                            paddingAll: 4,
                            borderRadiusAll: 4,
                            child: Icon(LucideIcons.plus,
                                size: 14, color: theme.colorScheme.onSurface),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}
