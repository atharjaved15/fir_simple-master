import 'package:fir_simple/userPanel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class cart extends StatelessWidget {
  String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        actions: [
          RawMaterialButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => userPanel()));}

          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 10,
        toolbarHeight: 50.0,
        leadingWidth: 100,
        leading: Image(image: AssetImage('images/logo.png'),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
        ),
        title: Center(child: Text('My Cart', style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.80,
              child:
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('cart').doc(FirebaseAuth.instance.currentUser.uid).collection('products')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents = snapshot.data.docs;
                          return ListView(
                              children: documents
                                  .map((doc) => InkWell(
                                child: Container(
                                    height: 100,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          color: Colors.white.withOpacity(0.15),
                                          height: 90,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Image.network(doc['image_path']),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(doc['product id'] , textAlign:TextAlign.left , style: TextStyle(fontSize: 10, color: Colors.white, fontStyle: FontStyle.italic),),
                                                      Text(doc['name'] , textAlign:TextAlign.center, style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20, color: Colors.white),),
                                                      SizedBox(height: 5,),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 130,),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(doc['price'] + '\$'  , style: TextStyle(fontSize: 30, color: Colors.greenAccent, fontStyle: FontStyle.italic),),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )


                                      ],
                                    )),
                              )).toList());
                        } else if (snapshot.hasError) {
                          return Text('It\'s Error!');
                        }
                      }),
            ),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: getuid,
              color: Colors.deepPurple,
              child: Text('Order Now',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
          ],
        ),
      ) ,
    );
  }

   getuid() async{
     uid = await FirebaseAuth.instance.currentUser.uid.toString();
  }

  retrieveData() async{
    var ref = FirebaseFirestore.instance.collection('products').doc(uid).get();
    ref.then((value) => {
      value.data().forEach((key, value) {
        print(value);
      })
    });

}
}
