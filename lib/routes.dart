import 'package:fldc/helpers/services/auth_service.dart';
import 'package:fldc/pages/Dashboard/Dashboard_Airline.dart';
import 'package:fldc/pages/HomeScreen.dart';
import 'package:fldc/pages/Map/MapPage.dart';
import 'package:fldc/view/apps/calendar/calendar_screen.dart';
import 'package:fldc/view/apps/chat_screen.dart';
import 'package:fldc/view/apps/contact/member_list_screen.dart';
import 'package:fldc/view/apps/contact/profile_screen.dart';
import 'package:fldc/view/apps/ecommerce/add_product_screen.dart';
import 'package:fldc/view/apps/ecommerce/product_detail_screen.dart';
import 'package:fldc/view/apps/ecommerce/products_grid_screen.dart';
import 'package:fldc/view/apps/ecommerce/review_screen.dart';
import 'package:fldc/view/apps/file/file_manager_screen.dart';
import 'package:fldc/view/apps/job/job_detail_screen.dart';
import 'package:fldc/view/apps/job/job_list_screen.dart';
import 'package:fldc/view/apps/kanban_board_screen.dart';
import 'package:fldc/view/apps/pos_screen.dart';
import 'package:fldc/view/auth/forgot_password_screen.dart' as forgot_password;
import 'package:fldc/view/auth_2/forgot_password_screen.dart'
    as forgot_password2;
import 'package:fldc/view/auth/login_screen.dart' as auth;
import 'package:fldc/view/auth_2/login_screen.dart' as auth2;
import 'package:fldc/view/auth/reset_password_screen.dart' as reset_password;
import 'package:fldc/view/auth_2/reset_password_screen.dart' as reset_password2;
import 'package:fldc/view/auth/sign_up_screen.dart' as sign_up;
import 'package:fldc/view/auth_2/sign_up_screen.dart' as sign_up2;
import 'package:fldc/view/dashboard/analytics_screen.dart';
import 'package:fldc/view/dashboard/crm_screen.dart';
import 'package:fldc/view/dashboard/ecommerce_screen.dart';
import 'package:fldc/view/dashboard/food_screen.dart';
import 'package:fldc/view/dashboard/job_screen.dart';
import 'package:fldc/view/dashboard/nft_screen.dart';
import 'package:fldc/view/dashboard/real_estate_screen.dart';
import 'package:fldc/view/error_pages/coming_soon_screen.dart';
import 'package:fldc/view/error_pages/error_404_screen.dart';
import 'package:fldc/view/error_pages/error_500_screen.dart';
import 'package:fldc/view/extra_pages/faqs_screen.dart';
import 'package:fldc/view/extra_pages/pricing_screen.dart';
import 'package:fldc/view/extra_pages/time_line_screen.dart';
import 'package:fldc/view/forms/basic_input_screen.dart';
import 'package:fldc/view/forms/custom_option_screen.dart';
import 'package:fldc/view/forms/editor_screen.dart';
import 'package:fldc/view/forms/file_upload_screen.dart';
import 'package:fldc/view/forms/mask_screen.dart';
import 'package:fldc/view/forms/slider_screen.dart';
import 'package:fldc/view/forms/validation_screen.dart';
import 'package:fldc/view/other/basic_table_screen.dart';
import 'package:fldc/view/other/map_screen.dart';
import 'package:fldc/view/other/syncfusion_chart_screen.dart';
import 'package:fldc/view/ui/buttons_screen.dart';
import 'package:fldc/view/ui/cards_screen.dart';
import 'package:fldc/view/ui/carousels_screen.dart';
import 'package:fldc/view/ui/dialogs_screen.dart';
import 'package:fldc/view/ui/drag_n_drop_screen.dart';
import 'package:fldc/view/ui/loaders_screen.dart';
import 'package:fldc/view/ui/modal_screen.dart';
import 'package:fldc/view/ui/notification_screen.dart';
import 'package:fldc/view/ui/tabs_screen.dart';
import 'package:fldc/view/ui/toast_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(name: '/auth/login', page: () => auth.LoginScreen()),
    GetPage(name: '/auth_2/login', page: () => auth2.LoginScreen()),
    GetPage(
        name: '/auth/forgot_password',
        page: () => forgot_password.ForgotPasswordScreen()),
    GetPage(
        name: '/auth_2/forgot_password',
        page: () => forgot_password2.ForgotPasswordScreen()),
    GetPage(
        name: '/auth/reset_password',
        page: () => reset_password.ResetPasswordScreen()),
    GetPage(
        name: '/auth_2/reset_password',
        page: () => reset_password2.ResetPasswordScreen()),
    GetPage(name: '/auth/register_account', page: () => sign_up.SignUpScreen()),
    GetPage(
        name: '/auth_2/register_account', page: () => sign_up2.SignUpScreen()),
    GetPage(
      name: '/',
      page: () => Homescreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/map',
      page: () => MapPage(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard',
      page: () => DashboardAirline(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/analytics',
      page: () => AnalyticsScreen(),
      //middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/dashboard/nft_dashboard',
      page: () => NFTScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/ecommerce',
      page: () => EcommerceScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/crm',
      page: () => CRMScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/job',
      page: () => JobScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/food',
      page: () => FoodScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard/real_estate',
      page: () => RealEstateScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/toast',
      page: () => ToastMessageScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/buttons',
      page: () => ButtonsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/modal',
      page: () => ModalScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/tabs',
      page: () => TabsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/cards',
      page: () => CardsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/loader',
      page: () => LoadersScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/dialog',
      page: () => DialogsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/carousel',
      page: () => CarouselsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/drag_n_drop',
      page: () => DragNDropScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/widget/notification',
      page: () => NotificationScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/basic_input',
      page: () => BasicInputScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/custom_option',
      page: () => CustomOptionScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/editor',
      page: () => EditorScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/file_upload',
      page: () => FileUploadScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/slider',
      page: () => SliderScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/validation',
      page: () => ValidationScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/mask',
      page: () => MaskScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/calendar',
      page: () => CalendarScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/chat',
      page: () => ChatScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/contact/member_list',
      page: () => MemberListScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/contact/profile',
      page: () => ProfileScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/ecommerce/products_grid',
      page: () => ProductsGridScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/ecommerce/add_product',
      page: () => AddProductScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/ecommerce/product_detail',
      page: () => ProductDetailScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/ecommerce/review',
      page: () => ReviewScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/file_manager',
      page: () => FileManagerScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/kanban_board',
      page: () => KanBanBoardScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/pos',
      page: () => PosScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/error/coming_soon',
      page: () => ComingSoonScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/error/500',
      page: () => Error500Screen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/error/404',
      page: () => Error404Screen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/extra/time_line',
      page: () => TimeLineScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/extra/pricing',
      page: () => PricingScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/extra/faqs',
      page: () => FaqsScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/basic_table',
      page: () => BasicTableScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/map',
      page: () => MapScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/syncfusion_chart',
      page: () => SyncFusionChartScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/job_list',
      page: () => JobListScreen(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/app/job_detail',
      page: () => JobDetailScreen(),
      //middlewares: [AuthMiddleware()],
    ),
  ];
  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
