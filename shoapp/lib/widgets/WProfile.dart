import 'package:flutter/material.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'package:shoapp/widgets/WTextFormField.dart';

class WProfile extends StatelessWidget {
  String urlPhoto;
  WTextFormField wTextFormFieldEmail, wTextFormFieldName;

  WProfile(
      {Key? key,
      required this.urlPhoto,
      required this.wTextFormFieldEmail,
      required this.wTextFormFieldName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30,
        ),
      ),
      body: Column(
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
                    color: Colors.teal,
                  )),
              Positioned(
                bottom: -80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    urlPhoto,
                  ),
                  radius: 80,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: wTextFormFieldEmail),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: wTextFormFieldName),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: WButton(
                    text: "Ver minhas compras",
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      Navigator.pushNamed(context, "/mypurchases");
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
