import 'package:fldc/controller/apps/ecommerce/products_grid_controller.dart';
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
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_star_rating.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/model/product_modal.dart';
import 'package:fldc/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ProductsGridScreen extends StatefulWidget {
  const ProductsGridScreen({super.key});

  @override
  State<ProductsGridScreen> createState() => _ProductsGridScreenState();
}

class _ProductsGridScreenState extends State<ProductsGridScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProductListController controller = Get.put(ProductListController());

  @override
  void initState() {
    // controller = ProductListController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'product_list_controller',
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
                        MyBreadcrumbItem(name: 'Product List'),
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
                    MyFlexItem(sizes: 'lg-3 md-5', child: productFilter()),
                    MyFlexItem(sizes: 'lg-9 md-7', child: productList())
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget productFilter() {
    Widget rangeSlider() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodySmall(
                "\$${controller.rangeSlider.start.toString()}",
                fontWeight: 600,
              ),
              MyText.bodySmall(
                "\$${controller.rangeSlider.end.toString()}",
                fontWeight: 600,
              ),
            ],
          ),
          RangeSlider(
            min: controller.minimumPrice,
            max: controller.maximumPrice,
            divisions: 10,
            labels: RangeLabels(controller.rangeSlider.start.floor().toString(),
                controller.rangeSlider.end.floor().toString()),
            values: controller.rangeSlider,
            onChanged: (value) {
              controller.filterByPrice(value);
            },
            activeColor: theme.sliderTheme.activeTrackColor,
            inactiveColor: theme.sliderTheme.inactiveTrackColor,
          ),
        ],
      );
    }

    Widget buildRating(double rating, int id) {
      return InkWell(
        onTap: () {
          controller.filterByStart(rating);
          controller.onSelectRating(id);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.selectRating == id
                ? Icon(LucideIcons.circle_check, size: 20)
                : Icon(LucideIcons.circle, size: 20),
            MySpacing.width(12),
            MyStarRating(
              rating: rating,
              size: 20,
              spacing: 8,
              inactiveColor: contentTheme.secondary,
              activeColor: AppColors.star,
            ),
          ],
        ),
      );
    }

    Widget searchField() {
      return TextFormField(
        onChanged: controller.onSearchProduct,
        controller: controller.searchController,
        style: MyTextStyle.bodyMedium(),
        decoration: InputDecoration(
          hintText: "Search Product",
          isDense: true,
          contentPadding: MySpacing.xy(16, 12),
          filled: true,
          hintStyle: MyTextStyle.bodyMedium(),
          prefixIcon: Icon(LucideIcons.search),
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      );
    }

    return MyCard(
      borderRadiusAll: 8,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchField(),
          MySpacing.height(12),
          MyText.titleMedium("Filter", fontWeight: 600),
          MySpacing.height(12),
          rangeSlider(),
          MyText.titleMedium("Categories", fontWeight: 600),
          MySpacing.height(12),
          ...controller.category.map((e) {
            return MyContainer(
                paddingAll: 8,
                onTap: () {
                  controller.filterByCategory(e.id);
                  controller.onSelectCategories(e.id);
                },
                child: Row(
                  children: [
                    controller.selectCategory == e.id
                        ? Icon(LucideIcons.circle_check, size: 20)
                        : Icon(LucideIcons.circle, size: 20),
                    MySpacing.width(12),
                    MyText.bodySmall(e.name, fontWeight: 600),
                  ],
                ));
          }),
          MySpacing.height(12),
          MyText.titleMedium("Rating", fontWeight: 600),
          MySpacing.height(12),
          buildRating(5, 1),
          MySpacing.height(8),
          buildRating(4, 2),
          MySpacing.height(8),
          buildRating(3, 3),
          MySpacing.height(8),
          buildRating(2, 4),
          MySpacing.height(8),
          buildRating(1, 5),
        ],
      ),
    );
  }

  Widget productList() {
    return controller.searchProduct.isEmpty
        ? Center(child: MyText.bodyMedium("Data not found", fontWeight: 600))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 415),
            shrinkWrap: true,
            itemCount: controller.searchProduct.length,
            itemBuilder: (context, index) {
              ProductModal product = controller.searchProduct[index];
              return SingleCardDetail(productModal: product);
            },
          );
  }
}

class SingleCardDetail extends StatefulWidget {
  final ProductModal productModal;

  const SingleCardDetail({super.key, required this.productModal});

  @override
  State<SingleCardDetail> createState() => _SingleCardDetailState();
}

class _SingleCardDetailState extends State<SingleCardDetail> with UIMixin {
  late ProductModal productModal;
  bool isLiked = false;

  @override
  void initState() {
    productModal = widget.productModal;
    super.initState();
  }

  void onLikeToggle() {
    isLiked = !isLiked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ProductModal product = widget.productModal;
    return MyContainer.bordered(
      onTap: () => Get.offNamed('/app/ecommerce/product_detail'),
      splashColor: Colors.transparent,
      borderRadiusAll: 8,
      paddingAll: 23,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              MyContainer(
                  height: 200,
                  width: double.infinity,
                  borderRadiusAll: 8,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  paddingAll: 0,
                  child: Image.asset(product.image, fit: BoxFit.cover)),
              Positioned(
                right: 8,
                bottom: 8,
                child: MyContainer.rounded(
                  onTap: onLikeToggle,
                  paddingAll: 6,
                  child: Icon(isLiked ? Icons.favorite : Icons.favorite_outline,
                      size: 16),
                ),
              )
            ],
          ),
          MySpacing.height(12),
          MyText.bodyLarge(product.name, fontWeight: 600),
          MySpacing.height(12),
          MyText.bodyMedium("\$${product.price}", fontWeight: 600),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText.bodySmall("Stocks :",
                  fontWeight: 600, overflow: TextOverflow.ellipsis),
              MySpacing.width(4),
              MyText.bodySmall(product.stock.toString(),
                  fontWeight: 600, overflow: TextOverflow.ellipsis),
            ],
          ),
          MySpacing.height(12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyStarRating(
                rating: product.rating,
              ),
              MySpacing.width(4),
              MyText.bodySmall(product.rating.toString(), fontWeight: 600),
            ],
          ),
          MySpacing.height(12),
          MyButton.block(
              elevation: 0,
              borderRadiusAll: 6,
              backgroundColor: contentTheme.primary,
              onPressed: () {},
              child: MyText.bodySmall("Buy Now",
                  overflow: TextOverflow.ellipsis,
                  color: contentTheme.onPrimary,
                  fontWeight: 600))
        ],
      ),
    );
  }
}
