import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoapp/connection/Connection.dart';
import 'package:shoapp/model/Feedback.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/model/User.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'package:shoapp/utils/WButton.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoapp/utils/WTextFormField.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RoutePostFeedback extends StatefulWidget {
  const RoutePostFeedback({Key? key}) : super(key: key);

  @override
  _RouteFeedbackState createState() => _RouteFeedbackState();
}

class _RouteFeedbackState extends State<RoutePostFeedback> {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  ImagePicker imagePicker = ImagePicker();
  var imageFile;
  String token = "null token";
  User? meUser = null;
  int rate = 3;

  Future<void> initAsync() async {
    token = await UserSecureStorage.getToken();
    //traz dados pessoais
    meUser = await Connection.me("bearer", token);
  }

  @override
  void initState() {
    super.initState();
    rate = 3;
    initAsync();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final _formKey = GlobalKey<FormState>();
    final controllerComment = TextEditingController();
    WTextFormField fieldDescription = WTextFormField(
      label: "Descrição",
      icon: Icons.text_format_outlined,
      hint: "Digite a descrição do feedback",
    );

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
      body: Form(
        key: _formKey,
        child: ListView(
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
                    child: fieldDescription,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print("ratiou = ${rating}");
                rate = rating.round();
              },
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
                        child: Icon(Icons.landscape,
                            color: Colors.white, size: 80),
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
              text: "Adicionar feedback",
              icon: Icons.description,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (imageFile != null) {
                    if (meUser != null) {
                      print("comentario do form ${fieldDescription.getText()}");
                      FeedbackProduct feedback = FeedbackProduct(
                          userId: meUser!.id,
                          productId: product.id,
                          picture: "",
                          //ajustado no futuro quando subir para o storage
                          star: rate,
                          comment: fieldDescription.getText());
                      uploadStorage(product, feedback);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Feedback resgitrado com sucesso!"),
                        ),
                      );
                      setState(() {
                        imageFile = null;
                      });
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Feedback Não cadastrado!"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
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
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.front,
    );

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

  Future<void> uploadStorage(
      Product product, FeedbackProduct feedbackProduct) async {
    Reference root = _firebaseStorage.ref();
    Reference file = root
        .child(product.id.toString())
        .child("photos")
        .child(DateTime.now().toString());

    UploadTask task = file.putFile(imageFile);

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
      } else if (taskSnapshot.state == TaskState.success) {
        getUrlUploadedPhoto(taskSnapshot).then((value) {
          print("url a salvar = ${value}");
          feedbackProduct.picture = value;
          Connection.postFeedback(token, feedbackProduct);
        });
      } else if (taskSnapshot.state == TaskState.error) {}
    });
  }

  Future<String> getUrlUploadedPhoto(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
