// Calculate total price with optional tax parameter
double calculateTotal(List<double> prices, {double taxRate = 0.0}) {
  // Filter items below $10 using anonymous function
  var filteredPrices = prices.where((price) => price >= 10.0).toList();

  // Calculate subtotal
  double subtotal = filteredPrices.fold(0, (sum, price) => sum + price);

  // Add tax
  double taxAmount = subtotal * taxRate;
  return subtotal + taxAmount;
}

// Apply discount using a function parameter
List<double> applyDiscount(
    List<double> prices, double Function(double) discountFunc) {
  return prices.map((price) => discountFunc(price)).toList();
}

// Calculate factorial discount recursively
double calculateFactorialDiscount(int itemCount) {
  // Base cases
  if (itemCount <= 1) return 1;

  // Recursive case: n! = n * (n-1)!
  return itemCount * calculateFactorialDiscount(itemCount - 1);
}

void main() {
  // Sample cart with item prices
  List<double> cartPrices = [15.99, 8.50, 25.50, 45.00, 9.99];

  print('Original cart prices: $cartPrices');

  // Calculate regular total with 8% tax
  double regularTotal = calculateTotal(cartPrices, taxRate: 0.08);
  print(
      '\nRegular total (with tax, filtered items < \$10): \$${regularTotal.toStringAsFixed(2)}');

  // Create a discount function (20% off)
  double percentageDiscount(double price) {
    return price * 0.80; // 20% off
  }

  // Apply percentage discount
  List<double> discountedPrices = applyDiscount(cartPrices, percentageDiscount);
  print(
      '\nPrices after 20% discount: ${discountedPrices.map((p) => p.toStringAsFixed(2)).toList()}');

  // Calculate total after percentage discount
  double discountedTotal = calculateTotal(discountedPrices, taxRate: 0.08);
  print(
      'Total after percentage discount and tax: \$${discountedTotal.toStringAsFixed(2)}');

  // Calculate factorial discount
  int itemCount = cartPrices.where((price) => price >= 10.0).length;
  double factorialPercentage = calculateFactorialDiscount(itemCount);
  double factorialDiscount = discountedTotal * (factorialPercentage / 100);

  // Calculate final price
  double finalPrice = discountedTotal - factorialDiscount;

  // Print final calculations
  print('\nNumber of items (after filtering): $itemCount');
  print(
      'Factorial discount percentage: ${factorialPercentage.toStringAsFixed(2)}%');
  print('Factorial discount amount: \$${factorialDiscount.toStringAsFixed(2)}');
  print(
      '\nFinal price after all discounts and tax: \$${finalPrice.toStringAsFixed(2)}');
}
