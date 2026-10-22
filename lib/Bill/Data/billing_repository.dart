// import '../models/bill.dart';
import '../Data/bill.dart';

// import 'products_repository.dart';
import '../../Products/Data/repositories/products_repository.dart';

/// Billing page sirf is interface se baat karti hai.
/// Real backend mein createBill ke andar hi stock deduct karo (ek transaction mein).
abstract class BillingRepository {
  Future<String> nextBillNumber();
  Future<Bill> createBill(Bill bill);
  Future<List<Bill>> fetchBills();
}

class MockBillingRepository implements BillingRepository {
  final ProductsRepository products;
  final List<Bill> _bills = [];

  MockBillingRepository(this.products);

  @override
  Future<String> nextBillNumber() async => 'INV-${1001 + _bills.length}';

  @override
  Future<Bill> createBill(Bill bill) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final line in bill.lines) {
      await products.adjustStock(line.product.id, -line.quantity);
    }
    _bills.insert(0, bill);
    return bill;
  }

  @override
  Future<List<Bill>> fetchBills() async => List.unmodifiable(_bills);
}
