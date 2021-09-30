import 'package:flutter/material.dart';
import 'package:shoapp/Product.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'package:provider/provider.dart';
import '../PCartModel.dart';
import 'package:shoapp/connection/connection.dart';

class RouteProduct extends StatelessWidget {
  const RouteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 35,
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.teal,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  "R\$ ${product.value.toString()}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              WButton(
                width: 200,
                height: 50,
                text: "Comprar",
                icon: Icons.shopping_cart,
                onTap: () {
                  /*Connection.getAttr().then((value){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                  });*/
                  var v = Connection.getAttr();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));

                  var cart = Provider.of<CartModel>(context, listen: false);
                  //Provider.of<CartModel>(context, listen: false)
                  cart.add(product);
                  print(cart.getQuantity());
                  //c.add(Product("d","dd","ddd",10,true));
                },
                color: Colors.white,
                colorIcon: Colors.teal,
                colorText: Colors.teal,
              ),
              Consumer<CartModel>(
                  builder: (_, cart, __) =>
                      Text("${cart.getQuantity().toString()}")),
            ],
          ),
        ),
        body: Column(children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.teal,
              ),
              Positioned(
                bottom: -150,
                child: Image.network(
                  product.url.toString(),
                  height: 300,
                ),
              )
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              //height: 899,
              child: Padding(
                padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*Container(
                    color: Colors.blueGrey,
                    width: double.infinity,
                    child: Text("sgggg"),
                  ),*/
                    Row(
                      //linha do titulo
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 120,
                          child: Text(
                            //titulo do produto
                            product.title.toString(),
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 34,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Column(
                      //linha do titulo
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            //titulo do produto
                            "Cores",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.deepPurple,
                                ),
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.amber,
                                ),
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.red,
                                ),
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        product.desc.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
