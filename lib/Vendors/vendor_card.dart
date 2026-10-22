import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/utils/format.dart';
import '../Home-Component/Core/utils/format.dart';
// import '../../Core/widgets/app_card.dart';
import '../Home-Component/Core/widgets/app_card.dart';
// import '../../Core/widgets/initials_avatar.dart';
import '../Home-Component/Core/widgets/initials_avatar.dart';
// import '../../Data/models/product.dart';
// import '../Products/Data/models/product.dart';
import '../Home-Component/Core/Data/models/product.dart';
// import '../Products/Data/'
// import '../../Data/models/vendor.dart';
import 'Data/vendor.dart';
import 'vendor_menu.dart';
import 'vendor_status_badge.dart';

class VendorCard extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback onToggleActive;
  final VoidCallback onDelete;

  const VendorCard({
    super.key,
    required this.vendor,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final c = ProductPalette.pick(vendor.name);
    return AppCard(
      padding: const EdgeInsets.fromLTRB(22, 22, 12, 22),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InitialsAvatar(
                  text: vendor.initials,
                  bg: c[0],
                  fg: c[1],
                  circle: true,
                  size: 52,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vendor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${vendor.category} · ${vendor.city}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VendorMenu(
                  isActive: vendor.isActive,
                  onToggleActive: onToggleActive,
                  onDelete: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                VendorStatusBadge(isActive: vendor.isActive),
                if (vendor.pendingOrders > 0)
                  _PendingChip(count: vendor.pendingOrders),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 14),
            _InfoRow(icon: Icons.person_outline, text: vendor.contactPerson),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.phone_outlined, text: vendor.phone),
            if (vendor.email.isNotEmpty) ...[
              const SizedBox(height: 8),
              _InfoRow(icon: Icons.mail_outline, text: vendor.email),
            ],
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _Money(
                    label: 'Total purchased',
                    value: formatRs(vendor.totalPurchased),
                  ),
                ),
                Expanded(
                  child: _Money(
                    label: 'Outstanding',
                    value: formatRs(vendor.outstanding),
                    color: vendor.outstanding > 0 ? AppColors.danger : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Last order: ${vendor.lastOrderLabel}',
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingChip extends StatelessWidget {
  final int count;
  const _PendingChip({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0C9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count pending',
        style: const TextStyle(
          color: Color(0xFFB7791F),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.muted),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class _Money extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _Money({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
