class CryptoListingModel {
  final String symbol;
  final String name;
  final double price;
  final double variantionLast24Hours;

  const CryptoListingModel(
      {required this.name,
      required this.price,
      required this.symbol,
      required this.variantionLast24Hours});

  factory CryptoListingModel.fromData(Map<String, dynamic> data) {
    final name = data['name'];
    final symbol = data['symbol'];
    final price = data['quote']['USD']['price'];
    final variationLast24Hours = data['quote']['USD']['percent_change_24h'];

    return CryptoListingModel(
        name: name,
        price: price,
        symbol: symbol,
        variantionLast24Hours: variationLast24Hours);
  }
}
