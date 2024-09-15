import 'package:fldc/responsive.dart';
import 'package:fldc/constants/defaults.dart';
import 'package:fldc/navigation/routes.dart';
import 'package:fldc/widgets/header.dart';
import 'package:fldc/widgets/sidemenu/sidebar.dart';
import 'package:fldc/widgets/sidemenu/tab_sidebar.dart';
import 'package:fldc/theme/app_theme.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Responsive.isMobile(context) ? const Sidebar() : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const Sidebar(),
          if (Responsive.isTablet(context)) const TabSidebar(),
          Expanded(
            child: Column(
              children: [
                Header(drawerKey: _drawerKey),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1360),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDefaults.padding *
                              (Responsive.isMobile(context) ? 1 : 1.5),
                        ),
                        child: SafeArea(
                          child: Router(
                            routerDelegate: routerConfig.routerDelegate,
                            routeInformationParser:
                                routerConfig.routeInformationParser,
                            routeInformationProvider:
                                routerConfig.routeInformationProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
