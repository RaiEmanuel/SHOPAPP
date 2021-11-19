import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/connection/Connection.dart';

Widget wCardProduct(List<Product> products, BuildContext context) {
  return Container(
    height: 450,
    child: FutureBuilder(
      future: Connection.products(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Container(
            height: 300,
            child: Lottie.network("https://assets4.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json"),
          );
        if (snapshot.hasError) return Text("deu uma falhada");
        if (!snapshot.hasData) return Text("zerado");
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return WCard(products[index]);
          },
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        );
      },
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
    this.isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: 250,
        //height: 100,
        margin: EdgeInsets.only(right: 20),
        color: Colors.teal,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
          Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.network(
                  p.picture,
                  fit: BoxFit.scaleDown,
                  //width: 250,
                  //height: 250,
                ),
              ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                height: 150,
                width: 250,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        p.name,
                        style: TextStyle(
                            fontFamily: "VisbyExtraBold",
                            fontSize: 20,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "R\$ ${p.value.toString()}",
                      style: TextStyle(
                          fontFamily: "Visby",
                          fontSize: 25,
                          color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          alignment: AlignmentDirectional.topCenter,
        ),
      ),
    );
    /*Container(
      width: 300,
      height: 500,
      color: Colors.white,
      margin: EdgeInsets.only(right: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 250,
                //height: 200,
                //color: Colors.greenAccent,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    p.picture,
                    fit: BoxFit.scaleDown,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
              child: Text(
                p.name,
                style: TextStyle(
                  fontFamily: "VisbyExtraBold",
                  fontSize: 20,
                ),
              ),
              alignment: Alignment.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Text(
                      "R\$ ${p.value.toString()}",
                      style: TextStyle(
                          fontFamily: "Visby",
                          fontSize: 25,
                          color: Colors.amber),
                    ),
                    flex: 8,
                    fit: FlexFit.tight,
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                    ),
                    flex: 2,
                    fit: FlexFit.tight,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );*/
    /*Card(
        color: Colors.white70,
        //shadowColor: Colors.black26,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: 300,
              child: Column(
                //coluna geral
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 150,
                      //color: Colors.red,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          p.url,
                          fit: BoxFit.fitWidth,
                        ),
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
                      /*Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Wrap(
                            children:[WText(
                                text: p.desc,
                                color: Colors.blueGrey,
                                fontHeight: 16),],
                          ),
                      ),*/
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
                          Navigator.pushNamed(context, '/product',
                              arguments: p);
                        },
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );*/
  }
}
