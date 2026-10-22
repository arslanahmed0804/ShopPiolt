// import '../models/vendor.dart';
import '../Data/vendor.dart';

/// Vendors page sirf is interface se baat karti hai.
/// Backend ke waqt ApiVendorsRepository banao aur main.dart mein swap karo.
abstract class VendorsRepository {
  Future<List<Vendor>> fetchVendors();
  Future<Vendor> addVendor(Vendor vendor);
  Future<void> setActive(String id, bool isActive);
  Future<void> deleteVendor(String id);
}

class MockVendorsRepository implements VendorsRepository {
  final List<Vendor> _items = _seed();

  @override
  Future<List<Vendor>> fetchVendors() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_items);
  }

  @override
  Future<Vendor> addVendor(Vendor vendor) async {
    _items.insert(0, vendor);
    return vendor;
  }

  @override
  Future<void> setActive(String id, bool isActive) async {
    final i = _items.indexWhere((v) => v.id == id);
    if (i != -1) _items[i] = _items[i].copyWith(isActive: isActive);
  }

  @override
  Future<void> deleteVendor(String id) async {
    _items.removeWhere((v) => v.id == id);
  }

  static List<Vendor> _seed() => const [
        Vendor(id: '1', name: 'Metro Wholesale', contactPerson: 'Imran Qureshi', phone: '0300 1234567',
            email: 'orders@metro.pk', city: 'Karachi', category: 'Grocery', pendingOrders: 1,
            totalPurchased: 842500, outstanding: 18450, lastOrderLabel: 'Today, 10:24 AM'),
        Vendor(id: '2', name: 'Fazal Traders', contactPerson: 'Fazal Ahmed', phone: '0321 7654321',
            email: 'fazal@traders.pk', city: 'Lahore', category: 'Beverages', pendingOrders: 1,
            totalPurchased: 421300, outstanding: 9820, lastOrderLabel: 'Yesterday, 4:12 PM'),
        Vendor(id: '3', name: 'Prime Distributors', contactPerson: 'Sana Malik', phone: '0333 9988776',
            email: 'sales@prime.pk', city: 'Karachi', category: 'Snacks', pendingOrders: 1,
            totalPurchased: 612900, outstanding: 27300, lastOrderLabel: '12 Oct, 1:05 PM'),
        Vendor(id: '4', name: 'Nestle Pakistan Depot', contactPerson: 'Kamran Ali', phone: '0345 2211003',
            email: 'depot@nestle.pk', city: 'Hyderabad', category: 'Dairy',
            totalPurchased: 1204000, lastOrderLabel: '9 Oct, 11:30 AM'),
        Vendor(id: '5', name: 'Unilever Care Supply', contactPerson: 'Hina Raza', phone: '0312 4455667',
            email: 'care@unilever-supply.pk', city: 'Karachi', category: 'Personal care',
            totalPurchased: 389700, outstanding: 5400, lastOrderLabel: '7 Oct, 3:45 PM'),
        Vendor(id: '6', name: 'Al-Madina Cash & Carry', contactPerson: 'Haji Yousuf', phone: '0301 5566778',
            city: 'Sukkur', category: 'Grocery', totalPurchased: 256000, lastOrderLabel: '2 Oct, 9:10 AM'),
        Vendor(id: '7', name: 'Karachi Oil Mills', contactPerson: 'Tariq Mehmood', phone: '0322 8899001',
            email: 'info@kom.pk', city: 'Karachi', category: 'Grocery',
            totalPurchased: 698400, outstanding: 32000, lastOrderLabel: '28 Sep, 2:20 PM'),
        Vendor(id: '8', name: 'CleanPro Supplies', contactPerson: 'Asad Khan', phone: '0334 1122334',
            email: 'asad@cleanpro.pk', city: 'Lahore', category: 'Cleaning',
            totalPurchased: 174200, lastOrderLabel: '25 Sep, 5:00 PM'),
        Vendor(id: '9', name: 'Sunrise Foods', contactPerson: 'Nida Farooq', phone: '0302 3344556',
            city: 'Karachi', category: 'Beverages', totalPurchased: 98500, lastOrderLabel: '14 Sep, 12:15 PM'),
        Vendor(id: '10', name: 'Haji Rafiq & Sons', contactPerson: 'Rafiq Ahmed', phone: '0311 6677889',
            city: 'Multan', category: 'General', isActive: false,
            totalPurchased: 64000, lastOrderLabel: '3 Jun, 10:00 AM'),
      ];
}