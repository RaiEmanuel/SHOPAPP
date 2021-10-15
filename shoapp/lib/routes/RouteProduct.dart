import 'package:flutter/material.dart';
import 'package:shoapp/Product.dart';
import 'package:shoapp/PurchasedProduct.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'package:provider/provider.dart';
import 'package:shoapp/pCartModel.dart';
import 'package:shoapp/connection/connection.dart';

class RouteProduct extends StatelessWidget {
  RouteProduct({Key? key}) : super(key: key);

  Color selectedColor = Colors.white;
  int indexSelectedColor = 0;//0 - invalid
  List<WidgetColorSelector> colors = [
    WidgetColorSelector(
      onTap: () {
        print("[[[[[[[[[[[[[preto]]]]]]]]]]]]");
        //selectedColor = Colors.black;
      },
      color: Colors.black,
    ),
    WidgetColorSelector(
      onTap: () {
        print("[[[[[[[[[[[[[azul]]]]]]]]]]]]");
      },
      color: Colors.blueAccent,
    ),
    WidgetColorSelector(
      onTap: () {
        print("[[[[[[[[[[[[[verde]]]]]]]]]]]]");
      },
      color: Colors.greenAccent,
    ),
  ];

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
        title: Text("Produto"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Favoritou");
            },
            icon: Icon(Icons.favorite),
            iconSize: 30,
          ),
        ],
      ),
      //backgroundColor: Colors.teal,
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
                var cart = Provider.of<PCartModel>(context, listen: false);
                //Provider.of<CartModel>(context, listen: false)
                PurchasedProduct purchasedProduct = PurchasedProduct(
                    id: product.id,
                    url: product.url,
                    title: product.title,
                    desc: product.desc,
                  favorite: product.favorite,
                  value: product.value,
                  colors: [1],
                  quantity: 3
                );
                print(purchasedProduct.id);

                if (cart.add(purchasedProduct)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.teal,
                      content: Text(
                          "Produto ${product.title} adicionado com sucesso!"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content:
                          Text("Produto ${product.title} já está no carrinho!"),
                    ),
                  );
                }
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
      body: ListView(
        //physics: NeverScrollableScrollPhysics(),
        physics: BouncingScrollPhysics(),
        //physics: RangeMaintainingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                color: Colors.teal,
              ),
              Positioned(
                bottom: -150,
                child: Container(
                  //width: MediaQuery.of(context).size.width,
                  height: 300,
                  //color: Colors.greenAccent,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product.url.toString(),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            //color: Colors.greenAccent,
            width: MediaQuery.of(context).size.width,
            //height: 899,
            child: Padding(
              padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
              child: Column(
                //coluna de informações
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    //color: Colors.greenAccent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //titulo do produto
                        product.title.toString(),
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    //coluna das informações restantes
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              //titulo do produto
                              "Cores e quantidade",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            flex: 8,
                          ),
                          Expanded(
                            child: Container(height: 30, color: Colors.red),
                            flex: 2,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          //ColorSelector(),
                          /* componentizar */
                          Expanded(
                            child: Container(
                              //color: Colors.greenAccent,
                              child: Row(
                                children: colors,
                              ),
                            ),
                            //flex: 5,
                          ),
                          WDropDownQuantityPurchase(),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //---------------- descrição
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.desc.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //---------------- Avaliações
                  WButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/feedback', arguments: product);
                    },
                    width: MediaQuery.of(context).size.width,
                    icon: Icons.feedback,
                    text: "Ver Feedback do produto",
                  ),
                  //Container(width: MediaQuery.of(context).size.width,color: Colors.greenAccent,child: Expanded(child: Text("ssss"))),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
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
      onChanged: (int ? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <int>[1,2,3,4]
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: (value == '1' ? Text('$value item') : Text('$value itens')),
        );
      }).toList(),
    );
  }
}

class WidgetColorSelector extends StatefulWidget {
  Function()? onTap = () {};
  Color color;

  WidgetColorSelector({Key? key, this.onTap, this.color = Colors.blueAccent})
      : super(key: key);

  @override
  _WidgetColorSelectorState createState() => _WidgetColorSelectorState();
}

class _WidgetColorSelectorState extends State<WidgetColorSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: widget.color,
          ),
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
