// import 'package:flutter/material.dart';
// import 'package:shoppilot/Bill/Data/billing_repository.dart';
// import 'package:shoppilot/Bill/billing_page.dart';
// import 'package:shoppilot/Home-Component/Core/Data/models/repositories/dashboard_repository.dart';
// import 'package:shoppilot/Home-Component/Core/layout/placeholder_page.dart';
// import 'package:shoppilot/Home-Component/Core/responsive/breakpoints.dart';
// import 'package:shoppilot/Home-Component/dashboard_page.dart';
// import 'package:shoppilot/models/auth_user.dart';
// import 'package:shoppilot/Products/Data/repositories/products_repository.dart';
// import 'package:shoppilot/Products/low/add_product_form.dart';
// import 'package:shoppilot/Products/products_page.dart';
// import 'package:shoppilot/SideBar/app_sidebar.dart';
// import 'package:shoppilot/SideBar/nav_item.dart';
// import 'package:shoppilot/TopBar/top_bar.dart';
// import 'package:shoppilot/Vendors/Data/vendors_repository.dart';
// import 'package:shoppilot/Vendors/vendors_page.dart';

// /// Responsive layout:
// ///  - Desktop (>=1100): sidebar expanded (264px), toggle se rail (84px)
// ///  - Tablet (768-1100): sidebar rail by default, toggle se expand
// ///  - Mobile (<768): sidebar Drawer ban jata hai
// class AppShell extends StatefulWidget {
//   final DashboardRepository repository;
//   final ProductsRepository productsRepository;
//   final VendorsRepository vendorsRepository;
//   final BillingRepository billingRepository;
//   final AuthUser user;
//   final VoidCallback onLogout;
//   final VoidCallback? onSettings;
//   final VoidCallback? onScan;

//   const AppShell({
//     super.key,
//     required this.repository,
//     required this.productsRepository,
//     required this.vendorsRepository,
//     required this.billingRepository,
//     required this.user,
//     required this.onLogout,
//     this.onSettings,
//     this.onScan,
//   });

//   @override
//   State<AppShell> createState() => _AppShellState();
// }

// class _AppShellState extends State<AppShell> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   NavItem _current = NavItem.overview;
//   bool? _userExpanded; // null = screen size ke hisaab se auto

//   static const _expandedWidth = 264.0;
//   static const _railWidth = 84.0;

//   Future<void> _addProduct() async {
//     try {
//       final vendors = await widget.vendorsRepository.fetchVendors();
//       if (!mounted) return;

//       final product = await AddProductDialog.show(
//         context,
//         vendors
//             .where((vendor) => vendor.isActive)
//             .map((vendor) => vendor.name)
//             .toList(),
//       );
//       if (product == null) return;

//       await widget.productsRepository.addProduct(product);
//       if (!mounted) return;

//       ScaffoldMessenger.of(context)
//         ..hideCurrentSnackBar()
//         ..showSnackBar(
//           SnackBar(
//             content: Text('${product.name} added'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//     } catch (error) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context)
//         ..hideCurrentSnackBar()
//         ..showSnackBar(
//           SnackBar(
//             content: Text('Could not add product: $error'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//     }
//   }

//   void _showUnavailableAction(String action) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           content: Text('$action is not configured yet'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//   }

//   Future<void> _confirmLogout() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//         title: const Text('Log out?'),
//         content: Text('You are signed in as ${widget.user.email}.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, true),
//             child: const Text(
//               'Log out',
//               style: TextStyle(color: Color(0xFFD95A38)),
//             ),
//           ),
//         ],
//       ),
//     );
//     if (confirmed == true) widget.onLogout();
//   }

//   Widget _page() {
//     switch (_current) {
//       case NavItem.overview:
//         return DashboardPage(
//           repository: widget.repository,
//           onAddProduct: _addProduct,
//         );
//       case NavItem.products:
//         return ProductsPage(repository: widget.productsRepository);
//       case NavItem.vendors:
//         return VendorsPage(repository: widget.vendorsRepository);
//       case NavItem.bill:
//         return BillingPage(
//           productsRepository: widget.productsRepository,
//           billingRepository: widget.billingRepository,
//         );
//       default:
//         return PlaceholderPage(title: _current.label);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, c) {
//         final isMobile = c.maxWidth < Breakpoints.mobile;
//         final expanded = _userExpanded ?? c.maxWidth >= Breakpoints.desktop;

//         Widget sidebar(bool exp, {required bool closeDrawer}) => AppSidebar(
//           expanded: exp,
//           current: _current,
//           onSelect: (i) {
//             setState(() => _current = i);
//             if (closeDrawer) _scaffoldKey.currentState?.closeDrawer();
//           },
//           onSettings: widget.onSettings ?? () => _showUnavailableAction('Settings'),
//           userName: widget.user.name,
//           userEmail: widget.user.email,
//           onProfileTap: _confirmLogout,
//         );

//         final content = Column(
//           children: [
//             TopBar(
//               compact: isMobile,
//               onMenuTap: () {
//                 if (isMobile) {
//                   _scaffoldKey.currentState?.openDrawer();
//                 } else {
//                   setState(() => _userExpanded = !expanded);
//                 }
//               },
//               onScan: widget.onScan ?? () => _showUnavailableAction('Product scanning'),
//             ),
//             Expanded(child: _page()),
//           ],
//         );

//         if (isMobile) {
//           return Scaffold(
//             key: _scaffoldKey,
//             drawer: Drawer(
//               width: _expandedWidth,
//               backgroundColor: Colors.transparent,
//               shape: const RoundedRectangleBorder(),
//               child: sidebar(true, closeDrawer: true),
//             ),
//             body: SafeArea(child: content),
//           );
//         }

//         final w = expanded ? _expandedWidth : _railWidth;
//         return Scaffold(
//           body: Row(
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 curve: Curves.easeOutCubic,
//                 width: w,
//                 // Content hamesha final width pe layout hota hai, animation mein sirf clip hota hai
//                 child: ClipRect(
//                   child: OverflowBox(
//                     alignment: Alignment.centerLeft,
//                     minWidth: w,
//                     maxWidth: w,
//                     child: sidebar(expanded, closeDrawer: false),
//                   ),
//                 ),
//               ),
//               Expanded(child: content),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shoppilot/Bill/Data/billing_repository.dart';
import 'package:shoppilot/Bill/billing_page.dart';
import 'package:shoppilot/Home-Component/Core/Data/models/repositories/dashboard_repository.dart';
import 'package:shoppilot/Home-Component/Core/layout/placeholder_page.dart';
import 'package:shoppilot/Home-Component/Core/responsive/breakpoints.dart';
import 'package:shoppilot/Home-Component/dashboard_page.dart';
import 'package:shoppilot/models/auth_user.dart';
import 'package:shoppilot/Products/Data/repositories/products_repository.dart';
import 'package:shoppilot/Products/low/add_product_form.dart';
import 'package:shoppilot/Products/products_page.dart';
import 'package:shoppilot/SideBar/app_sidebar.dart';
import 'package:shoppilot/SideBar/nav_item.dart';
import 'package:shoppilot/TopBar/top_bar.dart';
import 'package:shoppilot/Vendors/Data/vendors_repository.dart';
import 'package:shoppilot/Vendors/vendors_page.dart';

/// Responsive layout:
///  - Desktop (>=1100): sidebar expanded (264px), toggle se rail (84px)
///  - Tablet (768-1100): sidebar rail by default, toggle se expand
///  - Mobile (<768): sidebar Drawer ban jata hai
class AppShell extends StatefulWidget {
  final DashboardRepository repository;
  final ProductsRepository productsRepository;
  final VendorsRepository vendorsRepository;
  final BillingRepository billingRepository;
  final AuthUser user;
  final VoidCallback onLogout;
  final VoidCallback? onSettings;
  final VoidCallback? onScan;

  const AppShell({
    super.key,
    required this.repository,
    required this.productsRepository,
    required this.vendorsRepository,
    required this.billingRepository,
    required this.user,
    required this.onLogout,
    this.onSettings,
    this.onScan,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  NavItem _current = NavItem.overview;
  bool? _userExpanded; // null = screen size ke hisaab se auto

  /// Data badalne par (jaise naya product) isse badhao: Overview / Products
  /// pages naye key ke saath dobara bante hain aur fresh data fetch karte hain.
  int _dataVersion = 0;
  bool _addingProduct = false; // double-tap guard

  static const _expandedWidth = 264.0;
  static const _railWidth = 84.0;

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _addProduct() async {
    if (_addingProduct) return;
    _addingProduct = true;
    try {
      final vendors = await widget.vendorsRepository.fetchVendors();
      if (!mounted) return;

      final product = await AddProductDialog.show(
        context,
        vendors
            .where((vendor) => vendor.isActive)
            .map((vendor) => vendor.name)
            .toList(),
      );
      if (product == null) return;

      await widget.productsRepository.addProduct(product);
      if (!mounted) return;

      // Dashboard counts aur Products list dono refresh ho jayen
      setState(() => _dataVersion++);
      _toast('${product.name} added');
    } catch (error) {
      _toast('Could not add product: $error');
    } finally {
      _addingProduct = false;
    }
  }

  void _showUnavailableAction(String action) =>
      _toast('$action is not configured yet');

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Log out?'),
        content: Text('You are signed in as ${widget.user.email}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Log out',
              style: TextStyle(color: Color(0xFFD95A38)),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onLogout();
  }

  Widget _page() {
    switch (_current) {
      case NavItem.overview:
        return DashboardPage(
          key: ValueKey('overview-$_dataVersion'),
          repository: widget.repository,
          onAddProduct: _addProduct,
        );
      case NavItem.products:
        return ProductsPage(
          key: ValueKey('products-$_dataVersion'),
          repository: widget.productsRepository,
        );
      case NavItem.vendors:
        return VendorsPage(repository: widget.vendorsRepository);
      case NavItem.bill:
        return BillingPage(
          productsRepository: widget.productsRepository,
          billingRepository: widget.billingRepository,
        );
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
            if (closeDrawer) _scaffoldKey.currentState?.closeDrawer();
          },
          onSettings: () {
            if (closeDrawer) _scaffoldKey.currentState?.closeDrawer();
            (widget.onSettings ?? () => _showUnavailableAction('Settings'))();
          },
          userName: widget.user.name,
          userEmail: widget.user.email,
          onProfileTap: () {
            // Mobile par pehle drawer band karo, phir dialog dikhao
            if (closeDrawer) _scaffoldKey.currentState?.closeDrawer();
            _confirmLogout();
          },
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
              onScan: widget.onScan ??
                  () => _showUnavailableAction('Product scanning'),
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