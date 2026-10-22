// import 'package:flutter/material.dart';
// import '../Home-Component/Core/theme/app_colors.dart';
// import 'nav_item.dart';
// import 'cloud_sync_card.dart';
// import 'sidebar_item.dart';
// import 'sidebar_profile_tile.dart';

// /// Pure presentational sidebar. Open/close ka decision AppShell leta hai.
// class AppSidebar extends StatelessWidget {
//   final bool expanded;
//   final NavItem current;
//   final ValueChanged<NavItem> onSelect;
//   final VoidCallback onLogout;

//   const AppSidebar({
//     super.key,
//     required this.expanded,
//     required this.current,
//     required this.onSelect,
//     required this.onLogout,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.sidebar,
//       padding: EdgeInsets.symmetric(horizontal: expanded ? 24 : 16, vertical: 24),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _Brand(expanded: expanded),
//             const SizedBox(height: 28),
//             if (expanded)
//               const Padding(
//                 padding: EdgeInsets.only(left: 8, bottom: 14),
//                 child: Text('WORKSPACE',
//                     style: TextStyle(color: AppColors.sidebarMuted, letterSpacing: 2.4, fontSize: 12, fontWeight: FontWeight.w600)),
//               ),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   for (final item in NavItem.values)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: SidebarItem(
//                         icon: item.icon,
//                         label: item.label,
//                         selected: item == current,
//                         expanded: expanded,
//                         onTap: () => onSelect(item),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             if (expanded) ...[const CloudSyncCard(), const SizedBox(height: 16)],
//             SidebarItem(
//               icon: Icons.logout_outlined,
//               label: 'Logout',
//               selected: false,
//               expanded: expanded,
//               onTap: onLogout,
//             ),
//             const Divider(color: Color(0xFF24433A), height: 28),
//             SidebarProfileTile(
//               name: "Ahmed's Mart",
//               role: 'Owner account',
//               initials: 'AH',
//               expanded: expanded,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Brand extends StatelessWidget {
//   final bool expanded;
//   const _Brand({required this.expanded});

//   @override
//   Widget build(BuildContext context) {
//     final logo = Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(16)),
//       child: const Icon(Icons.qr_code_scanner, color: AppColors.dark),
//     );
//     if (!expanded) return Center(child: logo);
//     return Row(children: [
//       logo,
//       const SizedBox(width: 14),
//       const Expanded(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('Stockwise', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
//           Text('Smart inventory', style: TextStyle(color: AppColors.sidebarMuted, fontSize: 13)),
//         ]),
//       ),
//     ]);
//   }
// }
import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import 'nav_item.dart';
import 'cloud_sync_card.dart';
import 'sidebar_item.dart';
import 'sidebar_profile_tile.dart';

/// Pure presentational sidebar. Open/close ka decision AppShell leta hai.
class AppSidebar extends StatelessWidget {
  final bool expanded;
  final NavItem current;
  final ValueChanged<NavItem> onSelect;
  final VoidCallback onSettings;
  final String userName;
  final String userEmail;
  final VoidCallback onProfileTap;

  const AppSidebar({
    super.key,
    required this.expanded,
    required this.current,
    required this.onSelect,
    required this.onSettings,
    required this.userName,
    required this.userEmail,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebar,
      padding: EdgeInsets.symmetric(horizontal: expanded ? 24 : 16, vertical: 24),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Brand(expanded: expanded),
            const SizedBox(height: 28),
            if (expanded)
              const Padding(
                padding: EdgeInsets.only(left: 8, bottom: 14),
                child: Text('WORKSPACE',
                    style: TextStyle(color: AppColors.sidebarMuted, letterSpacing: 2.4, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final item in NavItem.values)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SidebarItem(
                        icon: item.icon,
                        label: item.label,
                        selected: item == current,
                        expanded: expanded,
                        onTap: () => onSelect(item),
                      ),
                    ),
                ],
              ),
            ),
            if (expanded) ...[const CloudSyncCard(), const SizedBox(height: 16)],
            SidebarItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              selected: false,
              expanded: expanded,
              onTap: onSettings,
            ),
            const Divider(color: Color(0xFF24433A), height: 28),
            SidebarProfileTile(
              name: userName,
              role: userEmail,
              initials: _initials(userName),
              expanded: expanded,
              onTap: onProfileTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  final bool expanded;
  const _Brand({required this.expanded});

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.qr_code_scanner, color: AppColors.dark),
    );
    if (!expanded) return Center(child: logo);
    return Row(children: [
      logo,
      const SizedBox(width: 14),
      const Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Stockwise', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          Text('Smart inventory', style: TextStyle(color: AppColors.sidebarMuted, fontSize: 13)),
        ]),
      ),
    ]);
  }
}

String _initials(String name) {
  final p = name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
  if (p.isEmpty) return '?';
  if (p.length == 1) return p[0][0].toUpperCase();
  return (p[0][0] + p[1][0]).toUpperCase();
}