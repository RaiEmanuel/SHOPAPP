import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapp/routes/RouteProduct/RouteProduct.dart';
import 'package:shoapp/utils/ColorApi.dart';
import 'package:shoapp/utils/WButton.dart';
import 'package:shoapp/utils/WTextFormField.dart';
import 'package:shoapp/utils/WText.dart';
import 'package:shoapp/pCartModel.dart' as MyCart;
import 'package:shoapp/utils/WidgetColorSelector.dart';

class RouteCart extends StatefulWidget {
  MyCart.PCartModel cart;
  Function () onTapButton;
  RouteCart({required this.cart, required this.onTapButton, Key? key}) : super(key: key);

  @override
  _RouteCartState createState() => _RouteCartState();
}

class _RouteCartState extends State<RouteCart> {
  @override
  Widget build(BuildContext context) {
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
                          text: "Total: R\$:${widget.cart.totalPrice.toStringAsFixed(2).replaceAll(".", ",")}",
                          color: Colors.white,
                          fontHeight: 22),
                      flex: 5,
                    ),
                    Expanded(
                      child: WButton(
                        text: "Comprar",
                        color: Colors.white,
                        colorText: Colors.teal,
                        colorIcon: Colors.teal,
                        onTap: widget.onTapButton,
                        icon: Icons.shopping_cart,
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
                itemCount: widget.cart.getQuantity(),
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
                            child: Image.network(widget.cart.products[index].url),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  widget.cart.products[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Quantidade: ${widget.cart.products[index].quantity.toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                //o que importa é a cor
                                WidgetColorSelector(
                                    colorAPI: ColorAPI(
                                        id: 0,
                                        color: widget.cart.products[index].getColor(),
                                        name: "default"),
                                ),
                              ],
                            ),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.redAccent,
                            child: IconButton(icon: Icon(Icons.delete), color: Colors.white, onPressed: (){
                              //MyCart.PCartModel cart = Provider.of<MyCart.PCartModel>(context);
                              widget.cart.remove(widget.cart.products[index]);
                            },
                            ),
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
    );
  }
}
