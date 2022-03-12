import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Students').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                  child:ListTile(
                title: Text("Name= ${data['Name']} Age= ${data['Age']}  Country=${data['Country']} Gender=${data['Gender']}"),
                subtitle: Text("Concentration Dstruption Score= ${data['Concentration Disruption Score']} Somatic Trait Anxiety Score= ${data['Somatic Trait Anxiety Score']} Worry Score=${data['Worry Score']}"),
              )
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
