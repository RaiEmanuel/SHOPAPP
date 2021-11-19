import 'package:flutter/material.dart';
import 'package:shoapp/connection/Connection.dart';
import 'package:shoapp/model/User.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'package:shoapp/utils/WButton.dart';
import 'package:shoapp/utils/WTextFormField.dart';

class RouteProfile extends StatefulWidget {
  //const RouteProfile({Key? key}) : super(key: key);

  RouteProfile({Key? key}) : super(key: key);

  @override
  _RouteProfileState createState() => _RouteProfileState();
}

class _RouteProfileState extends State<RouteProfile> {
  String urlPhoto = "http://simpleicon.com/wp-content/uploads/user1.svg";
  WTextFormField wTextFormFieldEmail = WTextFormField(
        label: "Email",
        icon: Icons.alternate_email,
        keyboardType: TextInputType.text,
        isActive: false,
      ),
      wTextFormFieldName = WTextFormField(
        icon: Icons.drive_file_rename_outline,
        label: "Nome",
        keyboardType: TextInputType.text,
        isActive: false,
      );
  bool selected = false;

  void initStateAsync() async {
    String token = await UserSecureStorage.getToken();
    //traz dados pessoais
    User meUser = await Connection.me("bearer", token);
    setState(() {
      urlPhoto = meUser.picture;
      wTextFormFieldEmail.setText(meUser.email);
      wTextFormFieldName.setText(meUser.name);
    });
  }

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

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
                height: selected ? 250 : 200,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
              Positioned(
                bottom: selected ? -120 : -80,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      urlPhoto,
                    ),
                    radius: selected ? 120 : 80,
                  ),
                  curve: Curves.elasticInOut,
                ),
              ),
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: WButton(
                    text: "Ver minhas compras",
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      Navigator.pushNamed(context, "/mypurchases");
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: WButton(
                    text: selected ? "Diminuir foto":"Ampliar foto",
                    width: MediaQuery.of(context).size.width,
                    icon: selected ? Icons.photo_size_select_actual : Icons.photo_size_select_large,
                    onTap: () {
                      setState(() {
                        selected = !selected;
                      });
                      print("uuuuuuuuuuuuuuuuuuu");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
