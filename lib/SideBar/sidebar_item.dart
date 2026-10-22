import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool expanded;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = selected ? AppColors.ink : AppColors.sidebarMuted;
    final tile = Material(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: expanded ? 16 : 0),
          alignment: expanded ? Alignment.centerLeft : Alignment.center,
          child: expanded
              ? Row(children: [
                  Icon(icon, color: fg, size: 22),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: fg, fontSize: 17, fontWeight: FontWeight.w500)),
                  ),
                ])
              : Icon(icon, color: fg, size: 22),
        ),
      ),
    );
    return expanded ? tile : Tooltip(message: label, child: tile);
  }
}