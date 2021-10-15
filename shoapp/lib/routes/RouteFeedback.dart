import 'package:flutter/material.dart';
import 'package:shoapp/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoapp/widgets/WButton.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';

import 'package:shoapp/widgets/WTextFormField.dart';

class RouteFeedback extends StatefulWidget {
  const RouteFeedback({Key? key}) : super(key: key);

  @override
  _RouteFeedbackState createState() => _RouteFeedbackState();
}

class _RouteFeedbackState extends State<RouteFeedback> {
  ImagePicker imagePicker = ImagePicker();
  var imageFile;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("Cadastro de feedback", style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            //width: MediaQuery.of(context).size.width,
            //height: 80,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: WTextFormField(
                    label: "Descrição",
                    icon: Icons.text_format_outlined,
                    hint: "Digite a descrição do feedback",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Seleção de foto",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _onClickCameraImagem,
                    child: Container(
                      color: Colors.teal,
                      child: Icon(Icons.add_a_photo,
                          color: Colors.white, size: 80),
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _onClickGaleriaImagem,
                    child: Container(
                      color: Colors.blueGrey,
                      child:
                          Icon(Icons.landscape, color: Colors.white, size: 80),
                    ),
                  ),
                  flex: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            color: Colors.greenAccent,
            child: _image(),
          ),
          SizedBox(
            height: 30,
          ),
          WButton(
            icon: Icons.description,
            text: "Adicionar feedback",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Feedback resgitrado com sucesso!"),
                ),
              );
              setState(() {
                imageFile = null;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Feedbacks",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [

                Container(
                  width: 200,
                  height: 200,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Text("Arrascaeta Portaluppi"),
                      Image.network(
                        "https://mobilidadesampa.com.br/wp-content/uploads/2021/07/Celular-na-mao.jpg",
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Text("Maria Leite"),
                      Image.network(
                        "https://imagens.mdig.com.br/thbs/43887mn.jpg",
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Text("João Lima"),
                      Image.network(
                        "https://i1.wp.com/ihelpbr.com/wp-content/uploads/2020/12/Review-iPhone-12-Pro-Max-020-scaled.jpg?ssl=1",
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,)
        ],

      ),
    );
  }

  Widget _image() {
    if (imageFile != null) {
      return Image.file(
        imageFile,
        height: 400,
        fit: BoxFit.scaleDown,
      );
    } else {
      return Lottie.network(
          "https://assets3.lottiefiles.com/private_files/lf30_fko1tu3z.json");
    }
  }

  // EVENTOS
//----------------------------------------------------------------------------
  void _onClickCameraImagem() async {
    XFile? xf = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
        // 1-100
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      this.imageFile = File(xf!.path);
    });
  }

  void _onClickGaleriaImagem() async {
    XFile? f = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.imageFile = File(f!.path);
    });
  }
}
