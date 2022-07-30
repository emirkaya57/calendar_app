import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserDescription extends StatelessWidget {
  final String? documentId;
  const GetUserDescription({Key? key , this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['açıklama']}');
        }
        return const Text('TİTle');
      },
    );
  }
}