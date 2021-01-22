import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../models/order.dart' as order;

class OrderItem extends StatefulWidget {
  final order.OrderItem orderItem;

  OrderItem({this.orderItem});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min((widget.orderItem.products.length * 20.0 + 110.0), 200)
          : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.orderItem.amount}'),
              subtitle: Text(
                DateFormat('dd-MM-yyyy hh:mm')
                    .format(widget.orderItem.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? min((widget.orderItem.products.length * 20.0 + 10.0), 100)
                  : 0,
              duration: Duration(milliseconds: 300),
              child: ListView(
                children: widget.orderItem.products
                    .map((e) => Row(
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${e.quantity}x \$${e.price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
