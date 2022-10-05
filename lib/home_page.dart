import 'package:flutter/material.dart';
import 'package:kuis/groceries.dart';
import 'package:kuis/openpage.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
          itemBuilder: (context, index){
            final Groceries groceries = groceryList[index];
            return InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OpenPage(Grocery: groceries);
              }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 150,vertical: 50),
                child: Card(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    children: [
                      Image.network(groceries.productImageUrls[0],),
                      Text(groceries.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontFamily:'Calibri' ,
                          fontSize: 18,
                        ) ,
                      ),
                      Text(groceries.price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontFamily:'Calibri' ,
                          fontSize: 18,
                        ) ,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        itemCount: groceryList.length,
      ),
    );
  }
}
