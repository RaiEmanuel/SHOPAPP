import 'package:flutter/material.dart';
import 'package:shoapp/Product.dart';
import 'package:shoapp/PurchasedProduct.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'package:provider/provider.dart';
import 'package:shoapp/pCartModel.dart';

class RouteProduct extends StatefulWidget {
  const RouteProduct({Key? key}) : super(key: key);
  @override
  _RouteProductState createState() => _RouteProductState();
}

class _RouteProductState extends State<RouteProduct> {
  ColorAPI selectedColor = ColorAPI(id: 2, name: "Preto", color: Colors.black);
  //int indexSelectedColor = 1; //0 - invalid

  //dropdown de pegar a quantidae
  WDropDownQuantityPurchase dropDownQuantity = WDropDownQuantityPurchase(
    selectedQuantity: 1,
  );
  List<WidgetColorSelector> colors = [];

  @override
  void initState() {
    super.initState();

    /****** simulando que as cores vieram da api *****/
    colors.add(
      WidgetColorSelector(
        colorAPI: ColorAPI(id: 2, name: "Preto", color: Colors.black),
        onTap: () {
          setState(() {
            selectedColor = ColorAPI(id: 2, name: "Preto", color: Colors.black);
          });
        },
      ),
    );
    colors.add(
      WidgetColorSelector(
        colorAPI: ColorAPI(id: 3, name: "Azul", color: Colors.blueAccent),
        onTap: () {
          setState(() {
            selectedColor =  ColorAPI(id: 3, name: "Azul", color: Colors.blueAccent);
          });
        },
      ),
    );
    colors.add(
      WidgetColorSelector(
        colorAPI: ColorAPI(id: 6, name: "Azul", color: Colors.grey),
        onTap: () {
          setState(() {
            selectedColor = ColorAPI(id: 6, name: "Azul", color: Colors.grey);
          });
        },
      ),
    );
    colors.add(
      WidgetColorSelector(
        colorAPI: ColorAPI(id: 4, name: "Vermelho", color: Colors.redAccent),
        onTap: () {
          setState(() {
            selectedColor = ColorAPI(id: 4, name: "Vermelho", color: Colors.redAccent);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    //String grupal = "abc";
    /* ID da cor no banco é selecionada */
    //int selectedColor = 0;
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

                /* pegar o id da cor, melhorar para pegar do banco */
                /* por enquanto ficará fixo, mas no futuro deixar dinâmico vindo do banco */

                PurchasedProduct purchasedProduct = PurchasedProduct(
                    id: product.id,
                    url: product.url,
                    title: product.title,
                    desc: product.desc,
                    favorite: product.favorite,
                    value: product.value,
                    colors: [selectedColor.id],
                    quantity: dropDownQuantity.selectedQuantity);
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
              },
              color: Colors.white,
              colorIcon: Colors.teal,
              colorText: Colors.teal,
            ),
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
                            child: Container(height: 30, color: selectedColor.color),
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
                          dropDownQuantity,
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
                      Navigator.pushNamed(context, '/feedback',
                          arguments: product);
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
/* *************************************************************** */
class ColorAPI{
  int id;
  String name;
  Color color;

  ColorAPI({required this.id, required this.name, required this.color});
}

/* *************************************************************** */
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

/* *************************************************************** */
/* Dropdown de quantidade */
class WDropDownQuantityPurchase extends StatefulWidget {
  int selectedQuantity;

  WDropDownQuantityPurchase({Key? key, required this.selectedQuantity})
      : super(key: key);

  @override
  State<WDropDownQuantityPurchase> createState() =>
      _WDropDownQuantityPurchaseState();
}

class _WDropDownQuantityPurchaseState extends State<WDropDownQuantityPurchase> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      hint: Text("Selecione a quantidade"),
      value: widget.selectedQuantity,
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
      onChanged: (int? newValue) {
        setState(() {
          widget.selectedQuantity = newValue!;
          print("novo ${widget.selectedQuantity}");
        });
      },
      items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int quantity) {
        return DropdownMenuItem<int>(
          value: quantity,
          child: (Text('${quantity} itens')),
        );
      }).toList(),
    );
  }
}
/* *************************************************************** */

/* Círculo seletor de cor */
class WidgetColorSelector extends StatefulWidget {
  Function()? onTap = () {};
  ColorAPI colorAPI;

  WidgetColorSelector({Key? key, this.onTap, required this.colorAPI})
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
            color: widget.colorAPI.color,
          ),
          width: 25,
          height: 25,
        ),
      ),
    );
  }
} /* *************************************************************** */
