import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/crypto_listing_model.dart';

class CryptoListingRepository {
  static Future<List<CryptoListingModel>> all() async {
    final url = Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest');

    final response = await http.get(url,
        headers: {"X-CMC_PRO_API_KEY": "371d8c29-bd32-4e9b-8053-9a8d776dad82"});

    final jsonData = json.decode(response.body);
    final cryptoListings =
        (jsonData['data'] as List<dynamic>).map((cryptoData) {
      return CryptoListingModel.fromData(cryptoData);
    }).toList();

    return cryptoListings;
  }
}
