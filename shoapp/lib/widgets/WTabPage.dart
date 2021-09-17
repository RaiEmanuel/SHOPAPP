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

  List<Color> colors = [
    //Color(0xFFEEEEEE),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0)
  ];

  List<Product> products = [
    new Product(
        url: "assets/product1.png",
        title: "PLACA NVIDIA 5432X",
        desc: "Ideal para seus jogos",
        value: 5899.99,
        favorite: true),
    new Product(
        url: "assets/product2.png",
        title: "TÊNIS NIKE AIR PLUS",
        desc: "Mais conforto para seu esporte",
        value: 1359.99,
        favorite: false),
    new Product(
        url: "assets/product3.png",
        title: "XBOX MAX",
        desc: "Mais desempenho e qualidade",
        value: 12899.99,
        favorite: true),
    new Product(
        url: "assets/moyses.jpg",
        title: "Livro Moyses",
        desc: "Livro de qualidade",
        value: 79.99,
        favorite: true),
  ];

  @override
  void initState() {
    super.initState();
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
              /*
              GButton(
                gap: gap,
                iconActiveColor: Colors.teal,
                iconColor: Colors.teal,
                textColor: Colors.teal,
                backgroundColor: Colors.teal.withOpacity(.2),
                iconSize: 24,
                padding: padding,
                icon: LineIcons.user,
                leading: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(
                    'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
                  ),
                ),
                text: 'Sheldon',
              )
               */
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
              /*Lottie.network(
                  "https://assets4.lottiefiles.com/private_files/lf30_x2lzmtdl.json",
                  width: 200,
                  height: 200
                ),*/
              Container(
                width: 300,
                height: 150,
                child: WText(
                    text: "Ecommerce, tudo o que você procura",
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
              WText(
                  text: "Mais vendidos",
                  color: Colors.teal,
                  leftPadding: 20,
                  fontHeight: 20),
              wCardProduct(products, context)
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
                              /*boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 8,
                              spreadRadius: 1,
                          ),
                        ],*/
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
                                  child: Image.asset(
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
        return Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: double.infinity,
                    height: 200,
                    child: Text("s"),
                    decoration: BoxDecoration(
                      /* borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0)),*/
                      color: Colors.teal,
                    )),
                Positioned(
                  bottom: -80,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
                    ),
                    radius: 80,
                  ),
                )
              ],
            )
          ],
        );
      default:
        return body;
    }
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
      /*
      leading: selectedIndex == 1 || badge == 0
                        ? null
                        : Badge(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                            position: BadgePosition.topEnd(top: -12, end: -12),
                            badgeContent: Text(
                              badge.toString(),
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            child: Icon(
                              LineIcons.heart,
                              color: selectedIndex == 1
                                  ? Colors.pink
                                  : Colors.black,
                            ),
                          ),
                    text: 'Likes',
                  ),


       */
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

      /*
      leading: selectedIndex == 1 || badge == 0
                        ? null
                        : Badge(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                            position: BadgePosition.topEnd(top: -12, end: -12),
                            badgeContent: Text(
                              badge.toString(),
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            child: Icon(
                              LineIcons.heart,
                              color: selectedIndex == 1
                                  ? Colors.pink
                                  : Colors.black,
                            ),
                          ),
                    text: 'Likes',
                  ),
       */
    );
  }
}
