import 'dart:convert';

import 'package:People/Models/user_model.dart';
import 'package:People/details_show.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:People/Models/ProductsModel.dart';
class Home_Screen_Four extends StatefulWidget {
  const Home_Screen_Four({Key? key}) : super(key: key);

  @override
  State<Home_Screen_Four> createState() => _Home_Screen_FourState();
}

class _Home_Screen_FourState extends State<Home_Screen_Four> {

  ScrollController _scrollController = ScrollController();
  String? name, email, address;
  int? id;
  List<String> picURL = [
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1370750/pexels-photo-1370750.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/4906334/pexels-photo-4906334.jpeg?auto=compress&cs=tinysrgb&w=600'
  ,'https://images.pexels.com/photos/1153334/pexels-photo-1153334.jpeg?auto=compress&cs=tinysrgb&w=600'
  ,'https://images.pexels.com/photos/2690774/pexels-photo-2690774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/3344325/pexels-photo-3344325.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/3778361/pexels-photo-3778361.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/4040906/pexels-photo-4040906.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/4255392/pexels-photo-4255392.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/774098/pexels-photo-774098.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2460227/pexels-photo-2460227.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/3775156/pexels-photo-3775156.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1484810/pexels-photo-1484810.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/634021/pexels-photo-634021.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/3779760/pexels-photo-3779760.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'


  ];
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Dashboard"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){

        _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

      },child:Icon(Icons.arrow_upward),backgroundColor: Colors.teal,),
      body: Column(

        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }else{

                    print("UserList Length: "+userList.length.toString());
                    print("picURL Length: "+picURL.length.toString());
                    return ListView.builder(
                      controller: _scrollController,
                        itemCount:picURL.length,
                        itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              name = snapshot.data![index].name.toString();
                              email = snapshot.data![index].email.toString();
                              address = snapshot.data![index].address!.street.toString() +", "+snapshot.data![index].address!.city.toString();;
                              id = index;
                              print("Name: "+name.toString()+"\nEmail: "+email.toString()+"\nAddress: "+address.toString()+"\nIndex: "+id.toString());


                              Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailShowing(
                                n: name,e: email,a: address,i: id,url: picURL[index],
                              )));
                            },

                            child: Card(
                              color: Colors.grey.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ContainerWidget(imgUrl: picURL[index]),
                                   Column(
                                     children: [
                                       RowWidget(title: "Name", value: snapshot.data![index].name.toString()),
                                       RowWidget(title: "Email", value: snapshot.data![index].email.toString()),
                                       RowWidget(title: "Address", value: snapshot.data![index].address!.street.toString(),)
                                     ],
                                   )
                                  ],

                                  ),),
                          ),
                        );
                    });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  String imgUrl = '';

  ContainerWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
              image: DecorationImage(
            image: NetworkImage(imgUrl),
                fit: BoxFit.cover
        ),
          borderRadius: BorderRadius.circular(10)
        ),

    );
  }
}

class RowWidget extends StatelessWidget {
  String  title, value = '';
  RowWidget({Key? key,required this.title, required this.value,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Text(title+":", style: TextStyle(fontWeight: FontWeight.bold),),
          Text(value , overflow: TextOverflow.clip,)

        ],
      ),
    );
  }
}

