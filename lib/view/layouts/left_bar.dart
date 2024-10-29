import 'package:fldc/helpers/extensions/string.dart';
import 'package:fldc/helpers/services/url_service.dart';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/theme/theme_customizer.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 60 : 250,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/dashboard/analytics');
                    },
                    child: widget.isCondensed
                        ? SvgPicture.asset(
                            Images.logoSmSvg,
                            height: 28,
                          )
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Images.logoSmSvg,
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "FlyLat",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "DataCenter",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                controller: ScrollController(),
                physics: BouncingScrollPhysics(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  labelWidget("dashboard".tr()),
                  NavigationItem(
                    iconData: LucideIcons.layout_dashboard,
                    title: "Analytics",
                    isCondensed: isCondensed,
                    route: '/dashboard/analytics',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.bitcoin,
                    title: "NFT",
                    isCondensed: isCondensed,
                    route: '/dashboard/nft_dashboard',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.warehouse,
                    title: "eCommerce",
                    isCondensed: isCondensed,
                    route: '/dashboard/ecommerce',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.heart_handshake,
                    title: "CRM",
                    isCondensed: isCondensed,
                    route: '/dashboard/crm',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.construction,
                    title: "Job",
                    isCondensed: isCondensed,
                    route: '/dashboard/job',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.chef_hat,
                    title: "Food",
                    isCondensed: isCondensed,
                    route: '/dashboard/food',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.building_2,
                    title: "Real Estate",
                    isCondensed: isCondensed,
                    route: '/dashboard/real_estate',
                  ),
                  labelWidget("apps".tr()),
                  MenuWidget(
                    iconData: LucideIcons.users,
                    isCondensed: isCondensed,
                    title: "Contact",
                    children: [
                      MenuItem(
                        title: 'Member List',
                        route: '/app/contact/member_list',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Profile',
                        route: '/app/contact/profile',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.shopping_cart,
                    isCondensed: isCondensed,
                    title: "Ecommerce",
                    children: [
                      MenuItem(
                        title: 'Product Grid',
                        route: '/app/ecommerce/products_grid',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Add Product',
                        route: '/app/ecommerce/add_product',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Product Detail',
                        route: '/app/ecommerce/product_detail',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Review',
                        route: '/app/ecommerce/review',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.baggage_claim,
                    isCondensed: isCondensed,
                    title: "Job",
                    children: [
                      MenuItem(
                        title: 'List',
                        route: '/app/job_list',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Detail',
                        route: '/app/job_detail',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  NavigationItem(
                    iconData: LucideIcons.calendar_range,
                    title: "Calendar",
                    isCondensed: isCondensed,
                    route: '/app/calendar',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.message_square,
                    title: "Chat",
                    isCondensed: isCondensed,
                    route: '/app/chat',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.folder_closed,
                    title: "File Manager",
                    isCondensed: isCondensed,
                    route: '/app/file_manager',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.folder_kanban,
                    title: "Kanban",
                    isCondensed: isCondensed,
                    route: '/app/kanban_board',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.shopping_bag,
                    title: "POS",
                    isCondensed: isCondensed,
                    route: '/app/pos',
                  ),
                  labelWidget("pages".tr()),
                  MenuWidget(
                    iconData: LucideIcons.key_round,
                    isCondensed: isCondensed,
                    title: "Auth",
                    children: [
                      MenuItem(
                        title: 'Login',
                        route: '/auth/login',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Register Password',
                        route: '/auth/register_account',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Forgot Password',
                        route: '/auth/forgot_password',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Reset Password',
                        route: '/auth/reset_password',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.key_round,
                    isCondensed: isCondensed,
                    title: "Auth 2",
                    children: [
                      MenuItem(
                        title: 'Login 2',
                        route: '/auth_2/login',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Forgot Password 2',
                        route: '/auth_2/forgot_password',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                          title: 'Reset Password 2',
                          route: '/auth_2/reset_password',
                          isCondensed: widget.isCondensed),
                      MenuItem(
                          title: 'Register Account 2',
                          route: '/auth_2/register_account',
                          isCondensed: widget.isCondensed),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.component,
                    isCondensed: isCondensed,
                    title: "Widgets",
                    children: [
                      MenuItem(
                        title: "Buttons",
                        route: '/widget/buttons',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Toast",
                        route: '/widget/toast',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Modal",
                        route: '/widget/modal',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Tabs",
                        route: '/widget/tabs',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Cards",
                        route: '/widget/cards',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Loaders",
                        route: '/widget/loader',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Dialog",
                        route: '/widget/dialog',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Carousels",
                        route: '/widget/carousel',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Drag & Drop",
                        route: '/widget/drag_n_drop',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Notifications",
                        route: '/widget/notification',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.book_open_check,
                    title: "Form",
                    isCondensed: isCondensed,
                    children: [
                      MenuItem(
                        title: "Basic Input",
                        route: '/form/basic_input',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Custom Option",
                        route: '/form/custom_option',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Editor",
                        route: '/form/editor',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "File Upload",
                        route: '/form/file_upload',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Slider",
                        route: '/form/slider',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Validation",
                        route: '/form/validation',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Mask",
                        route: '/form/mask',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.shield_alert,
                    isCondensed: isCondensed,
                    title: "Error",
                    children: [
                      MenuItem(
                        title: 'Error 404',
                        route: '/error/404',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Error 500',
                        route: '/error/500',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Coming Soon',
                        route: '/error/coming_soon',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.book_open_check,
                    isCondensed: isCondensed,
                    title: "Extra Pages",
                    children: [
                      MenuItem(
                        title: 'FAQs',
                        route: '/extra/faqs',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Pricing',
                        route: '/extra/pricing',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: 'Time Line',
                        route: '/extra/time_line',
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  labelWidget("other".tr()),
                  NavigationItem(
                    iconData: LucideIcons.table,
                    title: "Basic Table",
                    isCondensed: isCondensed,
                    route: '/other/basic_table',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.map,
                    title: "Map",
                    isCondensed: isCondensed,
                    route: '/other/map',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.chart_bar,
                    title: "Syncfusion",
                    isCondensed: isCondensed,
                    route: '/other/syncfusion_chart',
                  ),
                  MySpacing.height(20),
                  if (!isCondensed)
                    InkWell(
                      onTap: () {
                        UrlService.goToPagger();
                      },
                      child: Padding(
                          padding: MySpacing.x(16),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    8), // color: contentTheme.primary.withAlpha(40),
                                gradient: LinearGradient(
                                    colors: const [
                                      Colors.deepPurple,
                                      Colors.lightBlue
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white.withAlpha(32),
                                  ),
                                  child: Icon(LucideIcons.layout_dashboard,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                MyText.bodyLarge(
                                  "Ready to use page for any Flutter Project",
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  child: MyText.bodyMedium(
                                    "Free Download",
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  if (isCondensed)
                    InkWell(
                      onTap: () {
                        UrlService.goToPagger();
                      },
                      child: Padding(
                          padding: MySpacing.x(12),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    4), // color: contentTheme.primary.withAlpha(40),
                                gradient: LinearGradient(
                                    colors: const [
                                      Colors.deepPurple,
                                      Colors.lightBlue
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            child: Center(
                              child: Icon(
                                LucideIcons.download,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                  MySpacing.height(20),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final String? route;
  final List<MenuItem> children;

  const MenuWidget({
    super.key,
    required this.iconData,
    required this.title,
    this.isCondensed = false,
    this.active = false,
    this.children = const [],
    this.route,
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (value) {
          popupShowing = value;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },

          /// Small Side Bar
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(4, 0, 8, 8),
            borderRadiusAll: 8,
            padding: MySpacing.xy(0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyContainer(
                  height: 26,
                  width: 6,
                  paddingAll: 0,
                  color: isActive || isHover
                      ? leftBarTheme.activeItemColor
                      : Colors.transparent,
                ),
                MySpacing.width(12),
                Icon(
                  widget.iconData,
                  color: (isHover || isActive)
                      ? leftBarTheme.activeItemColor
                      : leftBarTheme.onBackground,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer(
          borderRadiusAll: 8,
          paddingAll: 8,
          width: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (value) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(value);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevron_down,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Large Side Bar
                    MyContainer(
                      height: 26,
                      width: 5,
                      paddingAll: 0,
                      color: isActive || isHover
                          ? leftBarTheme.activeItemColor
                          : Colors.transparent,
                    ),
                    MySpacing.width(12),
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;
  final List<MenuItem> childrenMenuWidget;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
    this.childrenMenuWidget = const [],
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive =
        widget.childrenMenuWidget.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    if (widget.childrenMenuWidget.isEmpty) {
      return GestureDetector(
        onTap: () {
          if (widget.route != null) {
            Get.toNamed(widget.route!);
            // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(4, 0, 8, 4),
            borderRadiusAll: 8,
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            width: MediaQuery.of(context).size.width,
            padding: MySpacing.xy(18, 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.dot,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground),
                MyText.bodySmall(
                  "${widget.title}",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  fontSize: 12.5,
                  color: isActive || isHover
                      ? leftBarTheme.activeItemColor
                      : leftBarTheme.onBackground,
                  fontWeight: isActive || isHover ? 600 : 500,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (value) {
          popupShowing = value;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer(
          borderRadiusAll: 8,
          paddingAll: 8,
          width: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.childrenMenuWidget,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          borderRadiusAll: 8,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (value) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(value);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevron_down,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.childrenMenuWidget),
          ),
        ),
      );
    }
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem(
      {super.key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route});

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 8),
          borderRadiusAll: 8,
          padding: MySpacing.xy(0, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyContainer(
                height: 26,
                width: 6,
                paddingAll: 0,
                color: isActive || isHover
                    ? leftBarTheme.activeItemColor
                    : Colors.transparent,
              ),
              MySpacing.width(12),
              if (widget.iconData != null)
                Center(
                  child: Icon(widget.iconData,
                      color: (isHover || isActive)
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                      size: 20),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
