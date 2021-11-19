import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shoapp/connection/Connection.dart';
import 'package:shoapp/model/Feedback.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/model/User.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'package:shoapp/utils/WButton.dart';

class RouteFeedback extends StatefulWidget {
  const RouteFeedback({Key? key}) : super(key: key);

  @override
  _RouteFeedbackState createState() => _RouteFeedbackState();
}

class _RouteFeedbackState extends State<RouteFeedback> {
  List<Feedback> feedbacks = [];
  User ? meUser = null;
  String token = "null token";
  Future<void> initAsync() async {
    token = await UserSecureStorage.getToken();
    //traz dados pessoais
    meUser = await Connection.me("bearer", token);
  }

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  //Future<void> loadFeedbacks()async{
  // Connection.feedbacks(idProduct);
  //}

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    //colocar a

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Feedback de produto",
          style: TextStyle(color: Colors.teal),
        ),
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                WButton(
                  text: "Adicionar feedback",
                  width: double.infinity,
                  icon: Icons.description,
                  onTap: () {
                    Navigator.pushNamed(context, "/postfeedback",
                        arguments: product);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<FeedbackProduct>>(
                  future: Connection.feedbacks(product.id),
                  builder: (BuildContext context, AsyncSnapshot<List<FeedbackProduct>> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Lottie.network("https://assets4.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json");
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          FeedbackProduct feedback = snapshot.data![index];
                          return FutureBuilder<User>(
                            future: Connection.getUser(feedback.userId),
                              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                                  if (snapshot.hasError) {
                                  return Text("erro");
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Lottie.network("https://assets4.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json");
                                  }
                                  if (snapshot.hasData) {
                                    return FeedbackCard(user: snapshot.data!, feedback: feedback);
                                  }
                                  return Text("chegou");
                              });
                        },
                      );
                    }
                    return Text("void");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<User> getUser(int idUser)async{
  //User u = User(id: 0, credential: Credential(type: "bearer", token: "null token"), email: "", name: "user default", picture: "");
  return await Connection.getUser(idUser);//.then((value) => value);
  //return u;
}

class FeedbackCard extends StatelessWidget {
  User ? user;
  FeedbackProduct ? feedback;

  FeedbackCard({Key? key, required this.user,required this.feedback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            FeedbackBar(user: user),
            FeedbackPicture(urlProduct: feedback!.picture),
            FeedbackComment(comment: feedback!.comment, star: feedback!.star,),
          ],
        ),
      ),
    );
  }
}

class FeedbackBar extends StatelessWidget {
  User ? user;
  FeedbackBar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.teal,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 35.0,
            backgroundImage: NetworkImage(
                user!.picture),
            backgroundColor: Colors.orange,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            user!.name,
            style: TextStyle(
                color: Colors.white,
                //fontStyle: FontStyle,
                fontFamily: "Visby",
                fontSize: 25),
          )
        ],
      ),
    ); //fim do feedbackbar
  }
}

class FeedbackPicture extends StatelessWidget {
  String ? urlProduct = "";

  FeedbackPicture({Key? key, required this.urlProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.black87,
      child: (urlProduct != null) ? Image.network(
        urlProduct!,
        //height: 250,
        fit: BoxFit.fitHeight,
      ): Container(),
    );
  }
}

class FeedbackComment extends StatelessWidget {
  String ? comment = "";
  int ?star = 0;

  FeedbackComment({Key? key, required this.comment, required this.star}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      width: double.infinity,
      height: 250,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        //estrelas
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RatingBar.builder(
                initialRating: double.parse(star!.toString()),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {
                  print("ratiou = ${rating}");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                comment!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
