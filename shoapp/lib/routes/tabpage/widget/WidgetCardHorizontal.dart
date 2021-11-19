import 'package:flutter/material.dart';
import 'package:shoapp/model/Product.dart';


class WidgetCardProductHorizontal extends StatelessWidget {
  Product product;

  WidgetCardProductHorizontal({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: product);
        },
        child: Container(
          color: Colors.teal,
          child: Row(
            children: [
              Container(
                width: 150,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product.picture,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Visby"),
                        ),
                        Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "R\$ ${product.value.toString()}",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}