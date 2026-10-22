// import 'product.dart';
import '../../Home-Component/Core/Data/models/product.dart';

enum PaymentMethod { cash, card, credit }

extension PaymentMethodLabel on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.credit:
        return 'Credit';
    }
  }
}

class BillLine {
  final Product product;
  final int quantity;

  const BillLine({required this.product, required this.quantity});

  double get total => product.price * quantity;

  BillLine copyWith({int? quantity}) =>
      BillLine(product: product, quantity: quantity ?? this.quantity);
}

class Bill {
  final String id;
  final String number;
  final String customerName;
  final PaymentMethod paymentMethod;
  final List<BillLine> lines;
  final double discount; // flat Rs.
  final double taxPercent;
  final DateTime createdAt;

  const Bill({
    required this.id,
    required this.number,
    required this.customerName,
    required this.paymentMethod,
    required this.lines,
    required this.discount,
    required this.taxPercent,
    required this.createdAt,
  });

  int get itemCount => lines.fold(0, (s, l) => s + l.quantity);

  double get subtotal => lines.fold(0.0, (s, l) => s + l.total);

  double get appliedDiscount => discount > subtotal ? subtotal : discount;

  double get afterDiscount => subtotal - appliedDiscount;

  double get taxAmount => afterDiscount * taxPercent / 100;

  double get grandTotal => afterDiscount + taxAmount;
}
