import 'package:flutter/material.dart';
// import '../responsive/breakpoints.dart';
import '../Home-Component/Core/responsive/breakpoints.dart';
// import '../../Data/repositories/dashboard_repository.dart';
import '../Home-Component/Core/Data/models/repositories/dashboard_repository.dart';
// import 'Products/Data/repositories/products_repository.dart';
import '../Products/Data/repositories/products_repository.dart';
// import '../../Home/dashboard_page.dart';
import '../Home-Component/dashboard_page.dart';
import '../../Products/products_page.dart';
// import '../../Data/repositories/vendors_repository.dart';
import 'Data/vendors_repository.dart';
import '../../Vendors/vendors_page.dart';
import '../../SideBar/nav_item.dart';
// import 'placeholder_page.dart';
import '../Home-Component/Core/layout/placeholder_page.dart';
import '../../SideBar/app_sidebar.dart';
import '../../TopBar/top_bar.dart';

/// Responsive layout:
///  - Desktop (>=1100): sidebar expanded (264px), toggle se rail (84px)
///  - Tablet (768-1100): sidebar rail by default, toggle se expand
///  - Mobile (<768): sidebar Drawer ban jata hai
class AppShell extends StatefulWidget {
  final DashboardRepository repository;
  final ProductsRepository productsRepository;
  final VendorsRepository vendorsRepository;
  const AppShell({
    super.key,
    required this.repository,
    required this.productsRepository,
    required this.vendorsRepository,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  NavItem _current = NavItem.overview;
  bool? _userExpanded; // null = screen size ke hisaab se auto

  static const _expandedWidth = 264.0;
  static const _railWidth = 84.0;

  Widget _page() {
    switch (_current) {
      case NavItem.overview:
        return DashboardPage(repository: widget.repository);
      case NavItem.products:
        return ProductsPage(repository: widget.productsRepository);
      case NavItem.vendors:
        return VendorsPage(repository: widget.vendorsRepository);
      default:
        return PlaceholderPage(title: _current.label);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isMobile = c.maxWidth < Breakpoints.mobile;
        final expanded = _userExpanded ?? c.maxWidth >= Breakpoints.desktop;

        Widget sidebar(bool exp, {required bool closeDrawer}) => AppSidebar(
          expanded: exp,
          current: _current,
          onSelect: (i) {
            setState(() => _current = i);
            if (closeDrawer) Navigator.of(context).pop();
          },
          onSettings: () {},
          userName: 'John Doe',
          userEmail: 'john.doe@example.com',
          onProfileTap: () {},
        );

        final content = Column(
          children: [
            TopBar(
              compact: isMobile,
              onMenuTap: () {
                if (isMobile) {
                  _scaffoldKey.currentState?.openDrawer();
                } else {
                  setState(() => _userExpanded = !expanded);
                }
              },
              onScan: () {},
            ),
            Expanded(child: _page()),
          ],
        );

        if (isMobile) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              width: _expandedWidth,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(),
              child: sidebar(true, closeDrawer: true),
            ),
            body: SafeArea(child: content),
          );
        }

        final w = expanded ? _expandedWidth : _railWidth;
        return Scaffold(
          body: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: w,
                // Content hamesha final width pe layout hota hai, animation mein sirf clip hota hai
                child: ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.centerLeft,
                    minWidth: w,
                    maxWidth: w,
                    child: sidebar(expanded, closeDrawer: false),
                  ),
                ),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }
}
