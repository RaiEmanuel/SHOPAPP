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
    String grupal = "abc";
    /* ID da cor no banco é selecionada */
    int selectedColor = 0;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 30,
            onPressed: () {
              print("Voltou");
              Navigator.pop(context);
            },
          ),
          /*GestureDetector(
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
          ),*/
          actions: [
            /*Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 35,
              ),
            )*/
            IconButton(
              onPressed: () {
                print("Favoritou");
              },
              icon: Icon(Icons.favorite),
              iconSize: 30,
            ),
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
                  //var v = Connection.getAttr();
                  //ScaffoldMessenger.of(context)
                      //.showSnackBar(SnackBar(content: Text(v.toString())));

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
              /*Consumer<CartModel>(
                  builder: (_, cart, __) =>
                      Text("${cart.getQuantity().toString()}")),*/
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
                child: Container(
                  width: 150,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product.url.toString(),
                    ),
                  ),
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
                        WDropDownQuantityPurchase()
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
                            //ColorSelector(),
                            /* componentizar */
                            GestureDetector(
                              onTap: () {
                                print("Sou Roxo");
                                selectedColor = 0;
                              },
                              child: Padding(
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
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Sou Azul");
                                selectedColor = 1;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Sou Rosa");
                                selectedColor = 2;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.pinkAccent,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
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

class ColorSelector extends StatefulWidget {
  const ColorSelector({Key? key}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  String grupal = "aaa";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 60,
          child: RadioListTile<String>(
            title: Text("Radio"),
            value: "abc",
            groupValue: grupal,
            onChanged: (String? value) {
              setState(() {
                grupal = value!;
              });
            },
          ),
        ),
        Container(
          width: 120,
          height: 60,
          child: RadioListTile<String>(
            title: Text("Radio"),
            value: "def",
            groupValue: grupal,
            onChanged: (String? value) {
              setState(() {
                grupal = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class WDropDownQuantityPurchase extends StatefulWidget {
  const WDropDownQuantityPurchase({Key? key}) : super(key: key);

  @override
  State<WDropDownQuantityPurchase> createState() =>
      _WDropDownQuantityPurchaseState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _WDropDownQuantityPurchaseState extends State<WDropDownQuantityPurchase> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_downward,
      ),
      iconSize: 24,
      elevation: 0,
      style: const TextStyle(color: Colors.teal),
      underline: Container(
        height: 2,
        color: Colors.teal,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['1', '2', '3', '4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: (value == '1' ? Text('$value item') : Text('$value itens')),
        );
      }).toList(),
    );
  }
}
