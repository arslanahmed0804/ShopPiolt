const kVendorCategories = [
  'Grocery',
  'Dairy',
  'Beverages',
  'Snacks',
  'Cleaning',
  'Personal care',
  'General',
];

class Vendor {
  final String id;
  final String name;
  final String contactPerson;
  final String phone;
  final String email;
  final String city;
  final String category;
  final bool isActive;
  final int pendingOrders;
  final double totalPurchased;
  final double outstanding;
  final String lastOrderLabel;

  const Vendor({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.phone,
    this.email = '',
    required this.city,
    required this.category,
    this.isActive = true,
    this.pendingOrders = 0,
    this.totalPurchased = 0,
    this.outstanding = 0,
    this.lastOrderLabel = 'No orders yet',
  });

  String get initials {
    final p = name.split(' ').where((e) => e.isNotEmpty).toList();
    if (p.length == 1) return p[0][0].toUpperCase();
    return (p[0][0] + p[1][0]).toUpperCase();
  }

  Vendor copyWith({bool? isActive}) => Vendor(
        id: id,
        name: name,
        contactPerson: contactPerson,
        phone: phone,
        email: email,
        city: city,
        category: category,
        isActive: isActive ?? this.isActive,
        pendingOrders: pendingOrders,
        totalPurchased: totalPurchased,
        outstanding: outstanding,
        lastOrderLabel: lastOrderLabel,
      );
}