import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text('Some error occurred'));
            } else {
              return Consumer<OrdersProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(
                    orderItem: orderData.orders[i],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
