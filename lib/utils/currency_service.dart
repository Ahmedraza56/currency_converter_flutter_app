import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String baseUrl = 'https://openexchangerates.org/api';
  // final String appID = 'b55e837bf01846e3aa3737c96a3a9799';  // open exchange rate api
  //final String appID = '05107e8c25664ce8a5aab7f0dd3e1487'; // open exchange rate api
   final String appID = '4d5181ff9ea34e2f84e4f345bea12f3c'; // open exchange rate api

  Future<Map<String, double>> getExchangeRates() async {
    try {
      String url = '$baseUrl/latest.json?app_id=$appID';
      http.Response response = await http.get(Uri.parse(url));
//log(response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('rates') && data['rates'] is Map) {
          Map<String, dynamic> ratesData = data['rates'];

          Map<String, double> rates = {};

          ratesData.forEach((key, value) {
            if (value is int || value is double) {
              rates[key] = value.toDouble();
            } else {
              debugPrint('Unexpected data type for $key: $value');
            }
          });

          return rates;
        } else {
          throw Exception('Invalid response format for exchange rates');
        }
      } else {
        throw Exception('Failed to fetch exchange rates');
      }
    } catch (e) {
      debugPrint('Error fetching exchange rates: $e');
      throw Exception('Failed to fetch exchange rates');
    }
  }

  Future<dynamic> convertCurrency(String from, String to, double amount) async {
    try {
      Map<String, double> rates = await getExchangeRates();
      if (rates.containsKey(to) && rates.containsKey(from)) {
        double convertedAmount = amount * rates[to]! / rates[from]!;
        return convertedAmount;
      } else {
        throw Exception('Unsupported currencies');
      }
    } catch (e) {
      debugPrint('Error during currency conversion: $e');
      throw Exception('Failed to convert currency');
    }
  }

  Future<Map<String, String>> fetchCurrenciesWithCountryNames() async {
    try {
      String url = '$baseUrl/currencies.json?app_id=$appID';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Map<String, String>.from(data);
      } else {
        throw Exception('Failed to fetch currency list');
      }
    } catch (e) {
      debugPrint('Error fetching currencies: $e');
      throw Exception('Failed to fetch currency list');
    }
  }

  Future<double> getExchangeRate(String currencyCode) async {
    try {
      Map<String, double> rates = await getExchangeRates();
      if (rates.containsKey(currencyCode)) {
        return rates[currencyCode]!;
      } else {
        throw Exception('Invalid currency code');
      }
    } catch (e) {
      debugPrint('Error fetching exchange rate: $e');
      throw Exception('Failed to fetch exchange rate for $currencyCode');
    }
  }

  String formatCurrency(String symbol, String locale, num number) {
    return number.toStringAsFixed(2).toString();
  }

  Future<List<String>> fetchCurrencies() async {
    try {
      String url = '$baseUrl/currencies.json?app_id=$appID';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<String> currencies = data.keys.cast<String>().toList();

        return currencies;
      } else {
        throw Exception('Failed to fetch currency list');
      }
    } catch (e) {
      debugPrint('Error fetching currencies: $e');
      throw Exception('Failed to fetch currency list');
    }
  }
}
