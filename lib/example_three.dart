import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:People/Models/user_model.dart';

void main() {
  runApp(Home_Screen_Three());
}

class Home_Screen_Three extends StatefulWidget {
  const Home_Screen_Three({Key? key}) : super(key: key);

  @override
  State<Home_Screen_Three> createState() => _Home_Screen_ThreeState();
}

class _Home_Screen_ThreeState extends State<Home_Screen_Three> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Api Course",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: [
            Expanded(

              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                ),

                                color: Colors.yellow,
                                child: Column(
                                  children: [
                                    RowWidget(title: "Name:", value: snapshot.data![index].name.toString()),
                                    RowWidget(title: "UserName:", value: snapshot.data![index].username.toString()),
                                    RowWidget(title: "Email:", value: snapshot.data![index].email.toString()),
                                    RowWidget(title: "Address:", value: snapshot.data![index].address!.street.toString() +", "+
snapshot.data![index].address!.city.toString() ,

                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
class RowWidget extends StatelessWidget {
  String title, value;
  RowWidget({Key? key, required this.title,required this.value,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(value)
        ],
      ),
    );
  }
}
