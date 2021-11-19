import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/routes/tabpage/widget/WidgetCardHorizontal.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'RouteHome/RouteHome.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoapp/connection/Connection.dart';
import 'package:shoapp/model/Address.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shoapp/utils/WButton.dart';
import 'package:shoapp/pCartModel.dart' as MyCart;
import 'package:shoapp/routes/tabpage/RouteCart/RouteCart.dart';
import 'RouteProfile/RouteProfile.dart';
import 'package:shoapp/controller/ControllerRouteTabPage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class RouteTabPage extends StatefulWidget {
  @override
  _RouteTabPageState createState() => _RouteTabPageState();
}

class _RouteTabPageState extends State<RouteTabPage> {
  int selectedIndex = 0;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;
  PageController controller = PageController();
  String title = "";
  ControllerRouteTabPage controllerRouteTabPage = ControllerRouteTabPage();

  List<Color> colors = [
    //Color(0xFFEEEEEE),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0)
  ];

  List<Product> products = [];

  void initAsync() async {

    List<Product> listProduct = await Connection.products();
    //List productsListAPI = jsonDecode(productsJson);
    setState(
      () {
        for (Product product in listProduct) {
          products.add(product);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    title = "Shopapp";
    initAsync();
    /* Inicializa campos do perfil */
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



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        return Home(products: products,title: title,);
      case 1:
        MyCart.PCartModel cart = Provider.of<MyCart.PCartModel>(context);
        return RouteCart(cart: cart, onTapButton: () {
          setState(() {
            selectedIndex = 2;
          });
          controller.jumpToPage(2);
        });
      case 2:
        MyCart.PCartModel cartModel = Provider.of<MyCart.PCartModel>(context);
        return WCreditCard(cartModel: cartModel);

      case 3:
        //String name,
        return RouteProfile( );

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
        title: Text("Compra",
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
                      child: WButton(text: "Selecionar endereço",
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
                      child: WButton( text: "FINALIZAR COMPRA",
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

/* ********************************* */

