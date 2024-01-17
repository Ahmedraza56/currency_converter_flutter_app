import 'package:flutter/material.dart';

import '../utils/Constants.dart';
import '../utils/currency_service.dart';



class CurrencyList extends StatelessWidget {
  final CurrencyService currencyService = CurrencyService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
        future: currencyService.fetchCurrenciesWithCountryNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                  'Error: Failed to load data.',
                  style: AppDesignSystem.listError,
                ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final List<String> currencyCodes = snapshot.data!.keys.toList();
                final List<String> countryNames =
                snapshot.data!.values.toList();
                final String currencyCode = currencyCodes[index];
                final String countryName = countryNames[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                      style: AppDesignSystem.listCountText,
                    ),
                    backgroundColor: Color(0xff1d2937),
                    maxRadius: 15,
                  ),
                  title: Text(
                    countryName,
                    style: AppDesignSystem.countryName,
                  ),
                  trailing: FutureBuilder<double>(
                    future: currencyService.getExchangeRate(currencyCode),
                    builder: (context, rateSnapshot) {
                      if (rateSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (rateSnapshot.hasError) {
                        return Text(
                          'Error',
                          style: AppDesignSystem.listError,
                        );
                      } else {
                        // return Text('${rateSnapshot.data}',style: AppDesignSystem.subheadingStyle,);
                        return Text(
                          '${rateSnapshot.data!.toStringAsFixed(2).toString()}',
                          style: AppDesignSystem.countryRate,
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
    );
  }
}