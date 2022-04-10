import 'package:binance/models/crypto_listing_model.dart';
import 'package:binance/repositories/crypto_listing_repository.dart';
import 'package:binance/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/crypto_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CryptoListingModel>> cryptoListingFuture;

  @override
  void initState() {
    super.initState();
    cryptoListingFuture = CryptoListingRepository.all();
  }

  void refreshData() {
    setState(() {
      cryptoListingFuture = CryptoListingRepository.all();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBackgroundColor,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: ThemeColors.cardBackgroundColor,
        leading: IconButton(
          onPressed: refreshData,
          icon: Icon(Icons.refresh),
        ),
        title: Text(
          'BINANCE',
          style: TextStyle(letterSpacing: 5, color: Colors.yellow),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5603AQFTWxo5wSu_ZQ/profile-displayphoto-shrink_400_400/0/1574768857971?e=1655337600&v=beta&t=DTAINDUPryMNFlOb5b2dNCP9LgzSrqqqy3YcUdDapRE'),
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Il mio saldo',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '€ 1294.97',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget body() => Container(
        margin: EdgeInsets.only(top: 10),
        decoration:
            BoxDecoration(color: ThemeColors.cardBackgroundColor, boxShadow: [
          BoxShadow(
              offset: Offset(0, -2),
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2)
        ]),
        child: Column(children: [
          bodyHeader(),
          Divider(),
          bodyContent(),
        ]),
      );

  Widget bodyHeader() => Container(
        child: ListTile(
          title: Text(
            'Lista Crypto',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Basato sulle top 100'),
          trailing: Text('Mostra tutte'),
        ),
      );

  Widget bodyContent() => Expanded(
          child: FutureBuilder<List<CryptoListingModel>>(
        future: cryptoListingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => CryptoListTile(
                symbol: snapshot.data![index].symbol,
                name: snapshot.data![index].name,
                price: snapshot.data![index].price,
                variation24Hours: snapshot.data![index].variantionLast24Hours,
              ),
              separatorBuilder: (context, index) => Divider(),
            );
          }
        },
      ));
}
