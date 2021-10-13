import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoapp/PCartModel.dart';
import 'package:shoapp/widgets/WTextFormField.dart';
import '../Product.dart';
import 'WCardproduct.dart';
import './WText.dart';
import 'WCreditCard.dart';
import 'WButton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shoapp/connection/Connection.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoapp/widgets/WProfile.dart';

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

  List<Product> products = [
    new Product(
        url:
            "https://img.terabyteshop.com.br/produto/g/placa-de-video-palit-nvidia-geforce-rtx-3080ti-gamingpro-12gb-gddr6x-384bit-ned308t019kb-132aa_123399.png",
        title: "PLACA NVIDIA 5432X",
        desc: "Ideal para seus jogos",
        value: 5899.99,
        favorite: true),
    new Product(
        url:
            "https://images.lojanike.com.br/1024x1024/produto/tenis-nike-air-max-2090-masculino-BV9977-800-1.png",
        title: "TÊNIS NIKE AIR PLUS",
        desc: "Mais conforto para seu esporte",
        value: 1359.99,
        favorite: false),
    new Product(
        url:
            "https://tecnoblog.net/wp-content/uploads/2020/11/xbox_series_x_produto.png",
        title: "XBOX MAX",
        desc: "Mais desempenho e qualidade",
        value: 12899.99,
        favorite: true),
    new Product(
        url:
            "https://novomundo.vteximg.com.br/arquivos/ids/1115042-500-500/geladeira-refrigerador-electrolux-side-by-side-frost-free-579l-inox-dm84x-220v-50566-0.jpg?v=636512645576830000",
        title: "Geladeira Electrolux",
        desc: "Gela demais.",
        value: 9999.99,
        favorite: false),
  ];

  //SharedPreferencesApp s = SharedPreferencesApp();

  @override
  void initState() {
    super.initState();
    final sharedPreferenceApp =
        SharedPreferences.getInstance().then((SharedPreferences value) {
      final sharedPreferenceApp =
          SharedPreferences.getInstance().then((SharedPreferences value) {
        String type = value.getString("type")!;
        String token = value.getString("token")!;
        /* Busca dados do user logado */
        Connection.me(type, token).then((value) {
          setState(() {
            Map<String, dynamic> user = jsonDecode(value);
            title = "SHOPAPP. Bem vindo(a), ${user['name']}";
            urlPhoto = user['picture'];
            name = user['name'];
            email = user['email'];
            print("xxxxxxxxxxxxxxxxxxxxxxx ${user}");
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
          });
        });
        /* Busca de produtos */
        Connection.products().then((value) {
          //setState((){
          List productsListAPI = jsonDecode(value);
          for (var product in productsListAPI) {
            products.add(new Product(
                url: product['picture'],
                title: product['name'],
                //desc: product['description'],
                desc: "Descrição",
                value: double.parse(product['value'].toString()),
                favorite: false));
            //print(product['name']);
          }
          //});
        });
      });
    });
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
              buildGButton("Home", Icons.home),
              buildGButtonWithBadge("Carrinho", Icons.shopping_cart),
              buildGButton("Pagamento", Icons.attach_money),
              buildGButton("Perfil", Icons.person),
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
        return ListView(children: [
          Column(
            //coluna principal
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 300,
                height: 150,
                child: WText(
                    text: title,
                    color: Colors.teal,
                    topPadding: 20,
                    bottomPadding: 20,
                    leftPadding: 20,
                    fontHeight: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: wRowSearch(),
              ),
              //WDropDownQuantityPurchase(),
              WText(
                  text: "Mais vendidos",
                  color: Colors.teal,
                  leftPadding: 20,
                  fontHeight: 20),
              wCardProduct(products, context),
              WText(
                  text: "Produtos",
                  color: Colors.teal,
                  leftPadding: 20,
                  fontHeight: 20),
              getWidgetCardProductHorizontal(products),
            ],
          ),
        ]);
      case 1:
        CartModel cart = Provider.of<CartModel>(context);
        return Scaffold(
          body: Center(
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
                              "Total: R\$:${cart.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}",
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
                            // Navigator.pushNamed(context, '/');
                            setState(() {
                              selectedIndex = 2;
                              //badge = badge + 1;
                            });
                            controller.jumpToPage(2);
                            cart.removeAll();
                          })
                      /*ElevatedButton(
                              onPressed: , child: Text("Finalizar compra"))*/
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
                        itemBuilder: (context, index) => Padding(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    Text("cor"),
                                    Text("5 unid.")
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
                                              arguments: cart.products[index]);
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
          )),
        );

      case 2:
        return WCreditCard();

      case 3:
        //String name,
        return WProfile(urlPhoto: urlPhoto, wTextFormFieldEmail: wTextFormFieldEmail!, wTextFormFieldName: wTextFormFieldName!,) ;

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

  Row wRowSearch() {
    return Row(
      //search bar
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: WTextFormField(
              hint: "O que deseja?",
              icon: Icons.search_rounded,
              sizeIcon: 30,
            ),
            width: 250,
            height: 50,
          ),
        ),
        WButton(
          width: 50,
          height: 50,
          sizeIcon: 30,
          onTap: () async {
            var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
            var response = await http.get(url);
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
          },
        ),
      ],
    );
  }

  GButton buildGButtonWithBadge(String text, IconData icon) {
    CartModel cart = Provider.of<CartModel>(context);
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

  GButton buildGButton(String text, IconData icon) {
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
    );
  }
}

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
                              fontWeight: FontWeight.bold),
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
