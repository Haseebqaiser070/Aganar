import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class CustomPurchase extends StatefulWidget {
  const CustomPurchase({Key? key}) : super(key: key);
  @override
  State<CustomPurchase> createState() => _CustomPurchaseState();
}

class _CustomPurchaseState extends State<CustomPurchase> {


  final InAppPurchase inAppPurchase = InAppPurchase.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePurchases();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }



  //In App Purchase payments
  bool isAvailable = false;
  List<ProductDetails> _products = [];
  late StreamSubscription _subscription;

  // List of users past purchases
  List<PurchaseDetails> purchases = [];


  Future initializePurchases()async{
    isAvailable = await inAppPurchase.isAvailable();

    if(isAvailable){
      await getUserProducts();
      _subscription = inAppPurchase.purchaseStream.listen((data)=> setState((){
        purchases.addAll(data);
        print(purchases);
      }));
    }
  }

  Future<void> getUserProducts() async {
    Set<String> ids = {"monthly"};
    ProductDetailsResponse response = await inAppPurchase.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
    print("products");
    print(_products);
  }

  void buyProduct(ProductDetails prod){
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }
}
