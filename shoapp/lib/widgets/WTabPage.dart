import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'package:shoapp/widgets/WTextFormField.dart';
import '../Product.dart';
import 'WCardproduct.dart';
import './WText.dart';
import 'WButton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoapp/connection/Connection.dart';
import 'dart:convert';
import 'package:shoapp/widgets/WProfile.dart';
import 'package:shoapp/Address.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'package:shoapp/pCartModel.dart' as MyCart;

import 'package:http/http.dart' as http;

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 0;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;
  PageController controller = PageController();
  String title = "";

  /* Campos da página de perfil do usuário */
  String urlPhoto =
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E",
      name = "Default name",
      email = "Default email";
  WTextFormField? wTextFormFieldEmail, wTextFormFieldName;

  List<Color> colors = [
    //Color(0xFFEEEEEE),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0)
  ];

  List<Product> products = [];

  void initAsync() async {
    String token = await UserSecureStorage.getToken();
    //traz dados pessoais
    String meJson = await Connection.me("bearer", token);
    setState(() {
      Map<String, dynamic> user = jsonDecode(meJson);
      title = "SHOPAPP. Bem vindo(a), ${user['name']}";
      urlPhoto = user['picture'];
      name = user['name'];
      email = user['email'];
      print(" user logado xxxxxxxxxxxxxxxxxxxxxxx ${user}");
      /* traz produtos */
    });
    String productsJson = await Connection.products();
    List productsListAPI = jsonDecode(productsJson);
    setState(() {
        for (var product in productsListAPI) {
          products.add(new Product(
              id: int.parse(product['id'].toString()),
              url: product['picture'],
              title: product['name'],
              desc: product['description'],
              //desc: "Descrição",
              value: double.parse(product['value'].toString()),
              favorite: false));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initAsync();
    /* Inicializa campos do perfil */
    wTextFormFieldEmail = WTextFormField(
      label: "Email",
      icon: Icons.alternate_email,
      keyboardType: TextInputType.text,
      isActive: false,
    );
    wTextFormFieldEmail!.setText(email);
    wTextFormFieldName = WTextFormField(
      //hint: "",
      icon: Icons.drive_file_rename_outline,
      label: "Nome",
      keyboardType: TextInputType.text,
      isActive: false,
    );
    wTextFormFieldName!.setText(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Builder(
        builder: (context) => PageView.builder(
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
              //badge = badge + 1;
            });
          },
          controller: controller,
          itemBuilder: (context, position) {
            return Container(
              color: colors[position],
              child: wBody(position, context),
            );
          },
          itemCount: 4,
        ),
      ),
      bottomNavigationBar: wBottomNavigationBar(),
    );
  }

  SafeArea wBottomNavigationBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 60,
              color: Colors.black.withOpacity(.4),
              offset: Offset(0, 25),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
          child: GNav(
            tabs: [
              buildGButton("Home", Icons.home, true),
              buildGButtonWithBadge("Carrinho", Icons.shopping_cart),
              buildGButton("Pagamento", Icons.attach_money, false),
              buildGButton("Perfil", Icons.person, true),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
              controller.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }

  Widget wBody(int position, BuildContext context) {
    Widget body = Column(
      children: [Text(position.toString())],
    );
    switch (position) {
      case 0:
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white10,
          appBar: AppBar(
            title: Text(
              "Home",
              style: TextStyle(color: Colors.teal),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.teal,
              ),
              iconSize: 30,
            ),
          ),
          body: ListView(
              //padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  width: 300,
                  height: 150,
                  child: WText(
                    text: title,
                    color: Colors.teal,
                    topPadding: 20,
                    //bottomPadding: 20,
                    leftPadding: 20,
                    fontHeight: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: wRowSearch(),
                ),
                SizedBox(
                  height: 20,
                ),
                WText(
                    text: "Mais vendidos",
                    color: Colors.teal,
                    leftPadding: 20,
                    fontHeight: 20),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: wCardProduct(products, context),
                ),
                SizedBox(
                  height: 20,
                ),
                WText(
                    text: "Produtos",
                    color: Colors.teal,
                    leftPadding: 20,
                    fontHeight: 20),
                SizedBox(
                  height: 20,
                ),
                getWidgetCardProductHorizontal(products),
              ]),
        );

      case 1:
        MyCart.PCartModel cart = Provider.of<MyCart.PCartModel>(context);
        return Scaffold(
            body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100 + MediaQuery.of(context).padding.top,
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: WText(
                          text:
                              "Total: R\$:${cart.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}",
                          color: Colors.white,
                          fontHeight: 22),
                      flex: 5,
                    ),
                    Expanded(
                      child: WButton(
                        color: Colors.white,
                        colorText: Colors.teal,
                        colorIcon: Colors.teal,
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                          controller.jumpToPage(2);
                        },
                        icon: Icons.shopping_cart,
                        text: "Comprar",
                      ),
                      flex: 5,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: ,
              color: Colors.greenAccent,
              //height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: cart.getQuantity(),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.teal,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        //foto
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            width: 150,
                            color: Colors.white,
                            child: Image.network(cart.products[index].url),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cart.products[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Quantidade: ${cart.products[index].quantity.toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                //o que importa é a cor
                                WidgetColorSelector(
                                    colorAPI: ColorAPI(
                                        id: 0,
                                        color: cart.products[index].getColor(),
                                        name: "default"))
                              ],
                            ),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.redAccent,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        )
            /*Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.teal,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WText(
                              text:
                              "Total: R\$:${cart.totalPrice.toStringAsFixed(2)
                                  .replaceAll(".", ",")}",
                              color: Colors.white,
                              fontHeight: 20),
                          WButton(
                              height: 50,
                              width: 160,
                              icon: Icons.shopping_cart,
                              colorIcon: Colors.teal,
                              sizeText: 18,
                              colorText: Colors.teal,
                              color: Colors.white,
                              text: "COMPRAR",
                              onTap: () {
                                buy(cart);
                                setState(() {
                                  selectedIndex = 2;
                                  //badge = badge + 1;
                                });
                                controller.jumpToPage(2);
                              },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: cart.getQuantity() == 0
                        ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.network(
                                "https://assets7.lottiefiles.com/datafiles/vhvOcuUkH41HdrL/data.json",
                                height: 150),
                            WText(
                              topPadding: 15,
                              text: "Não há itens no carrinho",
                              color: Colors.teal,
                              fontHeight: 25,
                            ),
                          ],
                        ))
                        : ListView.builder(
                      itemCount: cart.getQuantity(),
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.teal,
                              ),
                              width: double.infinity,
                              height: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                      cart.products[index].url,
                                      width: 120,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      WText(
                                        text: cart.products[index].title,
                                        color: Colors.white,
                                        fontHeight: 15,
                                      ),
                                      //Text("cor"),
                                      Text(
                                          cart.products[index].colors
                                              .toString()),
                                      Text(cart.products[index].quantity
                                          .toString())
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      WButton(
                                          color: Colors.white,
                                          height: 50,
                                          sizeIcon: 30,
                                          icon: Icons.remove_red_eye,
                                          colorIcon: Colors.teal,
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/product',
                                                arguments: cart
                                                    .products[index]);
                                          }),
                                      WButton(
                                          color: Colors.white,
                                          height: 50,
                                          sizeIcon: 30,
                                          icon: Icons.delete,
                                          colorIcon: Colors.red,
                                          onTap: () {
                                            cart.remove(cart.products[index]);
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    ),
                  )
                ],
              ),
          ),*/
            );
      case 2:
        MyCart.PCartModel cartModel = Provider.of<MyCart.PCartModel>(context);
        return WCreditCard(cartModel: cartModel);

      case 3:
        //String name,
        return WProfile(
          urlPhoto: urlPhoto,
          wTextFormFieldEmail: wTextFormFieldEmail!,
          wTextFormFieldName: wTextFormFieldName!,
        );

      default:
        return body;
    }
  }

  Widget getWidgetCardProductHorizontal(List<Product> products) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return WidgetCardProductHorizontal(product: products[index]);
        });
  }

  Widget wRowSearch() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: WTextFormField(
                hint: "O que deseja?",
                icon: Icons.search_rounded,
                sizeIcon: 30,
                label: "Busca",
              ),
            ),
            flex: 7,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            child: WButton(
              //width: 50,
              //height: 50,
              sizeIcon: 30,
              onTap: () async {},
            ),
            flex: 2,
          )
        ],
      ),
    );
  }

  GButton buildGButtonWithBadge(String text, IconData icon) {
    MyCart.PCartModel cart = Provider.of<MyCart.PCartModel>(context);
    return GButton(
      gap: gap,
      iconActiveColor: Colors.teal,
      iconColor: Colors.teal,
      textColor: Colors.teal,
      backgroundColor: Colors.teal.withOpacity(.2),
      iconSize: 24,
      padding: padding,
      icon: icon,
      text: text,
      leading: Badge(
        elevation: 0,
        badgeColor: Colors.amber,
        position: BadgePosition.topEnd(top: -12, end: -12),
        badgeContent: Text(
          cart.getQuantity().toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.teal,
        ),
      ),
    );
  }

  GButton buildGButton(String text, IconData icon, bool active) {
    return GButton(
      gap: gap,
      iconActiveColor: Colors.teal,
      iconColor: Colors.teal,
      textColor: Colors.teal,
      backgroundColor: Colors.teal.withOpacity(.2),
      iconSize: 24,
      padding: padding,
      icon: icon,
      text: text,
      active: active,
    );
  }
}

void getCredentials(String type, String token) async {}

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
                      product.url,
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
                          product.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Visby"
                          ),
                        ),
                        Text(
                          product.desc,
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

class WCreditCard extends StatefulWidget {
  MyCart.PCartModel cartModel;

  WCreditCard({required this.cartModel});

  @override
  State<StatefulWidget> createState() {
    return WCreditCardState();
  }
}

class WCreditCardState extends State<WCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  Address address =
      Address(latitude: "0", longitude: "0", street: "rua Brasil, 23");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool selectedAddress = false;

  //SharedPreferencesApp sharedPreferencesApp = SharedPreferencesApp();

  void buy(MyCart.PCartModel cart, Address address) async {
    String token = await UserSecureStorage.getToken();
    if (cart.getQuantity() > 0) {
      //compra
      Connection.purchase(
              "bearer",
              token,
              cart.products,
              Address(
                  latitude: address.latitude,
                  longitude: address.longitude,
                  street: address.street))
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent[700],
            content: Text("Compra efetuada com sucesso!")));
      });
      cart.removeAll();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Não há itens no carrinho!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Compra ${widget.cartModel.getQuantity()}",
            style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.teal,
          ),
          iconSize: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.purple,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Número',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Data expiração',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome do titular',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: WButton(
                          text: "Selecionar endereço",
                          width: MediaQuery.of(context).size.width,
                          icon: Icons.place,
                          onTap: () {
                            //MyCart.PCartModel cart = Provider.of<MyCart.PCartModel>(context);
                            Navigator.pushNamed(context, '/map').then((value) {
                              Address x = value as Address;
                              print(
                                  "====================== ${x.latitude}, ${x.longitude}, ${x.street} ");
                              setState(() {
                                selectedAddress = true;
                                address = value as Address;
                              });
                            });
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: WButton(
                        text: "FINALIZAR COMPRA",
                        active: (widget.cartModel.getQuantity() > 0 &&
                                selectedAddress == true)
                            ? false
                            : true,
                        color: (widget.cartModel.getQuantity() > 0 &&
                                selectedAddress == true)
                            ? Colors.teal
                            : Colors.black12,
                        height: 50,
                        width: double.infinity,
                        icon: Icons.shopping_cart,
                        onTap: () async {
                          //http.Response d = fetchAlbum() as http.Response;
                          //http.Response res = await fetchAlbum();
                          //print(res.body);
                          // Produto p1 = Produto.fromJson(jsonDecode(res.body));
                          buy(widget.cartModel, address);
                          setState(() {
                            selectedAddress = false;
                          });
                          //controller.jumpToPage(2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //);
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://fakestoreapi.com/products/1'));
}

class Produto {
  int id = 1;
  String titulo = "default", categoria = "default";
  double preco = 0.0;

  Produto(this.id, this.titulo, this.categoria, this.preco);

  Produto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titulo = json['title'],
        categoria = json['category'],
        preco = json['price'];
}

/* ********************************* */
class ColorAPI {
  int id;
  String name;
  Color color;

  ColorAPI({required this.id, required this.name, required this.color});
}

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
}
