import 'package:flutter/material.dart';
import 'package:kuis/groceries.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenPage extends StatefulWidget {
  final Groceries Grocery;
  const OpenPage({Key? key, required this.Grocery}) : super(key: key);

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  bool toggle = false;
  Color change_color = Colors.blueGrey;

  favorite(toggle){
    if(toggle=true) {
      setState(() {
        change_color = Colors.orangeAccent;
      });
    }else{
      change_color = Colors.blueGrey;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: change_color,
      appBar: AppBar(
        title: Text("${widget.Grocery.name}"),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                toggle = !toggle;
                favorite(toggle);
              });
            },
            icon: (toggle)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height)/3,
            child:  ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                scrollDirection: Axis.horizontal,
                itemCount: widget.Grocery.productImageUrls.length,
                itemBuilder: (context, index){
                  return  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(widget.Grocery.productImageUrls[index],
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            fit: BoxFit.cover,)
                      )
                  );
                }
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Card(
              shape: ContinuousRectangleBorder(
                side: BorderSide(
                    color: Colors.blueGrey
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                shrinkWrap: true,
                children: [
                  Text(widget.Grocery.name,
                    style: TextStyle(
                      fontSize: 28,fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 30,width: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(widget.Grocery.description,
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                  SizedBox(height: 30,width: 30),
                  Text("Price  :  ${widget.Grocery.price}",
                    style: TextStyle(
                        fontSize: 20
                    ),),
                  SizedBox(height: 30,width: 30),
                  Text("Stock   :  ${widget.Grocery.stock}",
                    style: TextStyle(
                        fontSize: 20
                    ),),
                  SizedBox(height: 30,width: 30),
                  Text("Reviews | Average : ${widget.Grocery.reviewAverage} ",
                    style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 30,width: 30),
                  Container(
                    padding: EdgeInsets.only(right: 100,left: 100,) ,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: (){
                          _launchURL(widget.Grocery.productUrl);
                        },
                        child: Text("Go To Store")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void _launchURL(_url) async{
    if(!await launch(_url)) throw 'could not launch $_url';
  }
}
