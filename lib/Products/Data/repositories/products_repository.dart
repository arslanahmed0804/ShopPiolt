import '../../../Home-Component/Core/Data/models/product.dart';

/// Products page sirf is interface se baat karti hai.
/// Backend ke waqt ApiProductsRepository banao aur main.dart mein swap karo.
abstract class ProductsRepository {
  Future<List<Product>> fetchProducts();
  Future<Product> addProduct(Product product);
  Future<void> restock(String id);
  Future<void> adjustStock(String id, int adjustment);
  Future<void> deleteProduct(String id);
}

class MockProductsRepository implements ProductsRepository {
  final List<Product> _items = _seed();

  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_items);
  }

  @override
  Future<Product> addProduct(Product product) async {
    _items.insert(0, product);
    return product;
  }

  @override
  Future<void> restock(String id) async {
    final i = _items.indexWhere((p) => p.id == id);
    if (i == -1) return;
    final p = _items[i];
    _items[i] = p.copyWith(quantity: p.quantity + p.minQuantity * 2);
  }

  @override
  Future<void> adjustStock(String id, int adjustment) async {
    final i = _items.indexWhere((p) => p.id == id);
    if (i == -1) throw StateError('Product $id was not found');
    final p = _items[i];
    final quantity = p.quantity + adjustment;
    if (quantity < 0) throw StateError('Insufficient stock for ${p.name}');
    _items[i] = p.copyWith(quantity: quantity);
  }

  @override
  Future<void> deleteProduct(String id) async {
    _items.removeWhere((p) => p.id == id);
  }

  static Product _p(
    String id,
    String name,
    String sku,
    String cat,
    int qty,
    int min,
    double price,
  ) {
    final c = ProductPalette.pick(name);
    return Product(
      id: id,
      name: name,
      sku: sku,
      category: cat,
      quantity: qty,
      minQuantity: min,
      price: price,
      avatarBg: c[0],
      avatarFg: c[1],
      barcode: '',
      vendorName: '',
    );
  }

  static List<Product> _seed() => [
    _p('1', "Olper's Dairy Milk 1L", 'DRY-014', 'Dairy', 4, 12, 290),
    _p('2', 'Surf Excel 1kg', 'CLN-038', 'Cleaning', 7, 15, 640),
    _p('3', 'LU Prince Biscuit', 'SNK-102', 'Snacks', 9, 20, 60),
    _p('4', 'Tapal Danedar 475g', 'TEA-007', 'Beverages', 3, 10, 720),
    _p('5', 'Lipton Yellow Label 190g', 'TEA-011', 'Beverages', 28, 15, 410),
    _p('6', 'National Iodized Salt 800g', 'GRC-021', 'Grocery', 54, 20, 70),
    _p('7', 'Shan Biryani Masala', 'GRC-033', 'Grocery', 33, 15, 130),
    _p('8', 'Dalda Cooking Oil 1L', 'GRC-045', 'Grocery', 18, 20, 560),
    _p('9', 'Nestle Everyday 910g', 'DRY-019', 'Dairy', 22, 12, 1280),
    _p('10', 'Coca-Cola 1.5L', 'BEV-002', 'Beverages', 61, 30, 210),
    _p('11', 'Peek Freans Sooper', 'SNK-015', 'Snacks', 40, 20, 40),
    _p('12', 'Knorr Noodles 4-pack', 'SNK-077', 'Snacks', 12, 15, 190),
    _p('13', 'Lifebuoy Soap 3-pack', 'PRC-009', 'Personal care', 26, 10, 330),
    _p('14', 'Sunsilk Shampoo 360ml', 'PRC-024', 'Personal care', 6, 12, 690),
    _p('15', 'Dettol Handwash 250ml', 'PRC-031', 'Personal care', 19, 10, 340),
    _p('16', 'Basmati Rice 5kg', 'GRC-050', 'Grocery', 15, 10, 2150),
    _p('17', 'Tang Orange 500g', 'BEV-016', 'Beverages', 8, 10, 520),
    _p('18', 'Harpic Toilet Cleaner', 'CLN-012', 'Cleaning', 35, 12, 380),
  ];
}
