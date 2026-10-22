import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class SidebarProfileTile extends StatelessWidget {
  final String name;
  final String role;
  final String initials;
  final bool expanded;
  final VoidCallback? onTap;

  const SidebarProfileTile({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.expanded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color(0xFFE2704C), shape: BoxShape.circle),
      child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: expanded
            ? Row(children: [
                avatar,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    Text(role, style: const TextStyle(color: AppColors.sidebarMuted, fontSize: 13)),
                  ]),
                ),
                const Icon(Icons.chevron_right, color: Colors.white),
              ])
            : Center(child: avatar),
      ),
    );
  }
}