import 'package:flutter/material.dart';
import 'package:shoapp/widgets/WButton.dart';
import '../Product.dart';
import './WText.dart';

Widget wCardProduct(List<Product> products, BuildContext context) {
  return Container(
    height: 350,
    width: 500,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        WCard(products[0]),
        WCard(products[1]),
        WCard(products[2]),
        WCard(products[3]),
      ],
    ),
  );
}

class WCard extends StatefulWidget {
  final Product p;

  WCard(this.p);

  @override
  _WCardState createState() => _WCardState(p);
}

class _WCardState extends State<WCard> {
  bool isFavorite = false;
  Product p;

  _WCardState(this.p) {
    this.isFavorite = p.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white70,
        shadowColor: Colors.black26,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              right: 5,
              top: 10,
              child: TextButton(
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.purple,
                ),
                onPressed: () {
                  setState(() {
                    p.favorite = !p.favorite;
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
            Column(
              //coluna geral
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      p.url,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  //coluna interna
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: WText(
                            text: p.title,
                            color: Colors.blueGrey,
                            fontHeight: 20)),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: WText(
                            text: p.desc,
                            color: Colors.blueGrey,
                            fontHeight: 16)),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: WText(
                            text: "R\$ ${p.value}",
                            color: Colors.blueGrey,
                            fontHeight: 20)),
                    WButton(
                      width: 200,
                      text: "Ver Mais",
                      p: p,
                      onTap: () {
                        Navigator.pushNamed(context, '/product', arguments: p);
                      },
                      color: Colors.teal,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
