import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final _productId = ModalRoute.of(context).settings.arguments as String;
    final _product = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(_productId);

    return Scaffold(
      /*appBar: AppBar(
        title: Text(_product.title),
      ),*/
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_product.title),
              background: Hero(
                tag: _productId,
                child: Image.network(
                  _product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                '\$${_product.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Text(
                  _product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(height: 800,)
            ]),
          ),
        ],
      ),
    );
  }
}
