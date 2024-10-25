import 'package:fldc/controller/apps/ecommerce/product_detail_controller.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb.dart';
import 'package:fldc/helpers/widgets/my_breadcrumb_item.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_flex.dart';
import 'package:fldc/helpers/widgets/my_flex_item.dart';
import 'package:fldc/helpers/widgets/my_list_extension.dart';
import 'package:fldc/helpers/widgets/my_responsive.dart';
import 'package:fldc/helpers/widgets/my_screen_media_type.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_star_rating.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/product_modal.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProductDetailController controller = Get.put(ProductDetailController());

  @override
  void initState() {
    // controller = ProductDetailController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
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
                        MyBreadcrumbItem(name: 'Product Detail'),
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
                    MyFlexItem(sizes: 'lg-5', child: productImages()),
                    MyFlexItem(sizes: 'lg-7', child: information()),
                    MyFlexItem(child: similarProduct()),
                    MyFlexItem(child: offerPoster()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget similarProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.titleMedium("Similar Product", fontWeight: 600),
            MyContainer(
                color: contentTheme.primary.withAlpha(36),
                paddingAll: 8,
                borderRadiusAll: 8,
                onTap: () => controller.goToProductsScreen(),
                child: MyText.bodySmall("See All",
                    fontWeight: 600, color: contentTheme.primary))
          ],
        ),
        MySpacing.height(20),
        SizedBox(
          height: 315,
          child: ListView.separated(
            itemCount: controller.product.length,
            shrinkWrap: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              ProductModal product = controller.product[index];
              return MyCard(
                shadow:
                    MyShadow(position: MyShadowPosition.bottom, elevation: .5),
                borderRadiusAll: 8,
                paddingAll: 23,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer(
                      height: 214,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      paddingAll: 0,
                      borderRadiusAll: 8,
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    MySpacing.height(12),
                    MyText.bodyMedium(product.name, fontWeight: 600),
                    MySpacing.height(8),
                    MyText.bodyMedium("\$${product.price}", fontWeight: 600)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MySpacing.width(24);
            },
          ),
        ),
      ],
    );
  }

  Widget offerPoster() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      height: 450,
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: 8,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 450,
            width: double.infinity,
            child: Image.asset("assets/images/products/offer_poster.jpg",
                fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withOpacity(.6)),
          Positioned(
            bottom: 24,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.displaySmall(
                  "TODAY",
                  fontWeight: 700,
                  color: contentTheme.background,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "40%",
                      style: MyTextStyle.displayLarge(
                          fontSize: 100,
                          fontWeight: 600,
                          color: contentTheme.background)),
                  TextSpan(
                      text: "OFF",
                      style: MyTextStyle.displaySmall(
                          color: contentTheme.background)),
                ])),
              ],
            ),
          ),
          Positioned(
            right: 60,
            top: 60,
            child: MyContainer.rounded(
              height: 150,
              width: 150,
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: contentTheme.primary.withOpacity(.6),
              child: Center(
                  child: MyText.titleLarge("SHOP NOW",
                      fontWeight: 600, color: contentTheme.onPrimary)),
            ),
          )
        ],
      ),
    );
  }

  Widget information() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        productInfo(),
        MySpacing.height(20),
        selectSize(),
        MySpacing.height(20),
        productDetail(),
      ],
    );
  }

  Widget productDetail() {
    Widget productData(String title, detail) {
      return Row(
        children: [
          MyText.bodyMedium("${title}: ", fontWeight: 600),
          MyText.bodyMedium(detail, fontWeight: 600),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Product Detail", fontWeight: 600),
          MySpacing.height(20),
          productData("Name", "Dresses"),
          MySpacing.height(20),
          productData("Fabric", "Cotton"),
          MySpacing.height(20),
          productData("Stock", "10"),
          MySpacing.height(20),
          productData("Color", "Pink, Blue"),
          MySpacing.height(20),
          MyText.bodyMedium(controller.dummyTexts[2],
              fontWeight: 600, muted: true, maxLines: 3),
          MyText.bodyMedium(controller.dummyTexts[3],
              fontWeight: 600, muted: true, maxLines: 2),
          MySpacing.height(20),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            children: [
              MyResponsive(
                builder: (_, __, type) {
                  return SizedBox(
                    width: type == MyScreenMediaType.xxl ||
                            type == MyScreenMediaType.xl ||
                            type == MyScreenMediaType.md
                        ? 200
                        : double.infinity,
                    child: MyButton.block(
                        onPressed: () {},
                        elevation: 0,
                        backgroundColor: contentTheme.primary,
                        padding: MySpacing.y(16),
                        child: MyText.bodyMedium("Buy Now",
                            color: contentTheme.onPrimary, fontWeight: 600)),
                  );
                },
              ),
              MyResponsive(
                builder: (_, __, type) {
                  return SizedBox(
                    width: type == MyScreenMediaType.xxl ||
                            type == MyScreenMediaType.xl ||
                            type == MyScreenMediaType.md
                        ? 200
                        : double.infinity,
                    child: MyButton.outlined(
                        onPressed: () {},
                        elevation: 0,
                        borderColor: contentTheme.secondary,
                        padding: MySpacing.y(16),
                        child:
                            MyText.bodyMedium("Add to cart", fontWeight: 600)),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget productInfo() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyText.headlineMedium(
                    "Girl's Color neck printed full length dresses",
                    fontWeight: 600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              MyContainer(
                color: contentTheme.primary.withAlpha(36),
                paddingAll: 8,
                borderRadiusAll: 8,
                child: MyText.bodySmall("Free Delivery",
                    color: contentTheme.primary, fontWeight: 600),
              )
            ],
          ),
          MySpacing.height(20),
          Row(
            children: [
              MyStarRating(rating: 4),
              MyText.bodyMedium(" 4.3", fontWeight: 600),
              MySpacing.width(4),
              MyText.bodyMedium("(130 reviews)", fontWeight: 600)
            ],
          ),
          MySpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText.bodySmall("\$199.99",
                  decoration: TextDecoration.lineThrough),
              MySpacing.width(4),
              MyText.bodyLarge("\$129.99", fontWeight: 700),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectSize() {
    return MyCard(
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Select Size", fontWeight: 600),
          MySpacing.height(20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MyText.bodyMedium("Size", fontWeight: 600),
              productSizes("M", 1),
              productSizes("S", 2),
              productSizes("L", 3),
              productSizes("XL", 4),
              productSizes("XXL", 5),
            ],
          )
        ],
      ),
    );
  }

  Widget productSizes(String size, int id) {
    int select = controller.isSelectedSize;
    return MyContainer.bordered(
      onTap: () => controller.onSelectedSize(id),
      color: select == id ? contentTheme.primary.withAlpha(32) : null,
      // bordered: select != id,
      borderColor: select == id ? contentTheme.primary.withAlpha(32) : null,
      borderRadiusAll: 8,
      width: 50,
      padding: MySpacing.xy(8, 8),
      child: Center(
          child: MyText.bodyMedium(size,
              fontWeight: 600,
              color: select == id ? contentTheme.primary : null)),
    );
  }

  Widget productImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyContainer(
          borderRadiusAll: 8,
          paddingAll: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            controller.selectedImage,
            fit: BoxFit.cover,
            height: 450,
          ),
        ),
        MySpacing.height(8),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            spacing: 12,
            children: controller.images
                .mapIndexed(
                  (index, image) => MyContainer.bordered(
                    onTap: () {
                      controller.onChangeImage(image);
                    },
                    height: 100,
                    width: 100,
                    bordered: image == controller.selectedImage,
                    border: Border.all(color: contentTheme.primary, width: 2),
                    borderRadiusAll: 8,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList()),
      ],
    );
  }
}
