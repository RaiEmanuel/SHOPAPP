import 'package:flutter/material.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/routes/tabpage/RouteHome/widget/WCardproduct.dart';
import 'package:shoapp/utils/WTextFormField.dart';
import 'package:shoapp/utils/WButton.dart';
import 'package:shoapp/utils/WText.dart';

class Home extends StatefulWidget {
  List<Product> products = [];
  String title = "Shopapp";
  Home({Key? key, required this.products, required this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class WRowSearch extends StatelessWidget {
  const WRowSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              text: "",
              sizeIcon: 30,
              onTap: () async {},
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              text: widget.title,
              color: Colors.teal,
              topPadding: 20,
              //bottomPadding: 20,
              leftPadding: 20,
              fontHeight: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: WRowSearch(),
          ),
          SizedBox(
            height: 20,
          ),
          WText(
              text: "Mais vendidos",
              color: Colors.teal, leftPadding: 20, fontHeight: 20),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: wCardProduct(widget.products, context),
          ),
          SizedBox(
            height: 20,
          ),
          WText(
              text:"Produtos",
              color: Colors.teal, leftPadding: 20, fontHeight: 20),
          SizedBox(
            height: 20,
          ),
          //getWidgetCardProductHorizontal(products),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              childAspectRatio: 0.7,
            ),
            itemCount: widget.products.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/product",
                      arguments: widget.products[index]);
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  //coluna principal
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                widget.products[index].picture,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: WText(
                            color: Colors.black,
                            text:  widget.products[index].name,
                            fontHeight: 18,
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          child: WText(
                            color: Colors.amber,
                            fontHeight: 18,
                            text: "R\$ ${widget.products[index].value.toString()}",
                          ),
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}